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
    ksmps = 32
    nchnls = 2
    0dbfs = 1


    instr 1
        
    ktrig metro 10
    gkDur = 3
    schedkwhen ktrig, 0, 0, 2, 0, gkDur
            
    endin
    
    instr 2
    setksmps 1
    
    aFB init 0
    aPink pinker
    
    iPercAtt = 0.01
    aEnv linseg 0, i(gkDur) * iPercAtt, 1, i(gkDur) * (1 - iPercAtt), 0
    
    iHarm = int(rnd(5) + 1)
    iFreq = 100 * iHarm
    iTime = (1 / iFreq) * 1000
    
    ;print iTime
    aDelay vdelay aPink + aFB * 0.99, iTime, 2000
    aFB = aDelay 
    
    aL, aR pan2 (aDelay * aEnv * 0.1) / iHarm, rnd(1)
    
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
