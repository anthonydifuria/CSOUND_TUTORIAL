<Cabbage>
form caption("Untitled") size(400, 300), guiMode("queue") pluginId("def1")

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


ifftsize  = 2048
ibw = sr / ifftsize ; BIN BANDWITH
giTabSize = ifftsize 
ioverlap  = ifftsize / 4
iwinsize  = ifftsize
iwinshape = 1							;von-Hann window
Sfile     = "1 Anechoic orchestra.wav"
ain,ain2 diskin Sfile, 1, 0, 1

fftin     pvsanal ain, ifftsize, ioverlap, iwinsize, iwinshape	;fft-analysis of the audio-signal

    kIn[] init giTabSize
    kOut[] init giTabSize
    
   kframe  pvs2tab kIn , fftin ; Copies spectral data to k-rate arrays

kCount init 0   
    
   kCenterFreq = 2000 ;FREQUENZA DI TAGLIO
   kFreqBW = 2000

   kBandeInf = int(((kCenterFreq) - (kFreqBW / 2)) / ibw) ;NUMERO DI BANDE INFERIORI
   kBandeSup = int(((kCenterFreq) + (kFreqBW / 2))  / ibw);NUMERO DI BANDE SUPERIORI
   

    if kCount > ioverlap then
   
      
   
           kIndex = 0 
           until kIndex == int(ifftsize) do
   
           if kIndex > kBandeInf && kIndex < kBandeSup then  
             kOut[kIndex] = kIn[kIndex]
           else
             kOut[kIndex] = 0
           endif
   
             kIndex = kIndex + 1
           od
        
       kCount = 0  
        
    endif
     
    fOut1 tab2pvs kOut, ioverlap, iwinsize, iwinshape
 
    aout pvsynth fOut1

    out aout, aout
          
    kCount = kCount + ksmps
    
endin




</CsInstruments>
<CsScore>
;causes Csound to run for about 7000 years...
f0 z
;starts instrument 1 and runs it for a week
i1 0 [60*60*24*7] 
</CsScore>
</CsoundSynthesizer>
