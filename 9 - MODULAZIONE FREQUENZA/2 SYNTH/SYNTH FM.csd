<Cabbage>
form caption("SYNTH FM") size(700, 500), guiMode("queue") pluginId("def1")
keyboard bounds(6, 392, 687, 95)


vslider bounds(75, 88, 50, 150) channel("a1")  range(0, 1, 1, 1, 0.001)
vslider bounds(128, 88, 50, 150) channel("a2") range(0, 1, 0.5, 1, 0.001)
vslider bounds(182, 88, 50, 150) channel("a3") range(0, 1, 0.25, 1, 0.001)
vslider bounds(234, 88, 50, 150) channel("a4") range(0, 1, 0.125, 1, 0.001)
vslider bounds(286, 88, 50, 150) channel("a5") range(0, 1, 0.06125, 1, 0.001)


rslider bounds(342, 96, 125, 101) channel("fs") range(-1000, 1000, 0, 1, 0.1) text("Fshift")
rslider bounds(468, 96, 123, 101) channel("ps") range(0.1, 5, 1, 1, 0.1) text("Pshift")

rslider bounds(342, 196, 125, 101) channel("FMdevMod") range(0, 200, 0, 1, 0.1) text("FM dev mod")
rslider bounds(468, 196, 123, 101) channel("FMfreqMod") range(0, 400, 0, 1, 0.1) text("FM freq mod")

rslider bounds(10, 290, 80, 80) channel("att") range(0, 1, 0.01, 1, 0.01) text("Att")
rslider bounds(90, 290, 80, 80) channel("dec") range(0, 1, 0.01, 1, 0.01) text("Dec")
rslider bounds(180, 290, 80, 80) channel("sus") range(0, 1, 0.5, 1, 0.01) text("Sus")
rslider bounds(270, 290, 80, 80) channel("rel") range(0, 1, 0.1, 1, 0.01) text("Rel")

</Cabbage>
<CsoundSynthesizer>
<CsOptions>
-n -d -+rtmidi=NULL -M0 -m0d --midi-key-cps=4 --midi-velocity-amp=5
</CsOptions>
<CsInstruments>
; Initialize the global variables. 
ksmps = 32
nchnls = 2
0dbfs = 1

;UDO - opcode del synth additivo
opcode SynthAddFM, aaaaa, akkkkkkkkk

     aFM, ka1, ka2, ka3, ka4, ka5, kvelocity, kFreq, kFreqShift, kPitchShift  xin           
  
aSig1 oscili ka1 * kvelocity, (((kFreq * 1) * kPitchShift) + kFreqShift) + aFM   ;FONDAMENTALE
aSig2 oscili ka2 * kvelocity, (((kFreq * 2) * kPitchShift) + kFreqShift) + aFM
aSig3 oscili ka3 * kvelocity, (((kFreq * 3) * kPitchShift) + kFreqShift) + aFM
aSig4 oscili ka4 * kvelocity, (((kFreq * 4) * kPitchShift) + kFreqShift) + aFM
aSig5 oscili ka5 * kvelocity, (((kFreq * 5) * kPitchShift) + kFreqShift) + aFM
  
        xout aSig1, aSig2, aSig3, aSig4, aSig5              
endop


instr 2 

gkamp1 cabbageGetValue "a1"
gkamp2 cabbageGetValue "a2"
gkamp3 cabbageGetValue "a3"
gkamp4 cabbageGetValue "a4"
gkamp5 cabbageGetValue "a5"

gkFreqShift cabbageGetValue "fs"
gkPitchShift cabbageGetValue "ps"

gkFMdevMod cabbageGetValue "FMdevMod"
gkFMfreqMod cabbageGetValue "FMfreqMod"

gkAtt cabbageGetValue "att"
gkDec cabbageGetValue "dec"
gkSus cabbageGetValue "sus"
gkRel cabbageGetValue "rel"

endin


instr 1

aEnv madsr i(gkAtt), i(gkDec), i(gkSus), i(gkRel)

kFreqShift = gkFreqShift
kPitchShift = gkPitchShift

aFM oscili gkFMdevMod, gkFMfreqMod

a1,a2,a3,a4,a5 SynthAddFM aFM, gkamp1,gkamp2,gkamp3,gkamp4,gkamp5, p5, p4 , gkFreqShift, gkPitchShift

aSumFM = ((a1+a2+a3+a4+a5) / 5 ) * aEnv


outs aSumFM, aSumFM

endin



</CsInstruments>
<CsScore>
;causes Csound to run for about 7000 years...
f0 z
;starts instrument 1 and runs it for a week
i2 0 [60*60*24*7] 
</CsScore>
</CsoundSynthesizer>
