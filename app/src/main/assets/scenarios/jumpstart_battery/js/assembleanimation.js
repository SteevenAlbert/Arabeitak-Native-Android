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
    step: 0,
    init: function initFn(){
        World.createBox();
        World.createBoxAnimation();
        World.createRedArrow();
        World.createBlackArrow();
        World.createRedArrowAppearingAnimation();
        World.createBlackArrowAppearingAnimation();
        World.createNextBtn();
        World.createBackBtn();
        World.createAudio();
        World.createTracker();
    },

    /******************/
    /* LOAD 3D ASSETS */
    /******************/
    createRedArrow: function createRedArrowFn(){
        var arrowScale = 0.001
        var arrowScale = 0.001
            this.RedArrow = new AR.Model("assets/Arrow-RED-OP.wt3",{
                scale: {
                    x: arrowScale,
                    y: arrowScale,
                    z: arrowScale
                },
              rotate: {
                 x: 90.0,
                 y: 0.0,
                 z: 270
              },
             translate: {
                   x: -0.41,
                   y: 0.969,
                   z: -0.231
               },
                enabled: false,
                onError: World.onError
            });
            World.drawables.push(this.RedArrow);
        },


    createBlackArrow: function createBlackArrowFn(){
    var arrowScale = 0.0008

        this.BlackArrow = new AR.Model("assets/Arrow-Black.wt3",{
            scale: {
                x: arrowScale,
                y: arrowScale,
                z: arrowScale
            },
            rotate: {
                x: 90.0,
                y: 0.0,
                z: 270
            },
            translate: {
                x: 0.42,
                y: 0.763,
                z: -0.25
            },
            enabled: false,
            onError: World.onError
        });
        World.drawables.push(this.BlackArrow);
    },

    createBox: function createBoxFn(){
        var boxScale = 0.0022
            this.Box = new AR.Model("assets/Box.wt3",{
                scale: {
                    x: boxScale,
                    y: boxScale,
                    z: boxScale
                },
                rotate: {
                    x: 270,
                    y: 0.0,
                    z: 0
                },
                translate: {
                    x: -0.462,
                    y: 0.564,
                    z: -0.249
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
            onError: World.onError,
              onDragEnded: function(xNormalized , yNormalized ) {
                    if(yNormalized<0){
                        World.scrollSteps(100);
                    }else{
                        World.scrollSteps(-100);
                    }
              },
            onScaleEnded: World.toggleSnapping,       
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
        World.applyLayout(World.instructionsMenu.normal);
    },
    /********************/
    /* CREATE ANIMATION */
    /********************/
    createBoxAnimation: function createBoxAnimationFn() {
       animationDuration=2000
     var boxTranslationAnimation1 = new AR.PropertyAnimation(
                World.Box,
                "translate.y",
                0.546,
                 0.8, animationDuration, {}
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
        var sx = new AR.PropertyAnimation(World.RedArrow, "scale.x", 0, 0.001, animationDuration, {
        type: AR.CONST.EASING_CURVE_TYPE.EASE_OUT_QUAD
        });

        var sy = new AR.PropertyAnimation(World.RedArrow, "scale.y", 0, 0.001, animationDuration, {
        type: AR.CONST.EASING_CURVE_TYPE.EASE_OUT_QUAD
        });

        var sz = new AR.PropertyAnimation(World.RedArrow, "scale.z", 0, 0.001, animationDuration, {
        type: AR.CONST.EASING_CURVE_TYPE.EASE_OUT_QUAD
        });


        var isx = new AR.PropertyAnimation(World.RedArrow, "scale.x", 0.001, 0, animationDuration, {
        type: AR.CONST.EASING_CURVE_TYPE.EASE_OUT_QUAD
        });

        var isy = new AR.PropertyAnimation(World.RedArrow, "scale.y", 0.001, 0, animationDuration, {
        type: AR.CONST.EASING_CURVE_TYPE.EASE_OUT_QUAD
        });

        var isz = new AR.PropertyAnimation(World.RedArrow, "scale.z", 0.001, 0, animationDuration, {
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
    },


    createBlackArrowAppearingAnimation: function createBlackArrowAppearingAnimation(){
        animationDuration = 1500;
        var sx = new AR.PropertyAnimation(World.BlackArrow, "scale.x", 0, 0.001, animationDuration, {
        type: AR.CONST.EASING_CURVE_TYPE.EASE_OUT_QUAD
        });

        var sy = new AR.PropertyAnimation(World.BlackArrow, "scale.y", 0, 0.001, animationDuration, {
        type: AR.CONST.EASING_CURVE_TYPE.EASE_OUT_QUAD
        });

        var sz = new AR.PropertyAnimation(World.BlackArrow, "scale.z", 0, 0.001, animationDuration, {
        type: AR.CONST.EASING_CURVE_TYPE.EASE_OUT_QUAD
        });


        var isx = new AR.PropertyAnimation(World.BlackArrow, "scale.x", 0.001, 0, animationDuration, {
        type: AR.CONST.EASING_CURVE_TYPE.EASE_OUT_QUAD
        });

        var isy = new AR.PropertyAnimation(World.BlackArrow, "scale.y", 0.001, 0, animationDuration, {
        type: AR.CONST.EASING_CURVE_TYPE.EASE_OUT_QUAD
        });

        var isz = new AR.PropertyAnimation(World.BlackArrow, "scale.z", 0.001, 0, animationDuration, {
        type: AR.CONST.EASING_CURVE_TYPE.EASE_OUT_QUAD
        });

        var blackAppearingAnimationGroup = new AR.AnimationGroup(
                            AR.CONST.ANIMATION_GROUP_TYPE.PARALLEL, [sx,sy,sz]
                        );
        var blackDisappearingAnimationGroup = new AR.AnimationGroup(
                                    AR.CONST.ANIMATION_GROUP_TYPE.PARALLEL, [isx,isy,isz]
                                );

        var emptyAnimationGroup = new AR.AnimationGroup(
                                    AR.CONST.ANIMATION_GROUP_TYPE.PARALLEL, []
                                );

        World.steps.push(blackAppearingAnimationGroup);
        World.steps.push(blackDisappearingAnimationGroup);
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
    createNextBtn: function createNextBtnFn() {
        options ={};
        var btn = new AR.ImageResource("assets/nextbtn.png", {
            onError: World.onError
        });
        options.translate =  {
            x: 0,
            z: 0.5,
        }
        options.rotate =  {
            x: 90.0,
        }
        options.opacity = 0.9;
        options.onClick = function () {
            if (World.step === 1) {
                World.RedArrow.enabled = true;
                World.Box.enabled = false;
            }
            
            if (World.step === 4) {
                World.BlackArrow.enabled = true;
            }
            
            if (World.step !== 0 && (World.audio[World.step-1].state == 2 || World.audio[World.step-1].state == 3)) {
                    World.audio[World.step-1].stop();
            }
                        
            scrollFlag = World.step > 6 ? false : true;
            
            if (World.step > 2 && scrollFlag) {
                World.scrollSteps(200);
            }
            
            World.steps[World.step].start();
            World.audio[World.step].play();
            World.instructionWidget.evalJavaScript("var step = document.getElementById('step"+World.step+"'); step.style.backgroundColor = '#90EE90'; step.style.color= 'white'; console.log(step.style.backgroundColor);");
            World.step++;
        }
        var nextbtn = new AR.ImageDrawable(btn, 0.25, options)
        World.drawables.push(nextbtn);
    },

    createBackBtn: function createBackBtn() {
        options ={};
        var backbtn = new AR.ImageResource("assets/backbtn.png", {
            onError: World.onError
        });
        options.opacity = 0.7;
        options.translate =  {
            x: -0.65,
            y: -0.4,
            z: 0.5,
        }
        options.rotate =  {
            x: 90.0,
        }
        options.onClick = function () {
            if (World.step !== 0 && (World.audio[World.step-1].state == 2 || World.audio[World.step-1].state == 3)) {
                World.audio[World.step-1].stop();
            }
            if(World.step>0){
                World.step--;     
            }
            if(World.step<2){
                World.Box.enabled = true;
                World.RedArrow.enabled = false;            
            }

            if (World.step < 5) {
                World.BlackArrow.enabled = false;
            }
               
            World.instructionWidget.evalJavaScript("var step = document.getElementById('step"+World.step+"'); step.style.backgroundColor = 'white'; step.style.color= 'black'; console.log(step.style.backgroundColor);");
        }
        var backbtn = new AR.ImageDrawable(backbtn, 0.18, options)
        World.drawables.push(backbtn);
    },

    toggleSnapping: function toggleSnappingFn() {
        World.snapped = !World.snapped;
        World.objectTrackable2.snapToScreen.enabled = World.snapped;

        if (World.snapped) {

            World.applyLayout(World.instructionsMenu.snapped);
        }
        else {

            World.applyLayout(World.instructionsMenu.normal);
        }
    },

    scrollSteps: function ScrollStepsFn(pixels){
        World.instructionWidget.evalJavaScript("document.getElementById('main').scrollBy(0,"+pixels+");");
    // World.instructionWidget.evalJavaScript("document.getElementById('main').scrollBy({ top: "+pixels+", behavior: 'smooth' });");
    },

    applyLayout: function applyLayoutFn(instructionsMenu) {
        World.instructionWidget.scale = {
            x: instructionsMenu.instructionsScale,
            y: instructionsMenu.instructionsScale,
            z: instructionsMenu.instructionsScale
        };
        World.instructionWidget.translate = {
            x: instructionsMenu.TranslateX,
            y: 0,
            z: 0
        };
    },

    hideDisclaimer: function hideDisclaimerFn() {
        document.getElementById("popup").style.display = "none";
    },

     instructionsMenu: {
             normal: {
                 name: "normal",
                 offsetX: 0,
                 offsetY: 0,
                 opacity: 0.9,
                 instructionsScale: 8.5,
                 TranslateX: -1.5,
                 TranslateY: 0,
                 TranslateZ: -1.5,
             },
             snapped: {
                 name: "snapped",
                 offsetX: 1.0,
                 offsetY: 0.45,
                 opacity: 0.6,
                 instructionsScale: 7.0,
                 TranslateX: -0.7,
                 TranslateY: 0.5,
                 TranslateZ: 0,
             }
         },
};

World.init();