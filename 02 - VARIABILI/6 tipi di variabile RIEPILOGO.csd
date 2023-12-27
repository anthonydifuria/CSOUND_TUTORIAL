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

        ;IMPORNTANTISSIMO: PER SCRIVERE CORRETTAMENTE UNA VARIABILE
        ; es. ISTANTANEA iNOMEVARIBILE  -  iFrequenza o iAmpiezza o iGiovanni - il nome della varibile deve essere preceduto sempre dalla lettara "i" minuscola
        ; es. CONTROLLO kNOMEVARIBILE  -  kFrequenza o kAmpiezza o kGiovanni - il nome della varibile deve essere preceduto sempre dalla lettara "k" minuscola
        ; es. AUDIO aNOMEVARIBILE  -  aFrequenza o aAmpiezza o aGiovanni - il nome della varibile deve essere preceduto sempre dalla lettara "a" minuscola
        ; es. GLOBALE INSTANTANEA giNOMEVARIBILE  -  giFrequenza o giAmpiezza o giGiovanni - il nome della varibile deve essere preceduto sempre dalla lettara "gi" minuscola
        ; es. GLOBALE CONTROLLO gkNOMEVARIBILE  -  gkFrequenza o gkAmpiezza o gkGiovanni - il nome della varibile deve essere preceduto sempre dalla lettara "gk" minuscola
        ; es. GLOBALE AUDIO gaNOMEVARIBILE  -  gaFrequenza o gaAmpiezza o gaGiovanni - il nome della varibile deve essere preceduto sempre dalla lettara "ga" minuscola
        instr 1

        iCOSTANTE = 100; varibile di tipo "i"
        print iCOSTANTE

        kCONTROLLO = 200; variabile di tipo "k"
        printk 2, kCONTROLLO

        giFrequenza = 400; variabile di tipo "g" instantanea
        gkFrequenza = 800; variabile di tipo "g" controllo

        endin

        instr 2

        ;aSignal1 e aSignal2 variabili di tipo "a"
        aSignal1 oscili 0.1, giFrequenza

        aSignal2 oscili 0.1, gkFrequenza

        gaOut = (aSignal1 + aSignal2) / 2; gaOut -> variabile di tipo "g" audio 

        endin


        instr 3

        outs gaOut, gaOut; varibile di tipo "g" audio

        gaOut = 0 ;per evitare l'accumulo del flusso audio (LO VEDREMO IN SEGUITO)

        endin

    </CsInstruments>

    <CsScore>
        ;causes Csound to run for about 7000 years...
        f0 z

        i1 0 [60*60*24*7] ;accende lo strumento 1
        i2 0 [60*60*24*7] ;accende lo strumento 2
        i3 0 [60*60*24*7] ;accende lo strumento 3
    </CsScore>

</CsoundSynthesizer>
