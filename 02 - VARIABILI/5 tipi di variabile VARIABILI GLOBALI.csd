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

            ;la varibile globale è di tipo "g" e viene utilizzata quando dobbiamo scambiare (flussi audio, valori di controllo e valori instantanei tra diversi strumenti)
            gkGlissato linseg 400, 10, 1000

        endin

        instr 2

            aSignal oscili 0.1, gkGlissato
            outs aSignal, aSignal

        endin

    </CsInstruments>

    <CsScore>
        ;causes Csound to run for about 7000 years...
        f0 z

        i1 0 [60*60*24*7] ;accende lo strumento 1
        i2 0 [60*60*24*7] ;accende lo strumento 2
    </CsScore>

</CsoundSynthesizer>
