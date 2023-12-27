<Cabbage>
form caption("Untitled") size(400, 300), guiMode("queue") pluginId("def1")
rslider bounds(296, 162, 100, 100), channel("trans"), range(0, 1, 0, 1, .01), text("trans"), trackerColour("lime"), outlineColour(0, 0, 0, 50), textColour("black")

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

kTrans cabbageGetValue "trans"

ifftsize  = 2048
ioverlap  = ifftsize / 4
iwinsize  = ifftsize
iwinshape = 1							;von-Hann window
Sfile     = "SOMIERE.wav"
ain,ain2       soundin Sfile

Sfile2     = "AnechoicOrch.wav"
ain3,ain4     soundin Sfile2

;ain oscili 1, 400
;ain3 oscili 1, 500


;ktrans linseg 0,5,1


fsig     pvsanal ain, ifftsize, ioverlap, iwinsize, iwinshape	;fft-analysis of the audio-signal
fsig2     pvsanal ain3, ifftsize, ioverlap, iwinsize, iwinshape	;fft-analysis of the audio-signal

fsig pvsmorph fsig, fsig2 ,kTrans , kTrans
 
aout      pvsynth fsig					;resynthesis
          outs	  aout, aout
endin




</CsInstruments>
<CsScore>
;causes Csound to run for about 7000 years...
f0 z
;starts instrument 1 and runs it for a week
i1 0 [60*60*24*7] 
</CsScore>
</CsoundSynthesizer>
