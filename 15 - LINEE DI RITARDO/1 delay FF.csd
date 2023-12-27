<Cabbage>
    form caption("Delay Feed Forward") size(230, 120), guiMode("queue") pluginId("def1")
    rslider bounds(116, 10, 100, 100), channel("drywet"), range(0, 1, 0.5, 1, 0.01), text("Dry/Wet"), trackerColour(0, 255, 0, 255), outlineColour(0, 0, 0, 50), textColour(0, 0, 0, 255)
    rslider bounds(10, 10, 100, 100), channel("time"), range(0, 2000, 500, 1, 0.01), text("Delay Time"), trackerColour(0, 255, 0, 255), outlineColour(0, 0, 0, 50), textColour(0, 0, 0, 255)

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

            kDryWet cabbageGetValue "drywet";drywet master

            kTimeDelay0  cabbageGetValue "time" ;delay time in ms
            kTimeDelayPort portk kTimeDelay0, 0.1 ;value porting
            aTimeDelay interp kTimeDelayPort ;interpolation

            ;TESTARE CON CUFFIA e inizialmente a basso volume
            aL inch 1 ;Ingresso 1
            aR inch 2 ;Ingresso 2

            aDelayL  vdelay aL, aTimeDelay, 2000 
            aDelayR  vdelay aR, aTimeDelay, 2000 

            aOutL = (aDelayL * kDryWet) + (aL * (1 - kDryWet))
            aOutR = (aDelayR * kDryWet) + (aR * (1 - kDryWet))
     
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
