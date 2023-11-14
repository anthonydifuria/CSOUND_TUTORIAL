<Cabbage>

form caption("1 SINTESI ADDITIVA") size(700, 500), guiMode("queue"), pluginId("def1") , colour(110, 110, 110)
keyboard bounds(10, 392, 682, 95)
signaldisplay bounds(322, 86, 362, 187), colour("white") displayType("waveform"), backgroundColour(0, 0, 0), zoom(0.5), signalVariable("aOut", "aOut"), channel("display")


;AMPIEZZA USCITA
rslider bounds(614, 312, 60, 60) channel("out") range(0, 1, 0.5, 1, 0.001)     text("Ampiezza")
                                                    
;CONTROLLI INVILUPPO                                               
rslider bounds(434, 10, 60, 60) channel("att") range(0.001, 1, 0.1, 1, 0.001)  text("ATT")
rslider bounds(494, 10, 60, 60) channel("dec") range(0.001, 1, 0.1, 1, 0.001)  text("DEC")
rslider bounds(554, 10, 60, 60) channel("sus") range(0, 1, 0.5, 1, 0.001)     text("SUS")
rslider bounds(624, 10, 60, 60) channel("rel") range(0.001, 1, 0.3, 1, 0.001) text("REL")

;AMPIEZZA SINUSOIDI
vslider bounds(10, 98, 50, 271) channel("a1") range(0, 1, 1, 1, 0.001) text("FOND")
vslider bounds(60, 98, 50, 271) channel("a2") range(0, 1, 1, 1, 0.001) text("2F")
vslider bounds(110, 98, 50, 271) channel("a3") range(0, 1, 1, 1, 0.001) text("3F")
vslider bounds(160, 98, 50, 271) channel("a4") range(0, 1, 1, 1, 0.001) text("4f")
vslider bounds(210, 98, 50, 271) channel("a5") range(0, 1, 1, 1, 0.001) text("5f")

;TIPI DI ONDE
button bounds(272, 314, 80, 40) channel("trigger"), text("CHANGE"), corners(5)
combobox bounds(354, 314, 199, 40) channel("onde") colour:0(147, 210, 0), corners(5), items("SERIE","SQUARE","SAW", "TRIANGLE")


</Cabbage> 


<CsoundSynthesizer>

<CsOptions>
-n -d --displays -+rtmidi=NULL -M0 --midi-key-cps=4 --midi-velocity-amp=5
</CsOptions>                        ;p4                 p5

<CsInstruments>
; Initialize the global variables. 
ksmps = 10
nchnls = 2
0dbfs = 1

gaOut init 0

instr 2

;MASTER OUT
gkOut cabbageGetValue "out"

;INVILUPPO
gkAtt cabbageGetValue "att"
gkDec cabbageGetValue "dec"
gkSus cabbageGetValue "sus"
gkRel cabbageGetValue "rel"

;AMPIEZZA SINUSOIDI
gkA1 cabbageGetValue "a1"
gkA2 cabbageGetValue "a2"
gkA3 cabbageGetValue "a3"
gkA4 cabbageGetValue "a4"
gkA5 cabbageGetValue "a5"

gkONDE cabbageGetValue "onde"

gkTrig cabbageGetValue "trigger"
kout trigger gkTrig, 0.5 ,2

if(kout > 0.5)then

event "i", 10, 0, 0.1

else
endif

endin


instr 1

;dalla tastiera virtuale
kAmp = p5
kFreq = p4 

;OSCILLATORI SINTESI ADDITIVA - SERIE ARMONICA
aSig1 oscili kAmp * gkA1, kFreq * 1 ;FONDAMENTALE 1F
aSig2 oscili kAmp * gkA2, kFreq * 2 ;ARMONICA 2F
aSig3 oscili kAmp * gkA3, kFreq * 3 ;ARMONICA 3F
aSig4 oscili kAmp * gkA4, kFreq * 4 ;ARMONICA 4F
aSig5 oscili kAmp * gkA5, kFreq * 5 ;ARMONICA 5F

aSumSignal = (aSig1 + aSig2 + aSig3 + aSig4 + aSig5) / 5; sommo i segnali e li divido per il numero dei segnali
                                                        ; per non avere saturazione del segnale

;INVILUPPO
iAtt = i(gkAtt)
iDec = i(gkDec)
iSus = i(gkSus)
iRel = i(gkRel)
aEnv madsr iAtt, iDec, iSus, iRel


;APPLICAZIONE INVILUPPO
aSigEnv = aSumSignal * aEnv

;USCITA VERSO LO STRUMENTO 50
;accumulo della variabile globale per avere un segnale costante
;altrimenti sentiremo un troncamento del segnale  - ESEMPIO TRONCAMENTO SEGNALE
gaOut = gaOut + aSigEnv 

endin


instr 50; USCITE

aSigEnv = gaOut

aOut = aSigEnv * gkOut; moltiplico per il controllo gkOut per regolare l'ampiezza

outs aOut, aOut

display	aOut, .1, 1 ;oscilloscopio, visualizzazione segnali

gaOut = 0

endin


instr 10

if( i(gkONDE) == 1 ) then

kOnda[] fillarray 1, 1, 1, 1, 1

elseif ( i(gkONDE) == 2 ) then

kOnda[] fillarray 1, 0, 1/3, 0, 1/5

elseif ( i(gkONDE) == 3 ) then

kOnda[] fillarray 1, 1/2, 1/3, 1/4, 1/5

elseif ( i(gkONDE) == 4 ) then

kOnda[] fillarray 1, 0, 1/3^2, 0, 1/5^2

endif

cabbageSetValue "a1", kOnda[0]
cabbageSetValue "a2", kOnda[1]
cabbageSetValue "a3", kOnda[2]
cabbageSetValue "a4", kOnda[3]
cabbageSetValue "a5", kOnda[4]

endin

</CsInstruments>

<CsScore>
;causes Csound to run for about 7000 years...
f0 z

i2 0 [60*60*24*7]; strumento 2 sempre acceso per 1 settimana
i50 0 [60*60*24*7]
</CsScore>

</CsoundSynthesizer>
