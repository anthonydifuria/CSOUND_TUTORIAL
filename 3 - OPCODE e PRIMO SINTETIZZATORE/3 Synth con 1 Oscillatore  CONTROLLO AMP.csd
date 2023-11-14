<Cabbage>

form caption("Untitled") size(400, 300), guiMode("queue"), pluginId("def1")
keyboard bounds(8, 158, 381, 95)

rslider bounds(138, 44, 60, 60) channel("amp") range(   0,       1,       0.5,      1,      0.001)     text("Ampiezza")
</Cabbage>                                          ;min val, max val, init val, funzione, risoluzione

<CsoundSynthesizer>

<CsOptions>
-n -d -+rtmidi=NULL -M0 -m0d --midi-key-cps=4 --midi-velocity-amp=5
</CsOptions>                        ;p4                 p5

<CsInstruments>
; Initialize the global variables. 
ksmps = 10
nchnls = 2
0dbfs = 1



instr 2;strumento solo per i controlli (VEDI NELLO SCORE PER L'ACCENSIONE)

;l'opcode cabbageGetValue ci permette di leggere i valori direttamente dallo slider rotary sull'interfaccia grafica
;il canale si chiama "amp" (VEDI NELLA PARTE DI CODICE DELL?INTERFACCIA GRAFICA)
gkAmp1 cabbageGetValue "amp"

endin

;lo strumento sarà chiamato direttamente dalla tastiera virtuale midi
instr 1
;p5 e p4 sono le variabili che interfacciano la tastiera virtuale al nostro strumento
kAmp = p5 ; p5 per le ampiezze
kFreq = p4 ; p4 per le frequenze

; per controllare il valore di ampiezza di kamp = p4 (il valore che viene dalla tastiera virtuale)
; moltiplico per la variabile di controllo gkAmp1
kAmpOscili1 = kAmp * gkAmp1

aSig oscili kAmpOscili1, kFreq

iAtt = 0.1 ;tempo di attacco del suono 1/10 di secondo - 0.1 secondi
iDec = 0.1 ;tempo di decadimento del suono 1/10 di secondo - 0.1 secondi
iSus = 0.5 ;ampiezza del sostegno suono 0.5 di ampiezza
iRel = 0.3 ;tempo di rilascio del suono 3/10 di secondo - 0.3 secondi
aEnv madsr iAtt, iDec, iSus, iRel; inviluppo o rpofilo dinamico del suono

aSigEnv = aSig * aEnv; applicazione dell'inviluppo al segnale sinosuidale attraverso la moltiplicazione

outs aSigEnv, aSigEnv

endin

</CsInstruments>

<CsScore>
;causes Csound to run for about 7000 years...
f0 z

i2 0 [60*60*24*7]; strumento 2 sempre acceso per 1 settimana
</CsScore>

</CsoundSynthesizer>
