<Cabbage>
form caption("VOCODER") size(400, 300), guiMode("queue"), pluginId("def1")
keyboard bounds(8, 158, 381, 95)
rslider bounds(102, 75, 60, 60) channel("master") range(0, 1, 0.5, 1, 0.001) text("master")
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

opcode VOCODER_MCADAMS, a, aakkkkkii
    aSigCar, aSigMod, kFreq, kBand, kFollow,kA_mcadams, kK_mcadams, iPartials, icnt  xin     
                                 
         icnt  =  icnt + 1 
            
         ;McAdams - F = Fo * n^a + k       
         kFreqMcAdams = kFreq * icnt^ kA_mcadams + kK_mcadams;FREQUENZA CENTRALE con McAdams   
         
                                                                     
         aSigModOut butbp aSigMod, kFreqMcAdams, kBand;MODULANTE
              
         aEnv follow2 aSigModOut , kFollow , kFollow;ENV FOLLOWER MODULANTE
            
         aSigCarOut butbp aSigCar, kFreqMcAdams, kBand;PORTANTE
         
         aOut = aSigCarOut * aEnv ;MODULAZIONE                  
 
         amix init 0                                        
 
         if icnt < iPartials then 
             
             ;chiamerà tante volte se stesso fino alla quantità di parziali
             ;vuol dire che avremo iPartials filtri in parallelo contemporaneamente
             ;un banco di filtri                      
             amix VOCODER_MCADAMS aSigCar, aSigMod, kFreq, kBand, kFollow,kA_mcadams, kK_mcadams, iPartials, icnt
             
              
         endif                                                   
                                                  
     xout amix + aOut
     
endop

instr 2
gkmaster cabbageGetValue "master"
endin

instr 1

    aMod diskin2 "PAROLAI.WAV", 1, 0, 1;SEGNALE MODULANTE
    ;aMod inch 1

    kFreq = p4 *2; frequenza attraverso keybord
    kBand = 5; larghezza di banda  - filtro passa-banda
    iPartials = 20; numero di filtri i(gkPartias)
    kA_mcadams = 1; a di mcadams
    kK_mcadams = 0;k di mcandams
    
    icnt init 0; inizializzaione counter per il calcolo del banco di filtri
        
    kFollow = 0.01;Attacco e decadimento env follower del vocoder
   
    aCar vco2 p5, p4;PORTANTE
    ;aCar inch 2 
                                               
    aOut VOCODER_MCADAMS aCar ,aMod, kFreq, kBand, kFollow,kA_mcadams, kK_mcadams, iPartials, icnt
    
    aEnv madsr 0.01, 0.01,0.5, 0.1;inviluppo del suono risultante

    kResizeAmp = 200 / kBand ;ricalcolo ampiezza proporzionale rispetto alla larghezza di banda del filtro

    aL,aR pan2 (aEnv * aOut) * kResizeAmp, rnd(1);lateralizzazione L-R


    gaL = aL + gaL
    gaR = aR + gaR

  
endin

instr 50

 aL = gaL
 aR = gaR

 outs aL * gkmaster,aR * gkmaster 
 
 gaL = 0
 gaR = 0

endin



</CsInstruments>
<CsScore>
;causes Csound to run for about 7000 years...
f0 z
i 2 0 [60*60*24*7]
i 50 0 [60*60*24*7]

</CsScore>
</CsoundSynthesizer>
