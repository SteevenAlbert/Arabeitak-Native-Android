var World = {
    //Initial Variables
    loaded: false,
    drawables: [],
    lights: [],
    steps:[],
    audio:[],
    snapped: false,
    interactionContainer: 'snapContainer',
    defaultScale: 0,

    init: function initFn(){
        World.createBox();
        World.createBoxAnimation();
        World.createRedArrow();
        World.createRedArrowAppearingAnimation();
        World.createBtn({
                    translate: {
                        x: 0,
                        z: 0.5,
                    }
                });
        World.createAudio();
        World.createTracker();
    },

    /******************/
    /* LOAD 3D ASSETS */
    /******************/
    createRedArrow: function createRedArrowFn(){
        var arrowScale = 0.003
            this.RedArrow = new AR.Model("assets/Arrow-RED-OP.wt3",{
                scale: {
                    x: arrowScale,
                    y: arrowScale,
                    z: arrowScale
                },
              rotate: {
                 x: 0.0,
                 y: 90.0,
                 z: 180
               },
             translate: {
                   x: -1.5,
                   y: 0.5,
                   z: 0.7
               },
                enabled: false,
                onError: World.onError
            });
            World.drawables.push(this.RedArrow);
        },

        createBox: function createBoxFn(){
            var boxScale = 0.002
                this.Box = new AR.Model("assets/Box.wt3",{
                    scale: {
                        x: boxScale,
                        y: boxScale,
                        z: boxScale
                    },
                  rotate: {
                     x: 270,
                     y: 90.0,
                     z: 0
                   },
                 translate: {
                       x: -0.409,
                       y: 0.564,
                       z: -0.101
                   },
                    enabled: true,
                    onError: World.onError
                });
                World.drawables.push(this.Box);
            },

    /******************/
    /* CREATE TRACKER */
    /******************/
  createTracker: function createTrackerFn() {
        this.targetCollectionResource = new AR.TargetCollectionResource("assets/toyota_battery_obj.wto", {
            onError: World.onError
        });

          this.tracker = new AR.ObjectTracker(this.targetCollectionResource, {

                          onError: World.onError
                      });

      this.Toyota = new AR.ObjectTrackable(this.tracker, "*", {
                        drawables: {
                            cam: World.drawables
                        },
                         onObjectRecognized: World.hideInfoBar,
                         onError: World.onError
                     });

        World.instructionWidget = new AR.HtmlDrawable({
            uri: "assets/instruction.html"
        },0.25, {
            viewportWidth: 500,
            viewportHeight: 500,
            opacity:0.8,
//            onClick: World.toggleSnapping,
            onError: World.onError,
              onDragBegan: function(xNormalized , yNormalized ) {
                    if(yNormalized<0){
                        World.scrollSteps(100);
                    }else{
                        World.scrollSteps(-100);
                    }
              },
            onScaleEnded: World.toggleSnapping,
            scale: {
                x: 12,
                y: 12,
                z: 12
            },
            translate: {
                x: 1.5,
                y: 0,
                z: 1
            },
            rotate: {
                x:180,
                y:180,
                z:180
            },
//            horizontalAnchor: AR.CONST.HORIZONTAL_ANCHOR.RIGHT,
//            verticalAnchor: AR.CONST.VERTICAL_ANCHOR.TOP,
            allowDocumentLocationChanges: true,
            clickThroughEnabled: true,
            mirrored:true,
            zOrder:99
        });

        this.objectTrackable2 = new AR.ObjectTrackable (this.tracker, "*", {
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
    /********************/
    /* CREATE ANIMATION */
    /********************/
    createBoxAnimation: function createBoxAnimationFn() {
       animationDuration=2000
     var boxTranslationAnimation1 = new AR.PropertyAnimation(
                World.Box,
                "translate.y",
                0,
                0.5 + 1, animationDuration, {}
            );
        var animationGroup = new AR.AnimationGroup(
                    AR.CONST.ANIMATION_GROUP_TYPE.SEQUENTIAL, [boxTranslationAnimation1]
                );
        var emptyAnimationGroup = new AR.AnimationGroup(
                            AR.CONST.ANIMATION_GROUP_TYPE.SEQUENTIAL, []
                        );
        //animationGroup.start()
        World.steps.push(animationGroup)
    },
    createRedArrowAppearingAnimation: function createRedArrowAppearingAnimationFn(){
        animationDuration = 1500;
        var sx = new AR.PropertyAnimation(World.RedArrow, "scale.x", 0, 0.003, animationDuration, {
        type: AR.CONST.EASING_CURVE_TYPE.EASE_OUT_QUAD
        });

        var sy = new AR.PropertyAnimation(World.RedArrow, "scale.y", 0, 0.003, animationDuration, {
        type: AR.CONST.EASING_CURVE_TYPE.EASE_OUT_QUAD
        });

        var sz = new AR.PropertyAnimation(World.RedArrow, "scale.z", 0, 0.003, animationDuration, {
        type: AR.CONST.EASING_CURVE_TYPE.EASE_OUT_QUAD
        });


        var isx = new AR.PropertyAnimation(World.RedArrow, "scale.x", 0.003, 0, animationDuration, {
        type: AR.CONST.EASING_CURVE_TYPE.EASE_OUT_QUAD
        });

        var isy = new AR.PropertyAnimation(World.RedArrow, "scale.y", 0.003, 0, animationDuration, {
        type: AR.CONST.EASING_CURVE_TYPE.EASE_OUT_QUAD
        });

        var isz = new AR.PropertyAnimation(World.RedArrow, "scale.z", 0.003, 0, animationDuration, {
        type: AR.CONST.EASING_CURVE_TYPE.EASE_OUT_QUAD
        });

        var appearingAnimationGroup = new AR.AnimationGroup(
                            AR.CONST.ANIMATION_GROUP_TYPE.PARALLEL, [sx,sy,sz]
                        );
        var disappearingAnimationGroup = new AR.AnimationGroup(
                                    AR.CONST.ANIMATION_GROUP_TYPE.PARALLEL, [isx,isy,isz]
                                );

        var emptyAnimationGroup = new AR.AnimationGroup(
                                    AR.CONST.ANIMATION_GROUP_TYPE.PARALLEL, []
                                );

        World.steps.push(appearingAnimationGroup);
        World.steps.push(disappearingAnimationGroup);
        World.steps.push(emptyAnimationGroup);
        World.steps.push(emptyAnimationGroup);
        World.steps.push(emptyAnimationGroup);

    },

    /********************/
    /* CREATE AUDIO */
    /********************/
    createAudio: function createAudioFunction(){
        for (var i = 1; i <= 7; i++) {
            var stepVO = new AR.Sound("assets/audio/Step_" + i + "_VO.mp3");
            World.audio.push(stepVO);
        }
    },

    /******************/
    /*   UI Elements  */
    /******************/
    createBtn: function createBtnFn(options) {
        step=0;
        var btn = new AR.ImageResource("assets/nextbtn2.png", {
            onError: World.onError

        });

        options.onClick = function () {
            if(step==1){
                World.RedArrow.enabled = true;
                World.Box.enabled = false;
            };
            World.steps[step].start();
            World.audio[step].play();
            World.instructionWidget.evalJavaScript("var step = document.getElementById('step"+step+"'); step.style.backgroundColor = '#90EE90'; step.style.color= 'white'; console.log(step.style.backgroundColor);");
            step++;
            if(step==World.steps.length){
            }
        }
        var overlayOne = new AR.ImageDrawable(btn, 0.5, options)
        World.drawables.push(overlayOne);
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

     scrollSteps: function ScrollStepsFn(pixels){
        World.instructionWidget.evalJavaScript("document.getElementById('main').scrollBy(0,"+pixels+");");
       World.instructionWidget.evalJavaScript("console.log('Scrolled!')");
     },

        applyLayout: function applyLayoutFn(layout) {
            World.instructionWidget.scale = {
                x: layout.instructionsScale,
                y: layout.instructionsScale,
                z: layout.instructionsScale
            };
//            World.instructionWidget.rotate = {
//            x:90,
//            y:90,
//            z:90
//            }
            World.instructionWidget.translate = {
                x: layout.TranslateX,
                y: 0,
                z: 0
            };
        },

     layout: {
             normal: {
                 name: "normal",
                 offsetX: 0,
                 offsetY: 0,
                 opacity: 1.0,
                 instructionsScale: 8.5,
                 TranslateX: 1.5,
                 TranslateY: 0,
                 TranslateZ: 1,
             },
             snapped: {
                 name: "snapped",
                 offsetX: 1.0,
                 offsetY: 0.45,
                 opacity: 0.5,
                 instructionsScale: 7.0,
                 TranslateX: -0.7,
                 TranslateY: 0.5,
                 TranslateZ: 0,
             }
         },
};

World.init();