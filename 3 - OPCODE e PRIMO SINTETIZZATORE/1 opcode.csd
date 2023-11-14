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
ksmps = 10
nchnls = 2
0dbfs = 1


instr 1

;OPCODE: Operation code o codice operativo (sono le funzioni fondamentali di csound che ci permettono di costruire i nostri algoritmi audio o di controllo)
;VEDI CSOUND MANUAL in alto nell'help

;gli opcode che prenderemo in esame adesso sono "oscili" e "outs"
;oscili avrà il compito di generare una sinusoide a 400 hz e ampiezza 0.1 e outs è il collegamento con il DAC per permetterci di ascoltare il suono
kSignal oscili 0.1, 400

aSignal upsamp kSignal

outs aSignal, aSignal ;"outs" uscite stereo

endin


</CsInstruments>

<CsScore>
;causes Csound to run for about 7000 years...
f0 z

i1 0 [60*60*24*7] ;accende lo strumento 1 per una settimana
</CsScore>

</CsoundSynthesizer>
