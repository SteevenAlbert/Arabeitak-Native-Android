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
    nextbtn: null,
    backbtn: null,
    startFlag: false,
    init: function initFn(){
        World.createAntiClockArrows();
        World.createClockWiseArrows();
        World.createFunnel();
        World.createJerrycan();
        World.createFunnelOccluder();
        World.createRedArrow();
        World.createRedArrowAppearingAnimation();
        World.createFunnelAnimation();
        World.createPouringAnimation();
        World.createStartBtn();
        World.createNextBtn();
        World.createBackBtn();
        World.createAudio();
        World.createTracker();
    },

    /******************/
    /* LOAD 3D ASSETS */
    /******************/
    createRedArrow: function createRedArrowFn(){
        var arrowScale = 0.0008
            this.RedArrow = new AR.Model("assets/Arrow-RED-OP.wt3",{
                scale: {
                    x: arrowScale,
                    y: arrowScale,
                    z: arrowScale
                },
              rotate: {
                 x: 0.0,
                 y: 0.0,
                 z: 270
              },
             translate: {
                   x: -0.347,
                   y: 0.755,
                   z: -0.098
               },
                enabled: false,
                onError: World.onError
            });
            World.drawables.push(this.RedArrow);
        },

    createAntiClockArrows: function createAntiClockArrowsFn(){
        var ArrowsImage = new AR.ImageResource("assets/arrows.png")
        this.ArrowsImageDrawable = new AR.ImageDrawable(ArrowsImage, 0.5, {
            translate: {
                x: -0.338,
                y: 0.416,
                z: -0.099
            },
            rotate:{
                x: 90,
                y: 90
            },
            enabled: false,
        });
        World.drawables.push(this.ArrowsImageDrawable);
    },


    createClockWiseArrows: function createClockWiseArrowsFn(){
        var ArrowsImage = new AR.ImageResource("assets/clockwiseArrows.png")
        this.ClockWiseArrowsImageDrawable = new AR.ImageDrawable(ArrowsImage, 0.5, {
            translate: {
                x: -0.338,
                y: 0.416,
                z: -0.099
            },
            rotate:{
                x: 90,
                y: 90
            },
            enabled: false,
        });
        World.drawables.push(this.ClockWiseArrowsImageDrawable);
    },

    createFunnel: function createFunnelFn(){
    var funnelScale = 0.003
        this.Funnel = new AR.Model("assets/Funnel.wt3",{
            scale: {
                x: funnelScale,
                y: funnelScale,
                z: funnelScale
            },
            rotate: {
                x: 270,
                y: 0,
                z: 0
            },
            translate: {
                x: -0.337,
                y: 0.477,
                z: -0.125
            },
            enabled: false,
            onError: World.onError
        });
        World.drawables.push(this.Funnel);
    },

    createFunnelOccluder: function createFunnelOccluderFn(){
        var funnelScale = 0.0009
        this.FunnelOccluder = new AR.Occluder("assets/FunnelOccluder.wt3", {
            translate: {
                x: -0.339,
                y: 0.43,
                z: -0.103
            },
            scale: {
                x: funnelScale,
                y: funnelScale +0.001,
                z: funnelScale
            },
            rotate: {
                z: 270
            },
            enabled:false,
        });
        World.drawables.push(this.FunnelOccluder);
    },

    createJerrycan: function createJerrycanFn(){
        var jerrycanScale = 0.6
            this.Jerrycan = new AR.Model("assets/jerrycan2.wt3",{
                scale: {
                    x: jerrycanScale,
                    y: jerrycanScale,
                    z: jerrycanScale
                },
                rotate: {
                    x: 0,
                    y: 90,
                    z: 90
                },
                translate: {
                    x: -0.33,
                    y: 0.753,
                    z: -0.664
                },
                enabled: false,
                onError: World.onError
            });
            World.drawables.push(this.Jerrycan);
        },

    /******************/
    /* CREATE TRACKER */
    /******************/ 
    createTracker: function createTrackerFn() {
        this.targetCollectionResource = new AR.TargetCollectionResource("assets/reservoir.wto", {
            onError: World.onError
        });

          this.tracker = new AR.ObjectTracker(this.targetCollectionResource, {
                          onError: World.onError
                      });

      this.Toyota = new AR.ObjectTrackable(this.tracker, "*", {
                        drawables: {
                            cam: World.drawables
                        },
                         onObjectRecognized: World.hideScanBox,
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

        var appearingAnimationGroup = new AR.AnimationGroup(
                            AR.CONST.ANIMATION_GROUP_TYPE.PARALLEL, [sx,sy,sz]
                        );


        var emptyAnimationGroup = new AR.AnimationGroup(
                            AR.CONST.ANIMATION_GROUP_TYPE.SEQUENTIAL, []
                        );
        World.steps.push(emptyAnimationGroup);
        World.steps.push(appearingAnimationGroup);
    },


    createFunnelAnimation: function createFunnelAnimationFn() {
        animationDuration=2000
        var funnelTranslationAnimation1 = new AR.PropertyAnimation(
                World.Funnel,
                "translate.y",
                0.8,
                0.477, animationDuration, {}
            );
        var animationGroup = new AR.AnimationGroup(
                    AR.CONST.ANIMATION_GROUP_TYPE.SEQUENTIAL, [funnelTranslationAnimation1]
                );
        var emptyAnimationGroup = new AR.AnimationGroup(
                            AR.CONST.ANIMATION_GROUP_TYPE.SEQUENTIAL, []
                        );


        //animationGroup.start()
        World.steps.push(animationGroup)


    },

      createPouringAnimation: function createPouringAnimationFn() {
            var animationDuration = 2500;
            var jerrycanRotationAnimationDown = new AR.PropertyAnimation(this.Jerrycan, "rotate.y", 90, 30, animationDuration);
            var jerrycanRotationAnimationUp = new AR.PropertyAnimation(this.Jerrycan, "rotate.y", 30, 90, animationDuration);

                    var emptyAnimationGroup = new AR.AnimationGroup(
                                        AR.CONST.ANIMATION_GROUP_TYPE.SEQUENTIAL, []
                                    );
             var animationGroup = new AR.AnimationGroup(
                                AR.CONST.ANIMATION_GROUP_TYPE.SEQUENTIAL, [jerrycanRotationAnimationDown, jerrycanRotationAnimationUp]
                            );
            World.steps.push(animationGroup);
            World.createRedArrowAppearingAnimation();
            World.steps.push(emptyAnimationGroup);
            World.steps.push(emptyAnimationGroup);
            World.steps.push(emptyAnimationGroup);
            World.steps.push(emptyAnimationGroup);
        },



    /********************/
    /* CREATE AUDIO */
    /********************/
    createAudio: function createAudioFunction(){
        for (var i = 1; i <= 8; i++) {
            var stepVO = new AR.Sound("assets/audio/Step-" + i + ".mp3");
            World.audio.push(stepVO);
        }
    },

    /******************/
    /*   UI Elements  */
    /******************/
    createStartBtn: function createStartBtnFn() {
        var startbtn = new AR.ImageResource("assets/startbtn.png", {
            onError: World.onError
        });
        options = {};
        options.translate =  {
            x: 0.154,
            y: 0.494,
            z: -0.2
        }
        options.rotate =  {
            x: 90.0,
            y: -90,
            z: 0
        }
        options.opacity = 0.9;
        options.onClick = function () {
            World.steps[World.step].start();
            World.audio[World.step].play();
            World.instructionWidget.evalJavaScript("var step = document.getElementById('step"+World.step+"'); step.style.backgroundColor = '#90EE90'; step.style.color= 'white'; console.log(step.style.backgroundColor);");
            World.step++;
            startbtn.destroy();
            World.nextbtn.enabled = true;
            World.backbtn.enabled = true;
        }
        var startbtn = new AR.ImageDrawable(startbtn, 0.2, options)
        World.drawables.push(startbtn);
    },
    createNextBtn: function createNextBtnFn() {
        options ={};
        var btn = new AR.ImageResource("assets/nextbtn.png", {
            onError: World.onError
        });
        options.translate =  {
           x: 0.25,
           y: 0.513,
           z: -0.6

        }
        options.rotate =  {
            x: 90.0,
           y: -90,
           z: 0
        }
        options.opacity = 0.9;
        options.enabled = false;
        options.onClick = function () {
            if (World.step === 1) {
                World.RedArrow.enabled = true;
                World.ArrowsImageDrawable.enabled = true;
            }else{
              World.RedArrow.enabled = false;
                            World.ArrowsImageDrawable.enabled = false;
            }

            if(World.step >1 && World.step <=3 ){
                World.Funnel.enabled = true;
                World.FunnelOccluder.enabled = true;
            }else{
                World.Funnel.enabled = false;
                World.FunnelOccluder.enabled = false;
            }

             if(World.step == 3 ){
                    World.Jerrycan.enabled = true;
               }else{
                    World.Jerrycan.enabled = false;
               }

               if(World.step == 4 ){
                   World.ClockWiseArrowsImageDrawable.enabled = true;
                    World.RedArrow.enabled = true;
              }else{
                   World.ClockWiseArrowsImageDrawable.enabled = false;
                    World.RedArrow.enabled = false;
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
        World.nextbtn = new AR.ImageDrawable(btn, 0.15, options)
        World.drawables.push(World.nextbtn);
    },

    createBackBtn: function createBackBtn() {
        options ={};
        var backbtn = new AR.ImageResource("assets/backbtn.png", {
            onError: World.onError
        });
        options.opacity = 0.7;
        options.translate =  {
            x: 0.25,
            y: 0.513,
            z: 0.025,
        }
        options.rotate =  {
             x: 90.0,
                       y: -90,
                       z: 0
        }
        options.enabled = false;
        options.onClick = function () {
            if (World.step !== 0 && (World.audio[World.step-1].state == 2 || World.audio[World.step-1].state == 3)) {
                World.audio[World.step-1].stop();
            }
            if(World.step>0){
                World.step--;     
            }
          if (World.step === 1) {
                   World.RedArrow.enabled = true;
                   World.ArrowsImageDrawable.enabled = true;
           }else{
             World.RedArrow.enabled = false;
                           World.ArrowsImageDrawable.enabled = false;
           }
             if(World.step == 3 ){
                    World.Jerrycan.enabled = true;
               }else{
                    World.Jerrycan.enabled = false;
               }

             if(World.step==2){
                World.Funnel.enabled = true;
                World.FunnelOccluder.enabled = true;
            }else{
                World.Funnel.enabled = false;
                World.FunnelOccluder.enabled = false;
            }

            if(World.step == 4 ){
                   World.ClockWiseArrowsImageDrawable.enabled = true;
              }else{
                   World.ClockWiseArrowsImageDrawable.enabled = false;
              }
           if(World.step >1 && World.step <=4 ){
                        World.Funnel.enabled = true;
                        World.FunnelOccluder.enabled = true;
            }else{
                World.Funnel.enabled = false;
                World.FunnelOccluder.enabled = false;
            }

            World.instructionWidget.evalJavaScript("var step = document.getElementById('step"+World.step+"'); step.style.backgroundColor = 'white'; step.style.color= 'black'; console.log(step.style.backgroundColor);");
        }
        World.backbtn = new AR.ImageDrawable(backbtn, 0.15, options)
        World.drawables.push(World.backbtn);
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
        World.instructionWidget.rotate ={
            x: instructionsMenu.RotateX,
            y: instructionsMenu.RotateY,
            z: instructionsMenu.RotateZ,
        }
    },

    hideScanBox: function hideScanBoxFn() {
        document.getElementById("scanbox").style.display = "none";
    },

     instructionsMenu: {
             normal: {
                 name: "normal",
                 opacity: 0.9,
                 instructionsScale: 8.5,
                 TranslateX: -2.5,
                 TranslateY: 1,
                 TranslateZ: 0.5,
                 RotateX: 0,
                 RotateY: -90,
                 RotateZ: 0
             },
             snapped: {
                 name: "snapped",
                 opacity: 0.6,
                 instructionsScale: 7.0,
                 TranslateX: -0.7,
                 TranslateY: 0.5,
                 TranslateZ: 0,
                 RotateX: 0,
                 RotateY: 0,
                 RotateZ: 0
             }
         },
};

World.init();