<Cabbage>

    form caption("ADDITIVA ARRAY 1") size(400, 300), guiMode("queue") pluginId("def1")
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

        gindex = 0 ;indice array strumento 2
        giPartial = 20 ;numero di parziali
        giDur = 5 ; durata
        iPiGreco = 4 * taninv(1) ;calcola pigreco

        ;inizializzazione arrays
        giFreq[] init giPartial
        giAmp[] init giPartial
        giPhase[] init giPartial

        iFreqFond = 100;frequenza fondamentale
        index = 0;indice array
        while index < giPartial do;ciclo

         schedule 2, 0, giDur ;chiama lo strumento 2 "n" volte = giPartial
            giFreq[index] = (index + 1) * iFreqFond;scrive nell'array numeri interi 
            giAmp[index] = index + 1;scrive nell'array numeri interi 
            giPhase[index] = iPiGreco / (index + 1)
            index += 1   
         od

    endin

    instr 2

        giAmp[gindex] = gindex * 100
        iAMP = giAmp[gindex]
        print iAMP 
        iFREQ = giFreq[gindex] 
        print giFreq[gindex]
        iPHASE = giPhase[gindex]
        print iPHASE

        gindex = gindex + 1

    endin

    </CsInstruments>
    
    <CsScore>
        ;causes Csound to run for about 7000 years...
        f0 z
        f1 0 4096 10 1 ;SINUSOIDE

        ;starts instrument 1 and runs it for a week
        i1 0 [60*60*24*7] 
    </CsScore>
    
</CsoundSynthesizer>
