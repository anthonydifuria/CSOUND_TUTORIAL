<Cabbage>
    form caption("BITTER") size(500, 300), guiMode("queue"), pluginId("def1")
</Cabbage>

<CsoundSynthesizer>

    <CsOptions>
        -n -d -+rtmidi=NULL -M0 -m0d --midi-key-cps=4 --midi-velocity-amp=5
    </CsOptions>
    
    <CsInstruments>
        ;Initialize the global variables. 
        ksmps = 32
        nchnls = 2
        0dbfs = 1
		
        instr 1	

            setksmps 1

            kbit = 4
            ksrate = sr

            aEnv linseg 0, 0.1, 1
            aSig oscili 0.5, 400
            aSigEnv = aSig * aEnv

            kbits = 2^kbit                           ;bit depth (1 to 16)
            kfold = (sr/ksrate)                      ;sample rate
            kin downsamp aSigEnv                     ;convert to kr
            kDCoffset = (kin+0dbfs)                  ;add DC to avoid (-)
            kScale = kDCoffset * (kbits/(0dbfs*2))   ;scale signal level
            kQuant = int(kScale)                     ;quantise
            aout upsamp kQuant                       ;convert to sr
            aout = aout*(2/kbits)-0dbfs              ;rescale and remove DC
            a0ut fold aout, kfold                    ;resample
       
            printks "bitrate = %d, ", 3, kbit
            printks "with samplerate = %d\\n", 3, ksrate
            outs a0ut * 0.1, a0ut * 0.1
 
        endin

    </CsInstruments>
    
    <CsScore>
        ;causes Csound to run for about 7000 years...
        f0 z
        i1 0 [60*60*24*7]
    </CsScore>
    
</CsoundSynthesizer>
