<Cabbage>
form caption("Untitled") size(400, 300), guiMode("queue") pluginId("def1")
rslider bounds(296, 162, 100, 100), channel("trans"), range(0, 1, 0, 0.5, .01), text("trans"), trackerColour("lime"), outlineColour(0, 0, 0, 50), textColour("black")

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
ain1,ain2 diskin Sfile, 1, 0, 1

Sfile2     = "AnechoicOrch.wav"
ain3,ain4 diskin Sfile2, 1, 0, 1

;ain1 oscili 1,400
;ain3 oscili 1, 500


fsig     pvsanal ain1, ifftsize, ioverlap, iwinsize, iwinshape	;fft-analysis of the audio-signal
fsig2     pvsanal ain3, ifftsize, ioverlap, iwinsize, iwinshape	;fft-analysis of the audio-signal

 fcross pvscross fsig2, fsig, kTrans, 1 - kTrans
 
aout      pvsynth fcross					;resynthesis
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
