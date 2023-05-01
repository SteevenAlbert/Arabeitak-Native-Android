var World = {
    loaded: false,
    drawables: [],
    lights: [],
    steps:[],
    firetruckRotation: {
        x: 0,
        y: 0,
        z: 0
    },
    firetruckCenter: {
        x: 0,
        y: -0.14,
        z: 0
    },
    firetruckLength: 0.33,
    firetruckHeight: 0.2,
    snapped: false,
    interactionContainer: 'snapContainer',
    layout: {
        normal: {
            name: "normal",
            offsetX: 0.35,
            offsetY: 0.45,
            opacity: 1.0,
            carScale: 2.5,
            carTranslateX: -0.3,
            carTranslateY: 0.5,
            carTranslateZ: 0.2,
        },
        snapped: {
            name: "snapped",
            offsetX: 0.45,
            offsetY: 0.45,
            opacity: 0.2,
            carScale: 5,
            carTranslateX: -0.89,
            carTranslateY: 0,
            carTranslateZ: 0,
        }
    },
    previousScaleValue: 0,

    previousTranslateValueSnap: {
        x: 0,
        y: 0
    },
    defaultScale: 0,
    init: function initFn() {
      
        World.createOccluder();
        World.createCap();
        World.createJerrycan();
        World.createBtn({
            translate: {
                x: 0,
                z: 0.5,
               
            }
        });
        World.createOpenCapAnimation();
        World.createPouringAnimation();
        World.createStopPouringAnimation();
        World.createCloseCapAnimation();
        World.createTracker();

    },

    createOccluder: function createOccluderFn() {
        var occluderScale = 0.0065 * this.firetruckLength;

        this.firetruckOccluder = new AR.Occluder("assets/firetruck_occluder.wt3", {
            onLoaded: World.showInfoBar,
            scale: {
                x: occluderScale,
                y: occluderScale,
                z: occluderScale
            },
            translate: this.firetruckCenter,
            rotate: {
                x: 180
            },
            onError: World.onError
        });

        World.drawables.push(this.firetruckOccluder);
    },

    createCap: function createCapFn() {
        this.cap = World.getCap();
        World.drawables.push(this.cap);
    },

    getCap: function getCapFn() {
        var capScale = 0.003 * this.firetruckLength;
        return new AR.Model("assets/cap.wt3", {
            scale: {
                x: capScale,
                y: capScale,
                z: capScale
            },
            translate: {
                x: -this.firetruckLength * 0.8,
                y: 0,
                z: 0.2
            },
            rotate: {
                x: -90
            },
            onError: World.onError,

        });
    },

    createJerrycan: function createJerrycanFn() {
        this.jerrycan = World.getJerrycan();
        World.drawables.push(this.jerrycan);
    },

    getJerrycan: function getJerrycanFn() {
        var jerrycanScale = 1.0 * this.firetruckLength;
        return new AR.Model("assets/jerrycan.wt3", {
            scale: {
                x: jerrycanScale,
                y: jerrycanScale,
                z: jerrycanScale
            },
            translate: {
                x: this.firetruckLength * 0.3,
                y: 0,
                z: 0.2
            },
            rotate: {
                x: -90
            },
            onClick: function (scale) {
                // World.runMainAnimation();

            },
            onError: World.onError
        });
    },

    createOpenCapAnimation: function createOpenCapAnimationFn() {
        var animationDuration = 2000;

        //var capRotationAnimationY = new AR.PropertyAnimation(this.cap, "rotate.y", 0, 360, animationDuration);
        var capRotationAnimationX = new AR.PropertyAnimation(this.cap, "rotate.x", -90, -180, animationDuration);
        // capRotationAnimationX.start();
        World.steps.push(capRotationAnimationX);
    },

    createPouringAnimation: function createPouringAnimationFn() {
        var animationDuration = 2000;
        var jerrycanRotationAnimationDown = new AR.PropertyAnimation(this.jerrycan, "rotate.z", 0, 45, animationDuration);
        
        // jerrycanRotationAnimationDown.start();
        World.steps.push(jerrycanRotationAnimationDown);
    },

    createStopPouringAnimation: function createStopPouringAnimationFn() {
        var animationDuration = 2000;

        var jerrycanRotationAnimationUp = new AR.PropertyAnimation(this.jerrycan, "rotate.z", 45, 0, animationDuration);

        World.steps.push(jerrycanRotationAnimationUp);
    },

    createCloseCapAnimation: function createCloseCapAnimationFn() {
        var animationDuration = 2000;

        var capRotationAnimationX = new AR.PropertyAnimation(this.cap, "rotate.x", -180, -90, animationDuration);

        World.steps.push(capRotationAnimationX);
    },

    createTracker: function createTrackerFn() {
        this.targetCollectionResource = new AR.TargetCollectionResource("assets/firetruck.wto", {
            onError: World.onError
        });

        this.tracker = new AR.ObjectTracker(this.targetCollectionResource, {
            onError: World.onError
        });

        this.objectTrackable = new AR.ObjectTrackable(this.tracker, "*", {
            drawables: {
                cam: World.drawables
            },
            onObjectRecognized: World.objectRecognized,
            onObjectLost: World.objectLost,
            onError: World.onError
        });
        World.instructionWidget = new AR.HtmlDrawable({
            uri: "assets/instruction.html"
        }, 0.25, {
            viewportWidth: 500,
            viewportHeight: 700,
            onClick: World.toggleSnapping,
            onError: World.onError,
            scale: {
                x: 2.5,
                y: 2.5,
                z: 2.5
            },
            translate: {
                x: -this.firetruckLength * 0.9,
                y: this.firetruckHeight * 2.5,
                z: 0.2
            },
            rotate: {
                x: -0.6
            },
            horizontalAnchor: AR.CONST.HORIZONTAL_ANCHOR.RIGHT,
            verticalAnchor: AR.CONST.VERTICAL_ANCHOR.TOP,
            // allowDocumentLocationChanges: true
        });
       
        this.objectTrackable2 = new AR.ObjectTrackable(this.tracker, "*", {
            drawables: {
                cam: World.instructionWidget
            },
            snapToScreen: {
                snapContainer: document.getElementById('snapContainer')
            },
            onObjectRecognized: World.objectRecognized,
            onObjectLost: World.objectLost,
            onError: World.onError
        });

    },


    createBtn: function createBtnFn(options) {
        step=0;
        var btn = new AR.ImageResource("assets/nextbtn2.png", {
            onError: World.onError
        });

        options.onClick = function () {
            World.steps[step].start();
            World.instructionWidget.evalJavaScript("var step = document.getElementById('step"+step+"'); step.style.backgroundColor = '#90EE90'; step.style.color= 'white'; console.log(step.style.backgroundColor);");
            step++;
            if(step==World.steps.length){
              
               
            }
        }
        var overlayOne = new AR.ImageDrawable(btn, 0.1, options)

        World.drawables.push(overlayOne);
    },

    objectRecognized: function objectRecognizedFn() {
        World.hideInfoBar();
        World.setAugmentationsEnabled(true);
    },

    objectLost: function objectLostFn() {
        World.setAugmentationsEnabled(false);
    },

    setAugmentationsEnabled: function setAugmentationsEnabledFn(enabled) {
        for (var i = 0; i < World.drawables.length; i++) {
            World.drawables[i].enabled = enabled;
        }
    },

    toggleSnapping: function toggleSnappingFn() {

        World.snapped = !World.snapped;
        World.objectTrackable2.snapToScreen.enabled = World.snapped;

        if (World.snapped) {
            World.applyLayout(World.layout.snapped);

        }
        else {
            World.applyLayout(World.layout.normal);
        }
    },
    applyLayout: function applyLayoutFn(layout) {


        World.instructionWidget.scale = {
            x: layout.carScale,
            y: layout.carScale,
            z: layout.carScale
        };

        World.defaultScale = layout.carScale;

        World.instructionWidget.translate = {
            x: layout.carTranslateX,
            y: layout.carTranslateY,
            z: layout.carTranslateZ
        };
        if (layout.name == "normal") {
            World.instructionWidget.translate = {
                x: layout.carTranslateX,
                y: layout.carTranslateY,
                z: layout.carTranslateZ
            };
            World.instructionWidget.rotate = {
                z: layout.rotateZ
            };
        }
    },
    onError: function onErrorFn(error) {
        alert(error);
    },

    hideInfoBar: function hideInfoBarFn() {
        document.getElementById("infoBox").style.display = "none";
    },

    showInfoBar: function worldLoadedFn() {
        document.getElementById("infoBox").style.display = "table";
        document.getElementById("loadingMessage").style.display = "none";
    }
};

World.init();