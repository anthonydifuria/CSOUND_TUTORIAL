<Cabbage>
form caption("Untitled") size(400, 300), guiMode("queue") pluginId("def1")
rslider bounds(296, 162, 100, 100), channel("gain"), range(10, 100, 100, 1, .01), text("Gain"), trackerColour("lime"), outlineColour(0, 0, 0, 50), textColour("black")

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


instr 1
kGain cabbageGetValue "gain"

;aSig mpulse 1,1 ;generatore di impulsi

aNoise pinker; generatore di rumore rosa

krand randomh 500,5000,1 ;generatore di numeri casuali (genera un numero casuale al secondo da 500 a 5000)
kport portk krand, 1 ;inseguitore dei numeri es. da 500 a 600 cambiamento progressivo
kosci oscili kport,0.1 ;

;printk2 kosci

aRes reson aNoise, kosci+100, 3000
aRes tone aRes, 2000

amod oscili 1,0.05
aSum = aRes * (abs(amod)+0.1)

outs aSum*0.01,aSum*0.01
endin

</CsInstruments>
<CsScore>
;causes Csound to run for about 7000 years...
f0 z
;starts instrument 1 and runs it for a week
i1 0 [60*60*24*7] 
</CsScore>
</CsoundSynthesizer>
