<Cabbage>
    form caption("Untitled") size(400, 300), guiMode("queue") pluginId("def1")
    rslider bounds(296, 162, 100, 100), channel("gain"), range(0, 1, 0, 1, .01), text("Gain"), trackerColour("lime"), outlineColour(0, 0, 0, 50), textColour("black")

</Cabbage>

<CsoundSynthesizer>

    <CsOptions>
        -n -d -+rtmidi=NULL -M0 -m0d 
    </CsOptions>

    <CsInstruments>
        ; Initialize the global variables. 
        ksmps = 10
        nchnls = 2
        0dbfs = 1


        instr 1

            ktrig metro 2
            gkDur = 4
            schedkwhen ktrig, 0, 0, 2, 0, gkDur

        endin

        instr 2

            setksmps 1

            aRitardo1 init 0
            aRitardo2 init 0

            aPink pinker
            aOriginale = aPink * 0.1
                                          ;feedback
            aRitardo1 vdelay aOriginale + aRitardo2 * (rnd(0.5) + 0.5), int(rnd(10)+ 1) * rnd(1) , 10000 
            aRitardo2 vdelay aOriginale + aRitardo1 * (rnd(0.5) + 0.5) , int(rnd(5) + 1) * rnd(1), 10000 

            iAttPerc = 0.1
            aEnv linseg 0, i(gkDur) * iAttPerc, 1, i(gkDur) * (1 - iAttPerc), 0
            aOut = (aRitardo1 + aRitardo2) * aEnv * 0.5
     
            aL, aR pan2 aOut, rnd(1)
     
            outs aL, aR
        
            endin

        </CsInstruments>
    
        <CsScore>
            ;causes Csound to run for about 7000 years...
            f0 z
            ;starts instrument 1 and runs it for a week
            i1 0 [60*60*24*7] 
        </CsScore>
    
</CsoundSynthesizer>
