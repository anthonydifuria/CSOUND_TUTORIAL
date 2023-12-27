<Cabbage>

form caption("FUNZIONI GEN 1") size(400, 300), guiMode("queue") pluginId("def1")
rslider bounds(296, 202, 100, 100), channel("master"), range(0, 1, 0.5, 1, .01), text("MASTER"), trackerColour("lime"), outlineColour(0, 0, 0, 50), textColour("black")
signaldisplay bounds(10, 8, 362, 187), colour("black") displayType("waveform"), backgroundColour(255, 255, 255), zoom(0.5), signalVariable("aOutMaster", "aOutMaster"), channel("display")

</Cabbage>
<CsoundSynthesizer>
<CsOptions>
-n --displays -+rtmidi=NULL -M0 
</CsOptions>

<CsInstruments>
    ;sr is set by the host
    ksmps = 16 
    nchnls = 2  
    0dbfs=1 

    instr 1 

        kMasterOut cabbageGetValue "master" 

        aOutMaster oscili kMasterOut,20,  1
                                        ;numero della funzione
                                        ;cambiando il numero possiamo visualizzare 
                                        ;la forma dell'onda generata

        display	aOutMaster, .1, 1 ;oscilloscopio, visualizzazione segnali

    endin

    </CsInstruments>
    <CsScore>
        f0 z
        ;TABELLA FUNZIONI GEN
        ;f1(funzione 1) - 0 - 4096(grandezza della tabella 4096 campioni) - 10(tipo di GEN vedi manuale) - 1(frequenza fondamentale di ampiezza 1)
        ;a seguiro possiamo inserire le ampiezze dele altre parziali della serie armonica

        f1 0 4096 10 1 ;SINUSOIDE
        f2 0 4096 10 1 0 [1/3] 0 [1/5] 0 [1/7] 0 [1/9] 0 [1/11] 0 [1/13] 0 [1/15] ;ONDA QUADRA
        f3 0 4096 10 1 [1/2] [1/3] [1/4] [1/5] [1/6] [1/7] [1/8] [1/9] [1/10] [1/11] [1/12] [1/13] [1/14] ;ONDA DENTE DI SEGNA
        f4 0 4096 10 1 0 [1/3^2] 0 [1/5^2] 0 [1/7^2] 0 [1/9^2] 0 [1/11^2] 0 [1/13^2] 0 [1/15^2] ;TRIANGOLARE 

        f5 0 1025 20 2							; CAMPANA DI GAUSS
        f6 0 1025  7 0 128 1 768 1 120 0 8 0		; TRAPEZIO

        ;struemnto 1 parte a 0 e termina a [60*60*24*7]
        i1 0 [60*60*24*7] 
    </CsScore>

</CsoundSynthesizer>
