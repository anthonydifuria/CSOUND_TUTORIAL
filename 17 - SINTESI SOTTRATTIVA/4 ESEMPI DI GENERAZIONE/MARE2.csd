<Cabbage>
form caption("MARE 2") size(700, 400), guiMode("queue") pluginId("def1")
rslider bounds(496, 296, 100, 100), channel("out"), range(0, 1, 0.25, 1, 0.01), text("OUTPUT"), trackerColour(0, 255, 0, 255), outlineColour(0, 0, 0, 50), textColour(0, 0, 0, 255)

rslider bounds(10, 10, 100, 100), channel("dur"),range(2, 4000, 2000, 1, 1), text("DUR"), trackerColour(0, 255, 0, 255), outlineColour(0, 0, 0, 50), textColour(0, 0, 0, 255)
rslider bounds(110, 10, 100, 100), channel("den"), range(1, 50, 5, 1, 0.01), text("DEN"), trackerColour(0, 255, 0, 255), outlineColour(0, 0, 0, 50), textColour(0, 0, 0, 255)
rslider bounds(10, 150, 100, 100), channel("LP"), range(0, 1, 1, 1, 0.01), text("LP"), trackerColour(0, 255, 0, 255), outlineColour(0, 0, 0, 50), textColour(0, 0, 0, 255)
rslider bounds(110, 150, 100, 100), channel("HP"), range(0, 1, 0, 1, 0.01), text("HP"), trackerColour(0, 255, 0, 255), outlineColour(0, 0, 0, 50), textColour(0, 0, 0, 255)
rslider bounds(210, 150, 100, 100), channel("BP"), range(0, 1, 0, 1, 0.01), text("BP"), trackerColour(0, 255, 0, 255), outlineColour(0, 0, 0, 50), textColour(0, 0, 0, 255)
rslider bounds(310, 150, 100, 100), channel("BPrand"), range(0, 1, 0, 1, 0.01), text("BPrand"), trackerColour(0, 255, 0, 255), outlineColour(0, 0, 0, 50), textColour(0, 0, 0, 255)

rslider bounds(550, 10, 100, 100), channel("spreadpan"), range(0, 1, 1, 1, 0.01), text("SPREAD PAN"), trackerColour(0, 255, 0, 255), outlineColour(0, 0, 0, 50), textColour(0, 0, 0, 255)


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

gkrnd init 1
gaL init 0
gaR init 0

instr 1

;controlli
gkDur0 cabbageGetValue "dur"
gkDur = gkDur0 * 0.001
gkDen cabbageGetValue "den"


gkLP cabbageGetValue "LP"
gkHP cabbageGetValue "HP"
gkBP cabbageGetValue "BP"
gkBPrand cabbageGetValue "BPrand"

gkSpreadPan cabbageGetValue "spreadpan"
gkOut cabbageGetValue "out"

;chiamata struemento 2
ktrig metro  gkDen;densità
					
schedkwhen ktrig,0,0,2,0,gkDur ;chiama lo strumento 2 densità gkDen e durata gkDur	


endin



instr 2

;inviluppo gaussiano
;aenv poscil3 1, 1/i(gkDur), 2 
iPerc = rnd(0.9)+0.1
iTime1 = i(gkDur) * iPerc
iTime2 = i(gkDur) * (1 - iPerc)
iType1 = rnd(2)+0.1
iType2 = rnd(2)+0.1
aenv transeg 0,iTime1,iType1,1,iTime2,iType2,0

;CALCOLO AMPIEZZA
iAmp0 = (i(gkDur) * i(gkDen))
if (iAmp0 >= 1) then
iAmp = iAmp0
elseif (iAmp0 < 1) then
iAmp = 1
endif


aNoise pinker;generatore di rumore rosa

;lowpass
kFreqLP linseg 0, i(gkDur) / 2, rnd(1000), i(gkDur) / 2, 0
iampRndLP = rnd(1)
aSigLP tone iampRndLP * aNoise * 1/iAmp,  100 + kFreqLP

;hipass
kFreqHP linseg 0, i(gkDur) / 2, 10000 - rnd(7000), i(gkDur) / 2, 0
kAmpHP linseg 0, i(gkDur) / 2, rnd(1), i(gkDur) / 2, 0
iampRandHP =  rnd(1)
aSigHP atone kAmpHP * iampRandHP * aNoise * 1/iAmp,  100 + kFreqHP

;bandpass
iampBP = rnd(1)
ifreqBP = 200 + rnd(1000)
ibandBP = 500 + rnd(200)
kFreqBP linseg 0, i(gkDur) / 2, rnd(10), i(gkDur) / 2, 0
aSigBP butterbp aNoise * iampBP * 1/iAmp, ifreqBP + kFreqBP, ibandBP

;bandpass rand
krndBPrand randomh 1000 + rnd(200), 2100 + rnd(200), 100
ibandBPrand = 1000 + rnd(500)
aSigBandRand butterbp aNoise * iampBP * 1/iAmp, krndBPrand, ibandBPrand


; spread di lateralizzazione
irndPan = 0.5 + (((rnd(2) - 1) / 2) * i(gkSpreadPan))
;lateralizzazione
aL,aR pan2 ( aSigLP * gkLP + aSigHP * gkHP  + aSigBP * gkBP + aSigBandRand * gkBPrand) * aenv, irndPan

;mandata strumento 50
gaL = aL + gaL
gaR = aR + gaR

endin

instr 50

print 1

aL = gaL * gkOut
aR = gaR * gkOut

aM = (aL + aR) / 2

outs aL,aR

gaL = 0
gaR = 0

endin

</CsInstruments>
<CsScore>
;causes Csound to run for about 7000 years...
f0 z

f1 0 1024 10 1


f2 0 1025 20 2							; A Gauss bell envelope
f3 0 1025  7 0 128 1 768 1 120 0 8 0		; A trapezoid envelope
f4 0 1025  16 0 24 2 1  1000 -5 0	; An Exp envelope  
f5 0 1025  7 0 16 1 256 0.5 256 0.15 220 0 20 0 ; A dual decay envelope
f6 0 1025 19 2 1 270 1
f7 0 1024 7 0.000000 121 0.0515 170 0.1515 134 0.269 90 0.415 77 0.587 77 0.787 84 0.966 29 0.993 38 1.0 31 0.948 36 0.793 19 0.6 27 0.369 29 0.184 36 0.057 27 0.0

;starts instrument 1 and runs it for a week
i1 0 [60*60*24*7] 

i50 0 [60*60*24*7] 
</CsScore>
</CsoundSynthesizer>
