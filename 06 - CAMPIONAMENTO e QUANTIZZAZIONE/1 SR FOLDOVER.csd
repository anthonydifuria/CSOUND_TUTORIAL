<Cabbage>

    form caption("SR - FOLDOVER") size(400, 300), guiMode("queue") pluginId("def1")
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
        iScaleFactor = 4; da 1 a sr/2
        iSR = 44100 / iScaleFactor

        kFold = sr / iSR ;CAMBIO FOLDOVER

        aSig oscili 1, 11025

        a0ut fold aSig , kFold ;FOLDOVER

        outs a0ut, a0ut
        endin

    </CsInstruments>

    <CsScore>
        ;causes Csound to run for about 7000 years...
        f0 z
        ;starts instrument 1 and runs it for a week
        i1 0 [60*60*24*7] 
    </CsScore>

</CsoundSynthesizer>
