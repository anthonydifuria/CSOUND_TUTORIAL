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


kGlissato linseg  400, 10, 1000 ; Generiamo una funzione lineare che dal valore 400 in 10 secondi arriva al valore 1000
;kGlissato è una variabile di tipo "k" , la frequenza di campionamento di questa variabile è regolata da kr 
;kr = sr / ksmps - poichè sr = 44100 e ksmps = 10, significa che questa variabile ha 4410 campioni al secondo, quindi è 10 volte più lenta e meno precisa di una variabile "a"
; che invece procede con la frequenza di campionamento = 44100
;IMPORTANTE - utilizzeremo queste varibili per tutti i controlli che sono più lenti dell'audio.
;ESEMPIO DEL VIOLINISTA - Il suono di una nota di violino a 1000 hz ha delle variazioni tra un massimo e un minimo di 1000 volte al secondo,
; invece l'esecutore non riuscirà ad alternare la sua arcata più di 20 volte al secondo, nel primo caso avremo variabili "a" audio nel secondo variabili "k" di conrollo

aSignal oscili 0.1, kGlissato ;kGlissato controlla la frequenza dell'oscillatore partendo da 400 hz fino a 1000 hz in 10 secondi
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
