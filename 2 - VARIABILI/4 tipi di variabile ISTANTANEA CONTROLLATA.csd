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

ktrig metro 1; manda un trig ogni secondo a schedkwhen che accenderà lo strumento 2 per una durata di 0.5 secondi

schedkwhen ktrig, 0,0,2,0,0.5
;VEDREMO NEL DETTAGLIO IL FUNZIONAMENTO DI QUESTO PROCESSO

endin

instr 2

; Ogni volta che verrà chiamato (acceso) lo strumento 2 il valore di iFrequenza cambierà tra 400 e 500 in mondo randomico
iFrequenza = 400 + rnd(100) ;(400 valore più basso) + (rnd(100) valore randomico tra 0 e 100)

print iFrequenza

aSignal oscili 0.1, iFrequenza
;outs aSignal, aSignal

endin

</CsInstruments>
<CsScore>
;causes Csound to run for about 7000 years...
f0 z
;starts instrument 1 and runs it for a week
i1 0 [60*60*24*7] ;DA NOTARE CHE LO STRUMENTO 1 è SEMPRE ACCESO e lo strumento 2 VIENE ACCESO da schedkwhen
</CsScore>
</CsoundSynthesizer>
