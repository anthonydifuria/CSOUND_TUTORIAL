<Cabbage>

    form caption("SR EVENT GENERATOR") size(400, 300), guiMode("queue") pluginId("def1")
    rslider bounds(296, 162, 100, 100), channel("gain"), range(0, 1, 0, 1, .01), text("Gain"), trackerColour("lime"), outlineColour(0, 0, 0, 50), textColour("black")

</Cabbage>

<CsoundSynthesizer>

    <CsOptions>
        -n -d -+rtmidi=NULL -M0 -m0d 
    </CsOptions>

    <CsInstruments>
        ; Initialize the global variables. 
        ksmps = 1
        nchnls = 2
        0dbfs = 1

        instr 1

            ktrig metro 20
            gkDur = 5
            schedkwhen ktrig, 0, 0, 2, 0, gkDur

        endin

        instr 2
            iFactor = (rnd(10000) + 1)
            iScaleFactor = iFactor; da 1 a sr/2
            iSR = 44100 / iScaleFactor

            kFold = sr / iSR ;CAMBIO FOLDOVER

            aSig oscili 0.001 / int(rnd(10) + 1), 100 * int(rnd(10) + 1)
            aEnv linseg 0, i(gkDur), 1, i(gkDur), 0

            a0ut fold aSig , kFold ;FOLDOVER

            outs a0ut * aEnv, a0ut * aEnv
        endin

    </CsInstruments>

    <CsScore>
        ;causes Csound to run for about 7000 years...
        f0 z
        ;starts instrument 1 and runs it for a week
        i1 0 [60*60*24*7] 
    </CsScore>
</CsoundSynthesizer>
