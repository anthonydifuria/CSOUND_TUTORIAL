<Cabbage>
    form caption("ARRAY 3") size(400, 300), guiMode("queue"), pluginId("def1")

</Cabbage>

<CsoundSynthesizer>

    <CsOptions>
        -n -d -+rtmidi=NULL -M0 -m0d --midi-key-cps=4 --midi-velocity-amp=5
    </CsOptions>

    <CsInstruments>
    ; Initialize the global variables. 
    ksmps = 10
    nchnls = 2
    0dbfs = 1

    instr 1
    
        iArr[] array 1, 2, 3
        iArr[0] = iArr[0] + 10
        prints "   iArr[0] = %d\n\n", iArr[0]
        
    endin

    instr 2
        
        kArr[] array 1, 2, 3
        kArr[0] = kArr[0] + 1
        printks "   kArr[0] = %d\n\n", 0, kArr[0]
    
    endin

    </CsInstruments>
    
    <CsScore>
        ;causes Csound to run for about 7000 years...
        f0 z
        i 1 0 1
        i 2 0 1
    </CsScore>
    
</CsoundSynthesizer>
