<Cabbage>
    form caption("ARRAY 1") size(400, 300), guiMode("queue"), pluginId("def1")

</Cabbage>

<CsoundSynthesizer>

    <CsOptions>
        -n -d -+rtmidi=NULL -M0 -m0d --midi-key-cps=4 --midi-velocity-amp=5
    </CsOptions>
    
    <CsInstruments>
        ; Initialize the global variables. 
        ksmps = 32
        nchnls = 2
        0dbfs = 1

        ;instrument will be triggered by keyboard widget
        instr 1

        iArr[]   init 4

        iArr[] fillarray 1, 2, 3, 4

        print iArr[1]


        iArrBi[][] init 2, 3

        iArrBi fillarray 1, 2, 3, -1, -2, -3

        print iArrBi[1][0]

    endin

    instr 2

        iArr1[] genarray   1, 5 ; creates i-array with [1, 2, 3, 4, 5]
        kArr2[] genarray_i 1, 5 ; creates k-array at init-time with [1, 2, 3, 4, 5]
        iArr3[] genarray   -1, 1, 0.5 ; i-array with [-1, -0.5, 0, 0.5, 1]
        iArr4[] genarray   1, -1, -0.5 ; [1, 0.5, 0, -0.5, -1]
        iArr5[] genarray   -1, 1, 0.6 ; [-1, -0.4, 0.2, 0.8]

        iLen     =      lenarray(iArr1)

        print iLen

    endin

    </CsInstruments>
    
    <CsScore>
        ;causes Csound to run for about 7000 years...
        f0 z
        i 1 0 360
        i 2 0 360
    </CsScore>
    
</CsoundSynthesizer>
