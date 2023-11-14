<Cabbage> bounds(0, 0, 0, 0)
form caption("GRANULATORE SINTETICO") size(800, 450), guiMode("queue") pluginId("def1") colour("40,40,40,255")

groupbox bounds(4, 6, 705, 99) channel("PARAMETRI FONDAMENTALI") text("PARAMETRI FONDAMENTALI"){
;Durata e Densità
rslider bounds(9, 25, 63, 60), channel("dur"), range(2, 1000, 200, 1, 1), text("DUR")
rslider bounds(159, 25, 63, 60), channel("den"), range(1, 100, 50, 1, 0.01), text("DEN")
rslider bounds(78, 25, 63, 60) channel("durRand") range(0, 1, 0, 1, 0.001) text("RAND DUR")
rslider bounds(227, 25, 63, 60) channel("densRand") range(0, 1, 0, 1, 0.001) text("RAND DENS")

;FREQUENZA FODAMENTALE
rslider bounds(310, 25, 74, 60), channel("ffond"), range(20, 1000, 300, 1, 0.01), text("FREQ FOND")
;SPREAD FREQUENZIALE
rslider bounds(395, 25, 78, 60), channel("spreadfreq"), range(0, 400, 0, 1, 0.01), text("SPREAD FREQ")

combobox bounds(547, 40, 109, 20) channel("func"), items("Hanning", "Bartlett (Triangle)", "Gaussian")

}

groupbox bounds(4, 110, 705, 99) channel("SERIES") text("SERIES"){
;SERIE ARMONICA
rslider bounds(10, 25, 65, 60), channel("harm"), range(1, 6, 1, 1, 1), text("ARMONICA")
rslider bounds(78, 25, 106, 60) channel("spazioFreqArm") range(0, 1, 1, 1, 0.01) text("ARM SPAZIO FREQ")

;SERIE GEOMETRICA
rslider bounds(269, 25, 65, 60) channel("num") range(1, 10, 3, 1, 1) text("NUM")
rslider bounds(337, 25, 65, 60) channel("deno") range(1, 10, 2, 1, 1) text("DEN")
rslider bounds(420, 25, 65, 60) channel("geo") range(1, 6, 1, 1, 1) text("GEOMETRICA")
rslider bounds(492, 25, 103, 60) channel("spazioFreqGeo") range(0, 1, 1, 1, 0.01) text("GEO SPAZIO FREQ")
}

groupbox bounds(6, 214, 500, 99) channel("modulazioni") text("MODULAZIONI"){

rslider bounds(10, 25, 100, 60) channel("freqModAM") range(0.1, 400, 100, 1, 0.1) text("FREQ MOD AM")
rslider bounds(200, 25, 100, 60) channel("freqDevFM") range(0, 500, 100, 1, 0.001) text("FREQ DEV FM")
rslider bounds(300, 25, 100, 60) channel("freqModFM") range(0, 500, 200, 1, 0.001) text("FREQ MOD FM")
}

groupbox bounds(6, 316, 500, 99) channel("MIXER") text("MIXER"){
;SPREAD LATERALIZZAZIONE
rslider bounds(10, 25, 82, 60), channel("spreadpan"), range(0, 1, 1, 1, 0.01), text("SPREAD PAN")

;SINE
rslider bounds(90, 25, 60, 60), channel("sine"), range(0, 0.75, 0.25, 1, 0.01), text("SINE")
;AM
rslider bounds(130, 25, 82, 60), channel("amAmp"), range(0, 0.75, 0, 1, 0.01), text("AM amp")
;FM
rslider bounds(180, 25, 82, 60), channel("fmAmp"), range(0, 0.75, 0, 1, 0.01), text("FM amp")
;GLISSATO
rslider bounds(230, 25, 80, 60), channel("gliss"), range(0, 0.75, 0, 1, 0.01), text("GLISS")

;RIVERBERAZIONE
rslider bounds(310, 25, 60, 60) channel("rev") range(0, 0.75, 0, 1, 0.001) text("REVERB")
rslider bounds(370, 25, 60, 60) channel("room") range(0, 0.999, 0, 1, 0.001) text("ROOM")

;USCITA
rslider bounds(430, 25, 60, 60), channel("out"), range(0, 1, 0.25, 1, 0.01), text("OUTPUT")
}


;xy PAD
label bounds(556, 210, 46, 16) channel("sine2") text("SINE")
label bounds(728, 210, 50, 16) channel("am") text("AM")
label bounds(732, 430, 42, 16) channel("fm") text("FM")
label bounds(545, 430, 80, 16) channel("gli") text("GLISS")
xypad bounds(564, 228, 200, 200) channel("x", "y") rangeX(0, 1, 0.5) rangeY(0, 1, 0.5)

;Accensione PAD
label bounds(510, 286, 54, 16) channel("") text("XY on")
checkbox bounds(522, 304, 30, 30) channel("onPAD")

;SECONDA VOCE
vslider bounds(718, 6, 72, 200) channel("voce") range(0, 1, 0, 1, 0.1) text("2ND VOICE")

</Cabbage>
<CsoundSynthesizer>
<CsOptions>
-n -d -+rtmidi=NULL -M0 -m0d 
</CsOptions>
<CsInstruments>
; Initialize the global variables. 
ksmps = 64
nchnls = 2
0dbfs = 1

gkrnd init 1
gkGliss init 0.25

gkX init 0.5
gkY init 0.5

gaL init 0
gaR init 0

gaAML init 0
gaAMR init 0

gaFML init 0
gaFMR init 0

gaGLISSL init 0
gaGLISSR init 0

instr 1;controlli e chiamata strumento 2

;CONTROLLI FONDAMENTALI
gkDur0 cabbageGetValue "dur"
gkDur = gkDur0 * 0.001
gkDurRand cabbageGetValue "durRand"
gkDen cabbageGetValue "den"
gkDenRand cabbageGetValue "densRand"

gkFfond cabbageGetValue "ffond"
gkSpreadFreq cabbageGetValue "spreadfreq"

;SERIES
gkHarm cabbageGetValue "harm"
gkSpazioFreqArm cabbageGetValue "spazioFreqArm"

gkNum cabbageGetValue "num"
gkDeno cabbageGetValue "deno"
gkGeo cabbageGetValue "geo"
gkSpazioFreqGeo cabbageGetValue "spazioFreqGeo"

;AM e FM
gkfreqModAM cabbageGetValue "freqModAM"
gkfreqDevFM cabbageGetValue "freqDevFM"
gkfreqModFM cabbageGetValue "freqModFM"

;USCITE
gkSpreadPan cabbageGetValue "spreadpan"

gkSINE cabbageGetValue "sine"
gkAMamp cabbageGetValue "amAmp"
gkFMamp cabbageGetValue "fmAmp"
gkGliss cabbageGetValue "gliss"

gkRoom cabbageGetValue "room"
gkRev cabbageGetValue "rev"
gkOut cabbageGetValue "out"

;PAD
kONpad cabbageGetValue "onPAD"
kX cabbageGetValue "x"
kY cabbageGetValue "y"

;VOCE
gkVoce cabbageGetValue "voce"

;ARRAY FUNZIONI
giFunc[] fillarray 3, 4, 6

;DENS RAND e DUR RAND
kDurRand random -1 * (gkDur * 0.5), (gkDur * 0.5)
gkDurSum = gkDur + (kDurRand * gkDurRand)

kDenRand randomh -gkDen * 0.5, gkDen * 0.5, 50
gkDenSum = gkDen + (kDenRand * gkDenRand)
;printk2 gkDurSum

;CHIAMATA STRUMENTO 2, 3 e 4
ktrig metro  gkDenSum;densità
schedkwhen ktrig,0,0,2,0,gkDurSum ;chiama lo strumento 2 densità gkDen e durata gkDur

;PAD
if (kONpad == 0) then

gkSine = 1
gkAM = 1
gkFM = 1
gkGLISS_PAD = 1

elseif (kONpad == 1) then

gkSine = (1 - kX) * (kY)
gkAM = (kX) * (kY)
gkFM = (kX) * (1 - kY)
gkGLISS_PAD = (1 - kX) * (1 - kY)

endif

endin



;STRUEMENTO
instr 2


;INVILUPPO
aenv poscil3 1, 1/i(gkDurSum), giFunc[cabbageGetValue:i("func")-1]

;ADDITIVA
;SERIE ARMONICA
irndHarm = (int(rnd(i(gkHarm))) * i(gkSpazioFreqArm)) + 1 

;SERIE GEOMETRICA
iRatio = i(gkNum) / i(gkDeno)
irndGeo = 1 * iRatio^(int(rnd(i(gkGeo))) * i(gkSpazioFreqGeo))

;SPREAD FREQUENZIALE
irndSpredFreq = rnd(i(gkSpreadFreq)) - (i(gkSpreadFreq) / 2)

;CALCOLO FREQUENZA
iFreq = (i(gkFfond) * irndHarm * irndGeo)  + irndSpredFreq 

;CALCOLO AMPIEZZA
iAmp0 = (i(gkDurSum) * i(gkDenSum))
if (iAmp0 >= 1) then
iAmp = iAmp0
elseif (iAmp0 < 1) then
iAmp = 1
endif

iAmpTot = (1/iAmp) / (irndHarm)


;SINE
aSig oscili iAmpTot, iFreq
aSig2 oscili iAmpTot * i(gkVoce), iFreq * 2

;MODULAZIONE AMPIEZZA
aModAmp oscili 1,i(gkfreqModAM)
aSigAM oscili iAmpTot * aModAmp, iFreq
aSigAM2 oscili iAmpTot * aModAmp * i(gkVoce), iFreq * 2


;MODUALZIONE FREQUENZA
aFreqDEV oscili i(gkfreqDevFM), i(gkfreqModFM)
aSigFM oscili iAmpTot, iFreq + aFreqDEV
aSigFM2 oscili iAmpTot * i(gkVoce), (iFreq + aFreqDEV) * 2

;GLISSATO
;CALCOLO FREQUENZA
iRndGliss = rnd(40) - 20
aGliss linseg 0, i(gkDurSum), iRndGliss
iFreqGliss = (i(gkFfond) * irndHarm * irndGeo)  + irndSpredFreq 
aSigGliss oscili iAmpTot, iFreqGliss + (aGliss * irndHarm * irndGeo)
aSig2Gliss oscili iAmpTot * i(gkVoce), iFreqGliss * 2

;SPREAD DI LATERALIZZAZIONE
irndPan = 0.5 + (((rnd(2) - 1) / 2) * i(gkSpreadPan))

;LATERALIZZAZIONE SINE
aL,aR pan2 (aSig + aSig2)  * (i(gkSine)) * aenv, irndPan

;LATERALIZZAZIONE AM
aAML,aAMR pan2 (aSigAM + aSigAM2) * (i(gkAM)) * aenv, irndPan

;LATERALIZZAZIONE FM
aFML,aFMR pan2 (aSigFM + aSigFM2)  * (i(gkFM)) * aenv, irndPan

;LATERALIZZAZIONE AM-FM
aGLISSL,aGLISSR pan2 (aSigGliss + aSig2Gliss) * (i(gkGLISS_PAD)) * aenv, irndPan



;MANDATA VERSO LO STRUMENTO 50 - SINE
gaL = aL + gaL
gaR = aR + gaR 

;MANDATA VERSO LO STRUMENTO 50 - AM
gaAML = aAML + gaAML
gaAMR = aAMR + gaAMR

;MANDATA VERSO LO STRUMENTO 50 - FM
gaFML = aFML + gaFML  
gaFMR = aFMR + gaFMR

;MANDATA VERSO LO STRUMENTO 50 - GLISS
gaGLISSL = aGLISSL + gaGLISSL
gaGLISSR = aGLISSR + gaGLISSR



endin




;USCITA e REV
instr 50


aL = gaL 
aR = gaR

aAML = gaAML 
aAMR = gaAMR

aFML = gaFML 
aFMR = gaFMR

aGLISSL = gaGLISSL 
aGLISSR = gaGLISSR 


aSumREV_L = (aL * gkSINE) + (aAML * gkAMamp) + (aFML * gkFMamp) + (aGLISSL * gkGliss)
aSumREV_R = (aR * gkSINE) + (aAMR * gkAMamp) + (aFMR * gkFMamp) + (aGLISSR * gkGliss)

aRevL, aRevR freeverb aSumREV_L, aSumREV_R, gkRoom, 0.5

aSumL = (((aL * gkSINE) + (aAML * gkAMamp) + (aFML * gkFMamp) + (aGLISSL * gkGliss)) * gkOut) + (aRevL * gkRev) 
aSumR = (((aR * gkSINE) + (aAMR * gkAMamp) + (aFMR * gkFMamp) + (aGLISSR * gkGliss)) * gkOut) + (aRevR * gkRev) 

outs aSumL, aSumR 

gaL = 0
gaR = 0

gaAML = 0
gaAMR = 0

gaFML = 0
gaFMR = 0

gaGLISSL = 0
gaGLISSR = 0

endin


</CsInstruments>
<CsScore>
;causes Csound to run for about 7000 years...
f0 z

f1 0 1024 10 1

f2 0 1025 20 1 1; Hamming
f3 0 1025 20 2 1; Hanning
f4 0 1025 20 3 1; Bartlett
f5 0 1025 20 7 1; Kaiser
f6 0 1025 20 6 1; Gaussian


;starts instrument 1 and runs it for a week
i1 0 [60*60*24*7] 

i50 0 [60*60*24*7] 

</CsScore>
</CsoundSynthesizer>
