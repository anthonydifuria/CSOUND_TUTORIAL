<Cabbage>
form caption("GENERATORE AM") size(700, 400), guiMode("queue") pluginId("def1")
    rslider bounds(496, 296, 100, 100), channel("out"), range(0, 1, 0.25, 1, 0.01), text("OUTPUT"), trackerColour(0, 255, 0, 255), outlineColour(0, 0, 0, 50), textColour(0, 0, 0, 255)

    rslider bounds(10, 10, 100, 100), channel("dur"), range(0.01, 1, 0.01, 1, 0.01), text("DUR"), trackerColour(0, 255, 0, 255), outlineColour(0, 0, 0, 50), textColour(0, 0, 0, 255)
    rslider bounds(110, 10, 100, 100), channel("den"), range(1, 100, 1, 1, 0.01), text("DEN"), trackerColour(0, 255, 0, 255), outlineColour(0, 0, 0, 50), textColour(0, 0, 0, 255)
    rslider bounds(220, 10, 100, 100), channel("ffond"), range(20, 1000, 300, 1, 0.01), text("FREQ FOND"), trackerColour(0, 255, 0, 255), outlineColour(0, 0, 0, 50), textColour(0, 0, 0, 255)
    rslider bounds(330, 10, 100, 100), channel("spreadfreq"), range(0, 400, 0, 1, 0.01), text("SPREAD FREQ"), trackerColour(0, 255, 0, 255), outlineColour(0, 0, 0, 50), textColour(0, 0, 0, 255)
    rslider bounds(440, 10, 100, 100), channel("harm"), range(1, 10, 1, 1, 0.01), text("ARMONICHE"), trackerColour(0, 255, 0, 255), outlineColour(0, 0, 0, 50), textColour(0, 0, 0, 255)
    rslider bounds(550, 10, 100, 100), channel("spreadpan"), range(0, 1, 0, 1, 0.01), text("SPREAD PAN"), trackerColour(0, 255, 0, 255), outlineColour(0, 0, 0, 50), textColour(0, 0, 0, 255)

    rslider bounds(440, 110, 100, 100), channel("amAmp"), range(0, 1, 1, 1, 0.01), text("AM amp"), trackerColour(0, 255, 0, 255), outlineColour(0, 0, 0, 50), textColour(0, 0, 0, 255)
    rslider bounds(550, 110, 100, 100), channel("amFreq"), range(1, 500, 0, 1, 0.01), text("AM freq"), trackerColour(0, 255, 0, 255), outlineColour(0, 0, 0, 50), textColour(0, 0, 0, 255)

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
            gkDur cabbageGetValue "dur"
            gkDen cabbageGetValue "den"
            gkFfond cabbageGetValue "ffond"
            gkSpreadFreq cabbageGetValue "spreadfreq"
            gkHarm cabbageGetValue "harm"
            gkSpreadPan cabbageGetValue "spreadpan"

            gkAMamp cabbageGetValue "amAmp"
            gkAMfreq cabbageGetValue "amFreq"

            gkOut cabbageGetValue "out"

            ;chiamata struemento 2
            ktrig metro  gkDen;densità
					
            schedkwhen ktrig,0,0,2,0,gkDur ;chiama lo strumento 2 densità gkDen e durata gkDur	

        endin


        instr 2

            ;inviluppo gaussiano
            aenv poscil3 1, 1/i(gkDur), 2 

            ;Armoniche
            irndHarm = int(rnd(i(gkHarm)))+1 

            ;spred frequenzale
            irndSpredFreq = rnd(i(gkSpreadFreq)) - (i(gkSpreadFreq) / 2)

            ;SEGNALE MODULANTE
            aMod oscili gkAMamp, gkAMfreq

            ;SEGNALE PORTANTE
            aSig oscili (1/i(gkDen))*(i(gkDen)/2), (i(gkFfond) * irndHarm)  + irndSpredFreq 

            ;modulazione RM + portante
            aAM = (aSig * aMod) + aSig

            ; spread di lateralizzazione
            irndPan = 0.5 + (((rnd(2) - 1) / 2) * i(gkSpreadPan))

            ; lateralizzazione
            aL,aR pan2 aAM * aenv, irndPan

            ; uscita verso lo strumento 50
            gaL = aL + gaL
            gaR = aR + gaR

        endin

        instr 50
    
            aL = gaL * gkOut
            aR = gaR * gkOut

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
