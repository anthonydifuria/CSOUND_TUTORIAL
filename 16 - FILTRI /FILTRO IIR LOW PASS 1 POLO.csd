<Cabbage>
    form caption("IIR LOWPASS") size(400, 300), guiMode("queue") pluginId("def1")
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

        instr 1
        
        setksmps 1
        
            aYn init 0
            aNoise gauss 1

            iTWOPI = 8. * taninv(1.)

            iST = 1.0/sr
            iCutOff = 100
            iOmega = iTWOPI * iST * iCutOff

            iA = cos(iOmega) - 2 + sqrt((2 - cos(iOmega))^2 - 1);LOWPASS
            iB = 1.0 + iA

            print iA
            print iB

            ;y[n] = b0x[n] − a1y[n − 1]

            aXn = (aNoise * iB) 
            aYn delay1 aXn - (aYn * iA)
            
            aOut = aYn

            outs aOut,aOut

        endin


        </CsInstruments>

        <CsScore>
            ;causes Csound to run for about 7000 years...
            f0 z
            ;starts instrument 1 and runs it for a week
            i1 0 [60*60*24*7] 
        </CsScore>
    
</CsoundSynthesizer>
