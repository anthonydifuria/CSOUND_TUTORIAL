<Cabbage>
form caption("GENERATORE 4") size(700, 400), guiMode("queue") pluginId("def1")
rslider bounds(496, 296, 100, 100), channel("out"), range(0, 1, 0.25, 1, 0.01), text("OUTPUT"), trackerColour(0, 255, 0, 255), outlineColour(0, 0, 0, 50), textColour(0, 0, 0, 255)

rslider bounds(10, 10, 100, 100), channel("dur"), range(0.01, 1, 0.5, 1, 0.01), text("DUR"), trackerColour(0, 255, 0, 255), outlineColour(0, 0, 0, 50), textColour(0, 0, 0, 255)
rslider bounds(110, 10, 100, 100), channel("den"), range(1, 20, 1, 1, 0.01), text("DEN"), trackerColour(0, 255, 0, 255), outlineColour(0, 0, 0, 50), textColour(0, 0, 0, 255)


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



instr GUI; strumento per l'interfaccia grafica, sempre acceso (vedere nello score)

gkDur cabbageGetValue "dur";durata di ogni evento sonoro
gkDen cabbageGetValue "den";densità - eventi sonori / secondo

endin

instr 1

ktrig metro gkDen;densità - EVENTI AL SECONDO
	
schedkwhen ktrig,0,0,2,0,gkDur ;chiama / accende lo strumento 2 di durata gkDur


endin

instr 2

;poichè gli eventi sonori (sinusoidali in questo caso) che ascoltiamo hanno un taglio temporale netto sulla
;forma d'onda dobbiamo inserire un profilo dinamico (inviluppo)


aSig oscili 0.1, 440

;linseg è un OPCODE che crea un segnale che parte a 0, dopo la metà della durata dell'evento
;diventa 1 e dopo la metà della durata torna a 0
aEnv linseg 0, i(gkDur)/2, 1, i(gkDur)/2, 0;inviluppo

aSigEnv = aSig * aEnv ;applico l'inviluppo al segnale sinusoidale 

outs aSigEnv, aSigEnv

endin



</CsInstruments>

<CsScore>
;causes Csound to run for about 7000 years...
f0 z

;starts instrument 1 and runs it for a week
i "GUI" 0 [60*60*24*7] 
i1 0 [60*60*24*7] 

</CsScore>

</CsoundSynthesizer>
