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

        kMetroRand randomh 0,5,10
        ktrig metro 5 + kMetroRand 

        schedkwhen ktrig, 0, 0, 2, 0, 0.01

        endin

        instr 2
        gindex = 0
        iPartial = 10
        giFreq[] init iPartial
        giAmp[] init iPartial

        giDur = 3  

        index = 0
        while index < iPartial do

         schedule 3, 0, giDur 
            iInitSerie = int(rnd(3) + 1)
            giFreq[index] =  (1 + iInitSerie) * index + 1
            giAmp[index] = rnd(0.9) + 0.1
    
            index += 1  
        
         od

        endin


        instr 3
        ;print giAmp[gindex]

        iSpreadFreq = 3
        iFreq = (100 + rnd(iSpreadFreq) - iSpreadFreq / 2) 
        ;print iFreq

        aA oscili 0.01 * giAmp[gindex],  (iFreq ) * giFreq[gindex] 
        aEnv linseg 0, giDur/2, 1, giDur/2, 0


        aL, aR pan2 aA * aEnv, rnd(1)
        outs aL,aR

        gindex = gindex + 1

        endin

    </CsInstruments>
    
    <CsScore>
        ;causes Csound to run for about 7000 years...
        f0 z
        ;starts instrument 1 and runs it for a week
        i1 0 [60*60*24*7] 
    </CsScore>
    
</CsoundSynthesizer>
