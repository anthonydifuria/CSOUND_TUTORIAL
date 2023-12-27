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

 ihopsize = 128   ;OVERLAP SIZE
 ifftsize = 1024  ;FFT SIZE 
 iolaps = ifftsize/ihopsize ;OVERLAPS
 ibw = sr/ifftsize ; BIN BANDWITH
 kcnt init 0    ;CONTATORE
 krow init 0

 kOla[] init ifftsize ;BUFFER OVERLAPS
 kIn[] init ifftsize  ;INPUT BUFFER
 kOut[][] init iolaps, ifftsize ;OUTPUTS BUFFER
 
 Sfile     = "AnechoicOrch.wav"  ;FILE PATH
 a1, a2 diskin Sfile, 1, 0, 1    ;FILE PLAYER     

if kcnt >= ihopsize then

 ;/-------FFT-------/
 kWin[] window kIn, krow * ihopsize ;WINDOWS FFT
 kSpec[] rfft kWin ;FFT
 
 
   iFreq = 3000 ;FREQUENZA DI TAGLIO
   iBandeHIGHPASS = int((iFreq) / ibw) ;NUMERO DI BANDE HIGHPASS
   
   ki = 0 
   until ki == int(ifftsize) do
   
   if ki < iBandeHIGHPASS then
   kSpec[ki] = 0
   endif
   
     ki += 1
   od
 
   ;/-------IFFT-------/
   kRow[] rifft kSpec
   kWin window kRow, krow * ihopsize
   
   ;OUT BUFFER
   kOut setrow kWin, krow

   ;BUFFER OVERLAPS
   kOla = 0
   ;ADD OVERLAPS
   ki = 0
   until ki == iolaps do
     kRow getrow kOut, ki
     kOla = kOla + kRow
     ki += 1
   od
  
  ;CONTATORE
  krow = (krow + 1) % iolaps ;CONTATORE OVERLAPS
  kcnt = 0 ;CONTATORE FFT TORNA A 0
 endif

 ;SCRIVO E LEGGO BUFFER UNIDIMENSIONALE
 kIn shiftin a1
 a2 shiftout kOla / iolaps
    out a2

 ;INCREMENTO CONTATORE FFT
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
