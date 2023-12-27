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

        ihopsize = 32 
        ifftsize = 4096  
        iolaps = ifftsize/ihopsize 
        ibw = sr/ifftsize
        kcnt init 0 
        krow init 0

        kOla[] init ifftsize 
        kIn[] init ifftsize 
        kOut[][] init iolaps, ifftsize 
        kAmps[] init ifftsize
        kCent[] init ifftsize
        kSpread[] init ifftsize

        a1  gauss 1;SEGNALE 
 
        if kcnt == ihopsize then  
            kWin[] window kIn,krow*ihopsize
            kSpec[] rfft kWin

            kAmps[] mags kSpec;AMPIEZZE FFT

            kAMP sumarray kAmps;SOMMA AMPIEZZE FFt
    
            kIndex = 0
            until kIndex == ifftsize / 2  do
                kCent[kIndex] = ((ibw) * kIndex) * (kAmps[kIndex]) / (kAMP);CALCOLO IL CENTROIDE 
                kIndex += 1
            od
            kCENROID sumarray kCent;SOMMA
            ;printk 0.1, kCENROID

            kIndex2 = 0
            until kIndex2 == ifftsize / 2  do
                kSpread[kIndex2] = (ibw * kIndex2 - kCENROID) ^ 2 * (kAmps[kIndex2]) / (kAMP)
                kIndex2 += 1
            od
            kSPREAD sumarray (kSpread)
            printk 0.1, sqrt(kSPREAD) / 7000
   
            krow = (krow+1)%iolaps
            kcnt = 0
        endif

        kIn shiftin a1

        kcnt += ksmps

        endin

    </CsInstruments>

    <CsScore>
    ;causes Csound to run for about 7000 years...
    f0 z
    ;starts instrument 1 and runs it for a week
    i1 0 [60*60*24*7] 
    </CsScore>
</CsoundSynthesizer>
