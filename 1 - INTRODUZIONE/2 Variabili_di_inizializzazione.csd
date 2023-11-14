<Cabbage>
form caption("Untitled") size(400, 300), guiMode("queue") pluginId("def1")
rslider bounds(296, 162, 100, 100), channel("gain"), range(0, 1, 0, 1, .01), text("Gain"), trackerColour("lime"), outlineColour(0, 0, 0, 50), textColour("black")

</Cabbage>

<CsoundSynthesizer>

<CsOptions>
-n -d -+rtmidi=NULL -M0 -m0d 
</CsOptions>

<CsInstruments>
;Initialize the global variables. 

;sr è la varibaile che inizializza la frequenza di campionameto, nel caso di cabbage prende la sr direttamente dal software,
;basta cliccare in alto sul simbolo della chiave e il cacciavite
;sr = 44100
;kr = 4410
ksmps = 10 ;indica il rapporto tra la frequenza di campionamento e la velocità dei controlli
;se ksmps = 10 vuol dire che i campioni per il controllo sono 10 volte di meno rispetto alla frequenza di campionamento
nchnls = 2; indica il numero di canali audio che possiamo utilizzare nel nostro codice (in entrata e in uscita)
0dbfs = 1; normalizzazione delle ampiezze tra 0 e 1 (0: assenza di suono - 1: massima ampiezza)


instr 1


;esempio
iSampleRate = 44100 
iControlRate = 4410

iKSMPS = iSampleRate / iControlRate

print iKSMPS ;stampa iKSMPS in console sotto


endin

</CsInstruments>

<CsScore>
;causes Csound to run for about 7000 years...
f0 z
;starts instrument 1 and runs it for a week
i1 0 [60*60*24*7] 
</CsScore>

</CsoundSynthesizer>
