<Cabbage>
    form caption("FM INDICE DI MODULAZIONE") size(400, 300), guiMode("queue") pluginId("def1")
    rslider bounds(296, 162, 100, 100), channel("gain"), range(0, 1, 0, 1, .01), text("Gain"), trackerColour("lime"), outlineColour(0, 0, 0, 50), textColour("black")

    rslider bounds(20, 34, 100, 100), channel("FreqMod"), range(0, 500, 0, 1, 0.01), text("Freq MOD"), trackerColour(0, 255, 0, 255), outlineColour(0, 0, 0, 50), textColour(0, 0, 0, 255)
    rslider bounds(130, 36, 100, 100), channel("Index"), range(0, 10, 0, 1, 0.01), text("Index Mod"), trackerColour(0, 255, 0, 255), outlineColour(0, 0, 0, 50), textColour(0, 0, 0, 255)
    rslider bounds(262, 38, 100, 100), channel("FreqCar"), range(50, 4000, 500, 1, 0.01), text("Freq CAR"), trackerColour(0, 255, 0, 255), outlineColour(0, 0, 0, 50), textColour(0, 0, 0, 255)

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

            kVol cabbageGetValue "gain"

            kFreqMod cabbageGetValue "FreqMod"
            kModIndex cabbageGetValue "Index"
            kFreqCar cabbageGetValue "FreqCar"

            kFreqDev = kFreqMod * kModIndex

            aDevFreq oscili kFreqDev, kFreqMod

            aFM oscili 1, aDevFreq + kFreqCar

            outs aFM * kVol, aFM * kVol

        endin

    </CsInstruments>
    
    <CsScore>
        ;causes Csound to run for about 7000 years...
        f0 z
        ;starts instrument 1 and runs it for a week
        i1 0 [60*60*24*7] 
    </CsScore>
    
</CsoundSynthesizer>
