<Cabbage>
form caption("AM - II mondalità") size(400, 300), guiMode("queue") pluginId("def1")
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
kgain cabbageGetValue "gain"

aSigMod oscili 1, 100  ;Segnale Modulante BIPOLARE
aSigCar oscili aSigMod, 1000 ;Segnale Portante

aRM = aSigCar ;Modulazione ad Anello
     
aSigMod2 oscili 1, 100  ;Segnale Modulante 
aSigModUnipolare = (aSigMod2 + 1) / 2 ;Segnale Modulante UNIPOLARE
aSigCar2 oscili aSigModUnipolare, 1000 ;Segnale Portante

aAM = aSigCar2 ;Modulazione Ampiezza


outs aAM * kgain, aAM * kgain

endin

</CsInstruments>
<CsScore>
;causes Csound to run for about 7000 years...
f0 z
;starts instrument 1 and runs it for a week
i1 0 [60*60*24*7] 
</CsScore>
</CsoundSynthesizer>
