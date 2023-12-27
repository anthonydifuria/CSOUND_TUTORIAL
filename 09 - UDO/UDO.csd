<Cabbage>
form caption("UDO PITAGORA") size(400, 300), guiMode("queue") pluginId("def1")
rslider bounds(296, 162, 100, 100), channel("gain"), range(0, 1, 0, 1, .01), text("Gain"), trackerColour("lime"), outlineColour(0, 0, 0, 50), textColour("black")

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

    ;UDO PITAGORA
    opcode Pitagora, Sk, kki

        kin1, kin2, imode   xin           

        if imode == 0 then
          kOut = sqrt(kin1 * kin1 + kin2 * kin2) ;ipotenusa
          SOut = " Lunghezza Ipotenusa = "
        elseif imode == 1 then
            kOut = sqrt(kin1 * kin1 - kin2 * kin2) ;cateto 1 o 2
            SOut = " Lunghezza Cateto = " 
        else
          kOut = 0
          SOut = " Error - imode deve essere solo 0 o 1"
        endif

        xout SOut, kOut              

    endop

    instr 1
        
        iMode = 1;calcolo cateto da ipotenusa  
        ;l'potenusa deve essere maggiore del cateto
        kIpotenusa = 100
        kCateto = 15
        
        SOut, kOut Pitagora kIpotenusa,kCateto,iMode

        prints SOut
        printk2 kOut

    endin

    </CsInstruments>
    <CsScore>
    ;causes Csound to run for about 7000 years...
    f0 z
    ;starts instrument 1 and runs it for a week
    i1 0 [60*60*24*7] 
    </CsScore>
</CsoundSynthesizer>
