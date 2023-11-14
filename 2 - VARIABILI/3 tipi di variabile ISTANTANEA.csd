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

iFrequenza = 400; iFrequenza è una varibile istantanea e viene utilizzata una sola volta per tutta la durata dello strumento
;verrà utilizzata per impostare dei valori costanti che devono essere utilizzati per tutta la durata dello strumento.
; è una varibile molto più lenta dell varibili che abbiamo appena visto poiché è utilizzata una sola volta e non abbiamo la possibilità
; di cambiarla per tutta la durata dello strumento.
; IMPORTANTE: è possibile cambiarla se lo strumento viene acceso e spento più volte - questo lo vedremo nel prossimo esempio

aSignal oscili 0.1, iFrequenza
outs aSignal, aSignal

endin

</CsInstruments>
<CsScore>
;causes Csound to run for about 7000 years...
f0 z
;starts instrument 1 and runs it for a week
i1 0 [60*60*24*7] 
</CsScore>
</CsoundSynthesizer>
