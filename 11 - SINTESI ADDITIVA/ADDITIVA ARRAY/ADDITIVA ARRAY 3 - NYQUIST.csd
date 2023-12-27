<Cabbage>
    form caption("ADDITIVA ARRAY 3 - NYQUIST") size(400, 300), guiMode("queue") pluginId("def1")
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

            iNyquist = sr / 2;NYQUIST

            giFreqFond = 100;FREQUENZA FONDAMENTALE

            iPartial = int(iNyquist / giFreqFond) ;NUMERO DI PARZIALI FINO A NYQUIST

            giDur = 5 ; durata
            iPiGreco = 4 * taninv(1) ;calcolo PiGreco

            ;inizializzazione arrays
            giFreq[] init iPartial
            giAmp[] init iPartial
            giPhase[] init iPartial
            giTime[] init iPartial

            index = 0;INDICE ARRAY
            while index < iPartial do;CICLO

             schedule 2, 0, giDur ;chiama lo strumento 2 "n" volte = giPartial
 
                ;SAW
                ;giFreq[index] = (index + 1)  ;SERIE ARMONICA
                ;giAmp[index] = 1 / (index + 1) ;AMPIEZZE 
    
                ;SQUARE
                giFreq[index] = (2 * index + 1)  ;SERIE ARMONICA
                giAmp[index] = 1 / (2 * index + 1) ;AMPIEZZE 
    
                ;TRIANGLE
                ;giFreq[index] = (2 * index + 1)        ;SERIE ARMONICA
                ;giAmp[index] = 1 / (2 * index + 1) ^ 2 ;AMPIEZZE 
    
                giPhase[index] = iPiGreco * ((index + 1) / iPartial) ;FASI ;FASI
    
                giTime[index] = (giDur / 2) * ((iPartial - index) / iPartial);TEMPI ARMONICHE
    
                index += 1 
        
             od
 
        endin


        instr 2

            ;print giFreq[gindex]
            ;print giAmp[gindex]

            aA oscili 0.1 * giAmp[gindex], giFreqFond * giFreq[gindex]
            aEnv linseg 0, giDur / 2 , 1, giTime[gindex] , 0

            outs aA * aEnv ,aA * aEnv 

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
