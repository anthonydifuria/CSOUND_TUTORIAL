<Cabbage>

    form caption("2 SINTESI ADDITIVA FUNZIONI GEN") size(700, 500), guiMode("queue"), pluginId("def1") , colour(110, 110, 110)
    keyboard bounds(10, 392, 682, 95)
    signaldisplay bounds(322, 86, 362, 187), colour("white") displayType("waveform"), backgroundColour(0, 0, 0), zoom(0.5), signalVariable("aOut", "aOut"), channel("display")


    ;AMPIEZZA USCITA
    rslider bounds(614, 312, 60, 60) channel("out") range(0, 1, 0.5, 1, 0.001)     text("Ampiezza")
                                                    
    ;CONTROLLI INVILUPPO                                               
    rslider bounds(434, 10, 60, 60) channel("att") range(0.001, 1, 0.1, 1, 0.001)  text("ATT")
    rslider bounds(494, 10, 60, 60) channel("dec") range(0.001, 1, 0.1, 1, 0.001)  text("DEC")
    rslider bounds(554, 10, 60, 60) channel("sus") range(0, 1, 0.5, 1, 0.001)     text("SUS")
    rslider bounds(624, 10, 60, 60) channel("rel") range(0.001, 1, 0.3, 1, 0.001) text("REL")

    ;TIPI DI ONDE
    button bounds(272, 314, 80, 40) channel("trigger"), text("CHANGE"), corners(5)
    combobox bounds(354, 314, 199, 40) channel("onde") colour:0(147, 210, 0), corners(5), items("SINE","SQUARE","SAW", "TRIANGLE")

</Cabbage> 


<CsoundSynthesizer>

    <CsOptions>
        -n -d --displays -+rtmidi=NULL -M0 --midi-key-cps=4 --midi-velocity-amp=5
    </CsOptions>                                ;p4                 p5

    <CsInstruments>
        ; Initialize the global variables. 
        ksmps = 10
        nchnls = 2
        0dbfs = 1

        giONDA init 1; inizializzata per l'onda SINUSOIDALE
        gaOut init 0

        instr 2

            ;MASTER OUT
            gkOut cabbageGetValue "out"

            ;INVILUPPO
            gkAtt cabbageGetValue "att"
            gkDec cabbageGetValue "dec"
            gkSus cabbageGetValue "sus"
            gkRel cabbageGetValue "rel"

            ;TIPI DI ONDE
            gkONDE cabbageGetValue "onde"

            gkTrig cabbageGetValue "trigger"
            kout trigger gkTrig, 0.5 ,2

            if(kout > 0.5)then
                event "i", 10, 0, 0.1;CHIAMA LO STRUMENTO 10 per cambiare il tipo di onda
            else
            endif

        endin


        instr 1

            ;dalla tastiera virtuale
            kAmp = p5
            kFreq = p4 

            ;OSCILLATORE SINTESI ADDITIVA CON FUNZIONI GEN (vedi nello score)
            aSig oscili kAmp, kFreq, giONDA

            ;INVILUPPO
            iAtt = i(gkAtt)
            iDec = i(gkDec)
            iSus = i(gkSus)
            iRel = i(gkRel)
            aEnv madsr iAtt, iDec, iSus, iRel

            ;APPLICAZIONE INVILUPPO
            aSigEnv = aSig * aEnv

            ;USCITA VERSO LO STRUMENTO 50
            ;accumulo della variabile globale per avere un segnale costante
            ;altrimenti sentiremo un troncamento del segnale  - ESEMPIO TRONCAMENTO SEGNALE
            gaOut = gaOut + aSigEnv 

        endin


        instr 50; USCITE

            aSigEnv = gaOut

            aOut = aSigEnv * gkOut; moltiplico per il controllo gkOut per regolare l'ampiezza

            outs aOut, aOut

            display	aOut, .1, 1 ;oscilloscopio, visualizzazione segnali

            gaOut = 0

        endin


        instr 10

            if( i(gkONDE) == 1 ) then

            giONDA = 1

            elseif ( i(gkONDE) == 2 ) then

            giONDA = 2

            elseif ( i(gkONDE) == 3 ) then

            giONDA = 3

            elseif ( i(gkONDE) == 4 ) then

            giONDA = 4

            endif

        endin

    </CsInstruments>

    <CsScore>
        ;causes Csound to run for about 7000 years...
        f0 z
        f1 0 4096 10 1 ;SINUSOIDE
        f2 0 4096 10 1 0 [1/3] 0 [1/5] 0 [1/7] 0 [1/9] 0 [1/11] 0 [1/13] 0 [1/15] ;ONDA QUADRA
        f3 0 4096 10 1 [1/2] [1/3] [1/4] [1/5] [1/6] [1/7] [1/8] [1/9] [1/10] [1/11] [1/12] [1/13] [1/14] ;ONDA DENTE DI SEGNA
        f4 0 4096 10 1 0 [1/3^2] 0 [1/5^2] 0 [1/7^2] 0 [1/9^2] 0 [1/11^2] 0 [1/13^2] 0 [1/15^2] ;TRIANGOLARE 


        i2 0 [60*60*24*7]; strumento 2 sempre acceso per 1 settimana
        i50 0 [60*60*24*7]
    </CsScore>

</CsoundSynthesizer>
