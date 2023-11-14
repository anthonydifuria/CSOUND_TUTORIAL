<Cabbage>
form caption("Sottrattiva Low Pass") size(400, 300), guiMode("queue") pluginId("def1")
rslider bounds(296, 162, 100, 100), channel("gain"), range(0, 1, 0, 1, .01), text("Gain"), trackerColour("lime"), outlineColour(0, 0, 0, 50), textColour("black")
rslider bounds(196, 162, 100, 100), channel("freqLowPass"), range(100, 20000, 10000, 1, .01), text("FREQ LOW PASS"), trackerColour("lime"), outlineColour(0, 0, 0, 50), textColour("black")

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
kGain cabbageGetValue "gain" ; Controlla l'ampiezza in uscita
kfreqLowPass cabbageGetValue "freqLowPass"; Controlla la frequenza di taglio

aPinkNoise pinker ; Generatore di rumore rosa
aOut butterlp aPinkNoise, kfreqLowPass ;filtro Low Pass

outs aOut*kGain, aOut*kGain ;Uscita Suono Filtrato

endin

</CsInstruments>
<CsScore>
;causes Csound to run for about 7000 years...
f0 z
;starts instrument 1 and runs it for a week
i1 0 [60*60*24*7] 
</CsScore>
</CsoundSynthesizer>
