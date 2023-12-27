<Cabbage>; INTERFACCIA GRAFICA - qui andreamo ad inserire il codice per disegnare la nostra interfaccia grafica

    form caption("PARTI DEL CODICE") size(400, 300), guiMode("queue") pluginId("def1")
    rslider bounds(296, 162, 100, 100), channel("gain"), range(0, 1, 0, 1, .01), text("Gain"), trackerColour("lime"), outlineColour(0, 0, 0, 50), textColour("black")

</Cabbage>;FINE INTERFACCIA GRAFICA

<CsoundSynthesizer>; DA QUI INIZIA IL NOSTRO SINTETIZZATORE e finisce </CsoundSynthesizer>

<CsOptions>;QUI INSERIREMO LE NOSTRE OPZIONI DI BASE
 -n -d -+rtmidi=NULL -M0 -m0d 
</CsOptions>

<CsInstruments>; DA QUI fino a </CsInstruments> scrivemo il codice per costruire i nostri strumenti
   
    ;Initialize the global variables. 
    ksmps = 10
    nchnls = 2
    0dbfs = 1


    instr 1

        prints "GIORGIO"
        iAmp = 1
        print iAmp
        kAmp = 1
        printk 1, kAmp
    
    endin

</CsInstruments>

<CsScore>; DA QUI fino a </CsScore> scriveremo la nostra partitura per accendere i nostri strumenti
    ;causes Csound to run for about 7000 years...
    f0 z
    ;starts instrument 1 and runs it for a week
    i1 0 [60*60*24*7] 
</CsScore>

</CsoundSynthesizer>
