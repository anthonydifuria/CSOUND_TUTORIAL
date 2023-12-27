<Cabbage>
    form caption("MultiDelay FeedBack") size(350, 220), guiMode("queue") pluginId("def1")
    vslider bounds(292, 10, 57, 206), channel("dry"), range(0, 1, 0.5, 1, 0.01), text("DRY"), trackerColour(0, 255, 0, 255), outlineColour(0, 0, 0, 50), textColour(0, 0, 0, 255)
    rslider bounds(188, 10, 100, 100), channel("dly1"), range(0, 1, 0.2, 1, 0.01), text("WET DLY 1"), trackerColour(0, 255, 0, 255), outlineColour(0, 0, 0, 50), textColour(0, 0, 0, 255)
    rslider bounds(188, 116, 100, 100), channel("dly2"), range(0, 1, 0.2, 1, 0.01), text("WET DLY 2"), trackerColour(0, 255, 0, 255), outlineColour(0, 0, 0, 50), textColour(0, 0, 0, 255)

    rslider bounds(10, 10, 100, 100), channel("time1"), range(0, 2000, 500, 1, 0.01), text("Delay Time 1"), trackerColour(0, 255, 0, 255), outlineColour(0, 0, 0, 50), textColour(0, 0, 0, 255)
    rslider bounds(10, 116, 100, 100), channel("time2"), range(0, 2000, 200, 1, 0.01), text("Delay Time 2"), trackerColour(0, 255, 0, 255), outlineColour(0, 0, 0, 50), textColour(0, 0, 0, 255)

    vslider bounds(114, 10, 71, 207), channel("feedback"), range(0, 1, 0.5, 1, 0.01), text("FeedBack"), trackerColour(0, 255, 0, 255), outlineColour(0, 0, 0, 50), textColour(0, 0, 0, 255)

</Cabbage>

<CsoundSynthesizer>

    <CsOptions>
        -n -d -+rtmidi=NULL -M0 -m0d 
    </CsOptions>
    
    <CsInstruments>
        ; Initialize the global variables. 
        ksmps = 32
        nchnls = 2
        0dbfs = 1


        instr 1
    
            kDry cabbageGetValue "dry";dry
            kDly1Wet cabbageGetValue "dly1";wet dealy 1
            kDly2Wet cabbageGetValue "dly2";wet dealy 2

            kTimeDelay0  cabbageGetValue "time1" ;delay time in ms
            kTimeDelayPort portk kTimeDelay0, 0.1 ;value porting
            aTimeDelay interp kTimeDelayPort ;interpolation

            kTimeDelay02  cabbageGetValue "time2" ;delay time in ms
            kTimeDelayPort2 portk kTimeDelay02, 0.1 ;value porting
            aTimeDelay2 interp kTimeDelayPort2 ;interpolation

            kFeedBack  cabbageGetValue "feedback" ;feedback

            aFeedBackL init 0 ; init feedback Left
            aFeedBackR init 0 ; init feedback Righe
            aFeedBack2L init 0 ; init feedback 2 Left
            aFeedBack2R init 0 ; init feedback 2 Right

            aL inch 1 ;left
            aR inch 2 ;right

            ;Delay Serial Processing
            aDelayL  vdelay aL + (aFeedBackL * kFeedBack), aTimeDelay, 2000 
            aDelayR  vdelay aR + (aFeedBackR * kFeedBack), aTimeDelay, 2000

            aFeedBackL = aDelayL
            aFeedBackR = aDelayR 

            aDelay2L  vdelay aDelayL + (aFeedBack2L * kFeedBack), aTimeDelay2, 2000 
            aDelay2R  vdelay aDelayR + (aFeedBack2R * kFeedBack), aTimeDelay2, 2000 

            aFeedBack2L = aDelay2L
            aFeedBack2R = aDelay2R

            aOutL =  (aL * kDry) + (aDelayL * kDly1Wet) + (aDelay2L * kDly2Wet)
            aOutR =  (aR * kDry) + (aDelayR * kDly1Wet) + (aDelay2R * kDly2Wet)
     
            outs aOutL, aOutR

        endin

    </CsInstruments>
    
    <CsScore>
        ;causes Csound to run for about 7000 years...
        f0 z
        ;starts instrument 1 and runs it for a week
        i1 0 [60*60*24*7] 
    </CsScore>
    
</CsoundSynthesizer>
