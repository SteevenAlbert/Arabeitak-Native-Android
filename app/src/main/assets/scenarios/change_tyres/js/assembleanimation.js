var World = {
    //Initial Variables
    loaded: false,
    drawables: [],
    lights: [],
    steps:[],
    snapped: false,
    interactionContainer: 'snapContainer',
    layout: {
        normal: {
            name: "normal",
            offsetX: 0,
            offsetY: 0.45,
            opacity: 1.0,
            carScale: 2.5,
            carTranslateX: -0.5,
            carTranslateY: 0.5,
            carTranslateZ: 0.2,
        },
        snapped: {
            name: "snapped",
            offsetX: 1.0,
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

    init: function initFn(){
        World.createWheels();
        World.createWrench();
        World.createCarJack();
        World.createBoxAnimation();
        World.createBtn({
                    translate: {
                        x: 0,
                        z: 0.5,

                    }
                });
        World.createTracker();
    },

    /******************/
    /* LOAD 3D ASSETS */
    /******************/
    createWheels: function createWheelsFn(){
        var boxScale = 0.0005
            this.wheel = new AR.Model("assets/Wheel5.wt3",{
                scale: {
                    x: boxScale,
                    y: boxScale,
                    z: boxScale
                },
              rotate: {
                 x: 90.0,
                 y: 90.0,
                 z: 90.0
               },
//             translate: {
//                   x: -0.7,
//                   y: -0.4 ,
//                   z: -0.8
//               },
                enabled: true,
                onError: World.onError
            });
            World.drawables.push(this.wheel);
        },
        createCarJack: function createCarJackFn(){
            var carJackScale = 0.01
                this.wheel = new AR.Model("assets/Carjack.wt3",{
                    scale: {
                        x: carJackScale,
                        y: carJackScale,
                        z: carJackScale
                    },
                  rotate: {
                     x: 90.0,
                     y: 90.0,
                     z: 90.0
                   },
                 translate: {
                       x: 1,
                       y: -0.4 ,
                       z: -0.8
                   },
                    enabled: true,
                    onError: World.onError
                });
                World.drawables.push(this.wheel);
            },

    createWrench: function createWrenchFn(){
        var wrenchScale = 0.002
            this.wrench = new AR.Model("assets/4_way_wrench.wt3",{
                scale: {
                    x: wrenchScale,
                    y: wrenchScale,
                    z: wrenchScale
                },
                enabled: true,
                onError: World.onError
            });
            World.drawables.push(this.wrench);
        },

    /******************/
    /* CREATE TRACKER */
    /******************/
//    createTracker: function createTrackerFn() {
//            this.targetCollectionResource = new AR.TargetCollectionResource("assets/toyota_image.wtc", {
//                onError: World.onError
//            });
//
//            this.tracker = new AR.ImageTracker(this.targetCollectionResource, {
//
//                    onError: World.onError
//                });
//
//            this.Toyota = new AR.ImageTrackable(this.tracker, "*", {
//                    drawables: {
//                        cam: World.drawables
//                    },
//                     onImageRecognized: World.hideInfoBar,
//                     onError: World.onError
//                 });
//            this.Steps = new AR.ImageTrackable(this.tracker, "*", {
//                 drawables: {
//                                 cam: World.instructionWidget
//                             },
//                             snapToScreen: {
//                                 snapContainer: document.getElementById('snapContainer')
//                             },
//                             onObjectRecognized: World.objectRecognized,
//                             onObjectLost: World.objectLost,
//                             onError: World.onError
//                     });
//
//        },

  createTracker: function createTrackerFn() {
        this.targetCollectionResource = new AR.TargetCollectionResource("assets/toyota_image.wtc", {
            onError: World.onError
        });

          this.tracker = new AR.ImageTracker(this.targetCollectionResource, {

                          onError: World.onError
                      });

      this.Toyota = new AR.ImageTrackable(this.tracker, "*", {
                        drawables: {
                            cam: World.drawables
                        },
                         onImageRecognized: World.hideInfoBar,
                         onError: World.onError
                     });

        World.instructionWidget = new AR.HtmlDrawable({
            uri: "assets/instruction.html"
        }, 0.25, {
            viewportWidth: 500,
            viewportHeight: 200,
            onClick: World.toggleSnapping,
            onError: World.onError,
            scale: {
                x: 2.5,
                y: 2.5,
                z: 2.5
            },
            translate: {
                x: -0.5,
                y: 0,
                z: 0.2
            },
            rotate: {
                x: -0.6
            },
            horizontalAnchor: AR.CONST.HORIZONTAL_ANCHOR.RIGHT,
            verticalAnchor: AR.CONST.VERTICAL_ANCHOR.TOP,
            // allowDocumentLocationChanges: true
            clickThroughEnabled: true
        });

        this.objectTrackable2 = new AR.ImageTrackable (this.tracker, "*", {
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
createBoxAnimation: function createBoxAnimationFn(button) {
        animationDuration=2000,
        wrenchOffsetZ = 0.3,
        wrenchOffsetY = 0.5
        var wrenchRotationAnimation = new AR.PropertyAnimation(World.wrench, "rotate.z", 0, 720, animationDuration,{
         type: AR.CONST.EASING_CURVE_TYPE.EASE_IN_OUT_SINE});


        var wrenchTranslationAnimation1 = new AR.PropertyAnimation(
                World.wrench,
                "translate.y",
                wrenchOffsetZ,
                wrenchOffsetZ + 0.2, animationDuration/2, {}
            );

        var wrenchTranslationAnimation1 = new AR.PropertyAnimation(
                        World.wrench,
                        "translate.y",
                        wrenchOffsetZ,
                        wrenchOffsetZ + 0.2, animationDuration/2, {}
                    );
        var wrenchTranslationAnimation1 = new AR.PropertyAnimation(
                        World.wrench,
                        "translate.y",
                        wrenchOffsetZ,
                        wrenchOffsetZ + 0.2, animationDuration/2, {}
                    ) ;
        var animationGroup = new AR.AnimationGroup(
                    AR.CONST.ANIMATION_GROUP_TYPE.SEQUENTIAL, [wrenchRotationAnimation, wrenchTranslationAnimation1, wrenchRotationAnimation]
                );
        //animationGroup.start()
        World.steps.push(animationGroup)
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
            World.steps[step].start();
            World.instructionWidget.evalJavaScript("var step = document.getElementById('step"+step+"'); step.style.backgroundColor = '#90EE90'; step.style.color= 'white'; console.log(step.style.backgroundColor);");
            step++;
            if(step==World.steps.length){


            }
        }
        var overlayOne = new AR.ImageDrawable(btn, 0.1, options)

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


};

World.init();