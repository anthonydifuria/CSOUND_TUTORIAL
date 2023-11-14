<Cabbage>
form caption("Sottrattiva Band Pass") size(400, 300), guiMode("queue") pluginId("def1")
rslider bounds(296, 162, 100, 100), channel("gain"), range(0, 1, 0, 1, .01), text("Gain"), trackerColour("lime"), outlineColour(0, 0, 0, 50), textColour("black")
rslider bounds(96, 162, 100, 100), channel("freqBandPass"), range(20, 1000, 100, 1, .01), text("FREQ BAND PASS"), trackerColour("lime"), outlineColour(0, 0, 0, 50), textColour("black")
rslider bounds(196, 162, 100, 100), channel("band"), range(50, 1000, 100, 1, .01), text("WIDTH BAND"), trackerColour("lime"), outlineColour(0, 0, 0, 50), textColour("black")


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
kfreqBandPass cabbageGetValue "freqBandPass"; Controlla la frequenza di centro banda in hz
kWidhtBand cabbageGetValue "band"; larghezza di banda in hz


aPinkNoise pinker ; Generatore di rumore rosa
a1 butterbp aPinkNoise, kfreqBandPass * 1, kWidhtBand ;filtro Band-Pass
a2 butterbp aPinkNoise, kfreqBandPass * 2, kWidhtBand ;filtro Band-Pass
a3 butterbp aPinkNoise, kfreqBandPass * 3, kWidhtBand ;filtro Band-Pass
a4 butterbp aPinkNoise, kfreqBandPass * 4, kWidhtBand ;filtro Band-Pass
a5 butterbp aPinkNoise, kfreqBandPass * 5, kWidhtBand ;filtro Band-Pass

aOut = (a1 + a2 + a3 + a4 + a5) / 5

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
