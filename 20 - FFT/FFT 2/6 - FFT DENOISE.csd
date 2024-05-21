<Cabbage>
form caption("Untitled") size(400, 300), guiMode("queue") pluginId("def1")
rslider bounds(296, 162, 100, 100), channel("denoise"), range(0, 0.1, 1, 1, 0.0001), text("denoise"), trackerColour("lime"), outlineColour(0, 0, 0, 50), textColour("black")

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

kdenoise cabbageGetValue "denoise"

ifftsize  = 4096
ibw = sr / ifftsize ; BIN BANDWITH
iNumBin = ifftsize / 2
giTabSize = (ifftsize / 2) + 2
ioverlap  = ifftsize / 4
iwinsize  = ifftsize
iwinshape = 1							;von-Hann window
Sfile     = "3 Fiume.wav"
ain,ain2 diskin Sfile, 1, 0, 1

fftin     pvsanal ain, ifftsize, ioverlap, iwinsize, iwinshape	;fft-analysis of the audio-signal

    kInMag[] init giTabSize
    kInFreq[] init giTabSize
    kOutMag[] init giTabSize
    kOutFreq[] init giTabSize

    
   kframe  pvs2tab kInMag, kInFreq, fftin ; Copies spectral data to k-rate arrays

kDenoise = kdenoise

kCount init 0 


    if kCount >= ioverlap then
 
   ki = 0 
   until ki == iNumBin do

   kOutMag[ki] = kInMag[ki]
   
    if abs(kOutMag[ki]) < kDenoise then
     kOutMag[ki] = 0
  endif
   
   kOutFreq[ki] = kInFreq[ki]

     ki += 1
   od

    
    ;kOutFreq = kInFreq
        
       kCount = 0  
        
    endif
     
    fOut1 tab2pvs kOutMag, kOutFreq, ioverlap, iwinsize, iwinshape
 
    aout pvsynth fOut1

    out aout , aout 
          
    kCount = kCount + 32 
endin




</CsInstruments>
<CsScore>
;causes Csound to run for about 7000 years...
f0 z
;starts instrument 1 and runs it for a week
i1 0 [60*60*24*7] 
</CsScore>
</CsoundSynthesizer>
