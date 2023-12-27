<Cabbage>

    form caption("Untitled") size(400, 300), guiMode("queue"), pluginId("def1")
    keyboard bounds(8, 158, 381, 95)

</Cabbage>

<CsoundSynthesizer>

    <CsOptions>
        -n -d -+rtmidi=NULL -M0 -m0d --midi-key-cps=4 --midi-velocity-amp=5
    </CsOptions>                        ;p4                 p5

    <CsInstruments>
        ; Initialize the global variables. 
        ksmps = 10
        nchnls = 2
        0dbfs = 1

        ;lo strumento sarà chiamato direttamente dalla tastiera virtuale midi
        instr 1
            ;p5 e p4 sono le variabili che interfacciano la tastiera virtuale al nostro strumento
            iAmp = p5 ; p5 per le ampiezze
            iFreq = p4 ; p4 per le frequenze

            aSig oscili iAmp, iFreq

            iAtt = 0.1 ;tempo di attacco del suono 1/10 di secondo - 0.1 secondi
            iDec = 0.1 ;tempo di decadimento del suono 1/10 di secondo - 0.1 secondi
            iSus = 0.5 ;ampiezza del sostegno suono 0.5 di ampiezza
            iRel = 3 ;tempo di rilascio del suono 3/10 di secondo - 0.3 secondi
            aEnv madsr iAtt, iDec, iSus, iRel; inviluppo o rpofilo dinamico del suono

            aSigEnv = aSig * aEnv; applicazione dell'inviluppo al segnale sinosuidale attraverso la moltiplicazione

            outs aSigEnv, aSigEnv

        endin

    </CsInstruments>

    <CsScore>
        ;causes Csound to run for about 7000 years...
        f0 z        
    </CsScore>

</CsoundSynthesizer>
