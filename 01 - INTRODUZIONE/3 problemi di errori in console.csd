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
    ksmps = 32
    nchnls = 2
    0dbfs = 1


    instr 1

        iFrequenza = 200

        print ifrequenza

        ;error:  Variable 'ifrequenza' used before defined
        ;Line 21
        ;Csound ci sta comunicando che la variabile ifrequenza non è stata definita prima di essere utilizzata,
        ;questo perché ifrequenza ha la f minuscola, quindi il linguaggio la riconosce come se fosse un altra variabile
        ;per risolvere il problema le due variabili devono avere lo stesso nome come di seguito

        ;RISOLUZIONE PROBLEMA
        ;iFrequenza = 200

        ;print iFrequenza

    endin

</CsInstruments>

<CsScore>
    ;causes Csound to run for about 7000 years...
    f0 z
    ;starts instrument 1 and runs it for a week
    i1 0 [60*60*24*7] 
</CsScore>

</CsoundSynthesizer>
