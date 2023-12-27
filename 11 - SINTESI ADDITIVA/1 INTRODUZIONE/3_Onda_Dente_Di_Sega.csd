<Cabbage>

    form caption("Untitled") size(400, 300), guiMode("queue") pluginId("def1")
    rslider bounds(296, 202, 100, 100), channel("master"), range(0, 1, 0, 1, .01), text("MASTER"), trackerColour("lime"), outlineColour(0, 0, 0, 50), textColour("black")
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

        kfreq = 500 
        kamp = 1 

        ;OSCILLATORI SINTESI ADDITIVA - SERIE ARMONICA - ONDA DENTE DI SEGA
        ;ARMONICHE ONDA DENTE DI SEGA = (I) + (II / 2) + (III / 3) + (IV / 4) + (V / 5)
        a1f oscili kamp / 1, 1 * kfreq ;FONDAMENTALE 1F 
        a2f oscili kamp / 2, 2 * kfreq ; 2F  
        a3f oscili kamp / 3, 3 * kfreq ; 3F
        a4f oscili kamp / 4, 4 * kfreq ; 4F  
        a5f oscili kamp / 5, 5 * kfreq ; 5F

        aOut = ((a1f + a2f + a3f + a4f + a5f) / 5); sommo i segnali e li divido per il numero dei segnali
                                                  ; per non avere saturazione del segnale
        aOutMaster = aOut * kMasterOut

        outs aOutMaster, aOutMaster 

        display	aOutMaster, .1, 1 ;oscilloscopio, visualizzazione segnali

    endin

    </CsInstruments>
    
    <CsScore>
        f0 z
        ;struemnto 1 parte a 0 e termina a [60*60*24*7]
        i1 0 [60*60*24*7] 
    </CsScore>
    
</CsoundSynthesizer>
