<Cabbage>
form caption("VOCODER") size(400, 300), guiMode("queue"), pluginId("def1")
keyboard bounds(8, 158, 381, 95)
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

seed 0

gaL init 0
gaR init 0

opcode BankFilt, a, aakkkii
    aSigCar, aSigMod, kFreq, kBand, kFollow, iPartials, icnt  xin     
                                 
         icnt  =  icnt + 1 
              
         kFreqOut = kFreq * icnt;CENTRO BANDA   
                                                                     
         aSigModOut butbp aSigMod, kFreqOut, kBand;MODULANTE
              
         aEnv follow2 aSigModOut , kFollow , kFollow;ENV FOLLOWER
            
         aSigCarOut butbp aSigCar, kFreqOut, kBand;PORTANTE
         
         aOut = aSigCarOut * aEnv;MODULAZIONE                   
 
         amix init 0                                        
 
         if icnt < iPartials then 
                                   
             amix BankFilt aSigCar, aSigMod, kFreq, kBand, kFollow, iPartials, icnt
              
         endif                                                   
                                                  
     xout amix + aOut
     
endop


instr 1

    aMod diskin2 "PAROLAI.WAV", 1, 0, 1

    kFreq = p4 *4
    kBandW = 100
    iPartials = 20
    icnt init 0
        
    kFollow = 0.3;Attacco e decadimento env follower
   
    aCar vco2 p5, p4;PORTANTE
                          
    aOut BankFilt aCar ,aMod, kFreq, kBandW, kFollow, iPartials, icnt
    
    aEnv madsr 0.01, 0.01,0.5, 2

    kResizeAmp = 20000 / kBandW

    aL,aR pan2 (aEnv * aOut) * kResizeAmp, rnd(1)

    gaL = aL + gaL
    gaR = aR + gaR

  
endin

instr 50


aL = gaL
aR = gaR

 outs aL,aR 
 
 gaL = 0
 gaR = 0

endin



</CsInstruments>
<CsScore>
;causes Csound to run for about 7000 years...
f0 z
i 50 0 [60*60*24*7]

</CsScore>
</CsoundSynthesizer>
