var World = {
    loaded: false,
    snapped: false,
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

    init: function initFn() {
        World.createOccluder();
        World.createCones();
        World.createBtn({
                    translate: {
                        x: 0,
                        y:0.2,
                        z: 0.2,
                    }
                });
        World.createLights();
        World.createInstructions();
        World.createScrewdriver();
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

    createCones: function createConesFn() {
        var coneDistance = this.firetruckLength * 0.8;

        var frontLeftCone = World.getCone(-coneDistance, +coneDistance);
        World.drawables.push(frontLeftCone);

        var backLeftCone = World.getCone(+coneDistance, +coneDistance);
        World.drawables.push(backLeftCone);

        var backRightCone = World.getCone(+coneDistance, -coneDistance);
        World.drawables.push(backRightCone);

        var frontRightCone = World.getCone(-coneDistance, -coneDistance);
        World.drawables.push(frontRightCone);
    },

    getCone: function getConeFn(positionX, positionZ) {
        var coneScale = 0.05 * this.firetruckLength;

        return new AR.Model("assets/traffic_cone.wt3", {
            scale: {
                x: coneScale,
                y: coneScale,
                z: coneScale
            },
            translate: {
                x: positionX,
                y: World.firetruckCenter.y,
                z: positionZ
            },
            rotate: {
                x: -90
            },
            onError: World.onError
        });
    },

    createLights: function createLightsFn() {
        var lightPosX = -this.firetruckLength * 0.45;
        var lightPosY = this.firetruckHeight * 0.7;
        var lightPosZ = this.firetruckLength * 0.15;

        var leftLight = World.getLight(lightPosX, lightPosY, lightPosZ);
        World.addLightAnimation(leftLight);
        World.lights.push(leftLight);
        World.drawables.push(leftLight);

        var rightLight = World.getLight(lightPosX, lightPosY, -lightPosZ);
        World.addLightAnimation(rightLight);
        World.lights.push(rightLight);
        World.drawables.push(rightLight);

        this.sirenSound = new AR.Sound("assets/siren.wav", {
            onFinishedPlaying: function() {
                World.setLightsEnabled(false);
            },
            onError: World.onError
        });
        this.sirenSound.load();

        this.lightsButton = new AR.Model("assets/marker.wt3", {
            translate: {
                x: -this.firetruckLength * 0.45,
                y: this.firetruckHeight * 0.8,
                z: 0
            },
            rotate: {
                x: -90
            },
            onClick: function() {
                World.setLightsEnabled(true);
            },
            onError: World.onError
        });
        World.addButtonAnimation(this.lightsButton);
        World.drawables.push(this.lightsButton);
    },

    getLight: function getLightFn(positionX, positionY, positionZ) {
        var lightScale = 0.3 * this.firetruckLength;
        var lightResource = new AR.ImageResource("assets/emergency_light.png", {
            onError: World.onError
        });

        return new AR.ImageDrawable(lightResource, lightScale, {
            translate: {
                x: positionX,
                y: positionY,
                z: positionZ
            },
            rotate: {
                x: 90
            },
            enabled: false
        });
    },

    createScrewdriver: function createScrewdriverFn() {
        var screwdriverScale = 0.04 * this.firetruckLength;
        var screwdriverPositionX = -0.4 * this.firetruckLength;
        var screwdriverPositionY = -0.25 * this.firetruckLength;
        var screwdriverPositionZ = 0.50 * this.firetruckLength;

        this.screwdriver = new AR.Model("assets/screwdriver.wt3", {
            scale: {
                x: screwdriverScale,
                y: screwdriverScale,
                z: screwdriverScale
            },
            translate: {
                x: screwdriverPositionX,
                y: screwdriverPositionY,
                z: screwdriverPositionZ
            },
            rotate: {
                y: 180
            },
            enabled: false,
            onError: World.onError
        });
        World.drawables.push(this.screwdriver);

        var screwScale = screwdriverScale * 0.6;
        this.screw = new AR.Model("assets/screw.wt3", {
            scale: {
                x: screwScale,
                y: screwScale,
                z: screwScale
            },
            translate: {
                x: screwdriverPositionX,
                y: screwdriverPositionY,
                z: screwdriverPositionZ
            },
            enabled: false,
            onError: World.onError
        });
        World.drawables.push(this.screw);

        var turningArrowScale = screwdriverScale * 0.2;
        this.turningArrow = new AR.Model("assets/arrow.wt3", {
            scale: {
                x: turningArrowScale,
                y: turningArrowScale,
                z: turningArrowScale
            },
            translate: {
                x: screwdriverPositionX,
                y: screwdriverPositionY,
                z: screwdriverPositionZ
            },
            rotate: {
                y: -90
            },
            enabled: false,
            onError: World.onError
        });
        World.drawables.push(this.turningArrow);

        this.tireButton = new AR.Model("assets/marker.wt3", {
            translate: {
                x: screwdriverPositionX,
                y: screwdriverPositionY,
                z: screwdriverPositionZ
            },
            onClick: function() {
                World.runScrewdriverAnimation();
            },
            onError: World.onError
        });
        World.addButtonAnimation(this.tireButton);
        World.drawables.push(this.tireButton);
    },

    addLightAnimation: function addLightAnimationFn(light) {
        var animationDuration = 500;
        var lowerOpacity = 0.5;
        var upperOpacity = 1.0;

        var lightShow = new AR.PropertyAnimation(light, "opacity", lowerOpacity, upperOpacity, animationDuration / 2, {
            type: AR.CONST.EASING_CURVE_TYPE.EASE_IN_OUT_SINE
        });

        var lightHide = new AR.PropertyAnimation(light, "opacity", upperOpacity, lowerOpacity, animationDuration / 2, {
            type: AR.CONST.EASING_CURVE_TYPE.EASE_IN_OUT_SINE
        });

        var lightAnimation = new AR.AnimationGroup(AR.CONST.ANIMATION_GROUP_TYPE.SEQUENTIAL, [lightShow, lightHide]);
        lightAnimation.start(-1);
    },

    addButtonAnimation: function addButtonAnimationFn(button) {
        var scaleS = 0.03 * this.firetruckLength;
        var scaleL = 0.04 * this.firetruckLength;
        var scaleDuration = 2000;

        /* X animations */
        var buttonScaleAnimationXOut = new AR.PropertyAnimation(button, "scale.x", scaleS, scaleL, scaleDuration / 2, {
            type: AR.CONST.EASING_CURVE_TYPE.EASE_IN_OUT_SINE
        });
        var buttonScaleAnimationXIn = new AR.PropertyAnimation(button, "scale.x", scaleL, scaleS, scaleDuration / 2, {
            type: AR.CONST.EASING_CURVE_TYPE.EASE_IN_OUT_SINE
        });
        var buttonScaleAnimationX = new AR.AnimationGroup(
            AR.CONST.ANIMATION_GROUP_TYPE.SEQUENTIAL, [buttonScaleAnimationXOut, buttonScaleAnimationXIn]);

        /* Y animations */
        var buttonScaleAnimationYOut = new AR.PropertyAnimation(button, "scale.y", scaleS, scaleL, scaleDuration / 2, {
            type: AR.CONST.EASING_CURVE_TYPE.EASE_IN_OUT_SINE
        });
        var buttonScaleAnimationYIn = new AR.PropertyAnimation(button, "scale.y", scaleL, scaleS, scaleDuration / 2, {
            type: AR.CONST.EASING_CURVE_TYPE.EASE_IN_OUT_SINE
        });
        var buttonScaleAnimationY = new AR.AnimationGroup(
            AR.CONST.ANIMATION_GROUP_TYPE.SEQUENTIAL, [buttonScaleAnimationYOut, buttonScaleAnimationYIn]);

        /* Z animations */
        var buttonScaleAnimationZOut = new AR.PropertyAnimation(button, "scale.z", scaleS, scaleL, scaleDuration / 2, {
            type: AR.CONST.EASING_CURVE_TYPE.EASE_IN_OUT_SINE
        });
        var buttonScaleAnimationZIn = new AR.PropertyAnimation(button, "scale.z", scaleL, scaleS, scaleDuration / 2, {
            type: AR.CONST.EASING_CURVE_TYPE.EASE_IN_OUT_SINE
        });
        var buttonScaleAnimationZ = new AR.AnimationGroup(
            AR.CONST.ANIMATION_GROUP_TYPE.SEQUENTIAL, [buttonScaleAnimationZOut, buttonScaleAnimationZIn]);

        /* Start all animation groups. */
        buttonScaleAnimationX.start(-1);
        buttonScaleAnimationY.start(-1);
        buttonScaleAnimationZ.start(-1);
    },

    runScrewdriverAnimation: function runScrewdriverAnimationFn() {
        World.setScrewdriverEnabled(true);

        var animationDuration = 2000;

        var translateDistance = 0.2 * this.firetruckLength;
        var screwdriverZOffset = this.firetruckLength;

        var screwdriverTranslateAnimation = new AR.PropertyAnimation(
            World.screwdriver,
            "translate.z",
            screwdriverZOffset + translateDistance,
            screwdriverZOffset, animationDuration, {}, {
                onFinish: function() {
                    World.setScrewdriverEnabled(false);
                }
            }
        );

        var screwZOffset = screwdriverZOffset - 0.65 * this.firetruckLength;
        var screwTranslateAnimation = new AR.PropertyAnimation(
            World.screw,
            "translate.z",
            screwZOffset + translateDistance,
            screwZOffset,
            animationDuration
        );

        var arrowRotationAnimation = new AR.PropertyAnimation(World.turningArrow, "rotate.z", 0, 360, animationDuration);

        var animationGroup = new AR.AnimationGroup(
            AR.CONST.ANIMATION_GROUP_TYPE.PARALLEL, [screwdriverTranslateAnimation, screwTranslateAnimation, arrowRotationAnimation]
        );
        animationGroup.start();
    },

    setScrewdriverEnabled: function setScrewdriverEnabledFn(enabled) {
        World.tireButton.enabled = !enabled;

        World.screwdriver.enabled = enabled;
        World.screw.enabled = enabled;
        World.turningArrow.enabled = enabled;
    },

    setLightsEnabled: function setLightsEnabledFn(enabled) {
        World.lightsButton.enabled = !enabled;

        for (var i = 0; i < World.lights.length; i++) {
            World.lights[i].enabled = enabled;
        }

        if (enabled) {
            World.sirenSound.play();
        } else {
            World.sirenSound.stop();
        }
    },

    createInstructions: function createInstructions(){
            World.instructionWidget = new AR.HtmlDrawable({
                       uri: "assets/instruction.html"
                   },0.5, {
                       viewportWidth: 500,
                       viewportHeight: 500,
                       opacity:0.8,
                   //onClick: World.toggleSnapping,
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
                           x: 1,
                           y: 1,
                           z: 1
                       },
                       translate: {
                           x: 0.2,
                           y: 0.2,
                           z: 0.4,
                       },
                       rotate: {
                           x:0,
                           y:0,
                           z:0
                       },
                       allowDocumentLocationChanges: true,
                       clickThroughEnabled: true,
                       mirrored:true,
                   });
                     zOrder:99
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


        this.objectTrackable2 = new AR.ObjectTrackable(this.tracker, "*", {
            drawables: {
                cam: World.instructionWidget
            },
            onObjectRecognized: World.objectRecognized,
            onObjectLost: World.objectLost,
            onError: World.onError
        });

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
        World.setLightsEnabled(false);
        World.setScrewdriverEnabled(false);
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
                World.instructionWidget.evalJavaScript("var step = document.getElementById('step"+step+"'); step.style.backgroundColor = '#90EE90'; step.style.color= 'white'; console.log(step.style.backgroundColor);");
                step++;
            }
            var overlayOne = new AR.ImageDrawable(btn, 0.15, options)
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
                World.instructionWidget.rotate = {
                x:0,
                y:0,
                z:90
                }
                World.instructionWidget.translate = {
                    x: layout.TranslateX,
                    y: layout.TranslateY,
                    z: layout.TranslateZ
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
                     offsetX: 1,
                     offsetY: 0,
                     opacity: 1.0,
                     instructionsScale: 1.0,
                     TranslateX: 0.2,
                     TranslateY: 0.4,
                     TranslateZ: -1,
                 }
             },
};

World.init();