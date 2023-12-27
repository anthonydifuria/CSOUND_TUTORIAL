<Cabbage>
    form caption("GENERATORE 2") size(700, 400), guiMode("queue") pluginId("def1")
    rslider bounds(496, 296, 100, 100), channel("out"), range(0, 1, 0.25, 1, 0.01), text("OUTPUT"), trackerColour(0, 255, 0, 255), outlineColour(0, 0, 0, 50), textColour(0, 0, 0, 255)

    rslider bounds(10, 10, 100, 100), channel("dur"), range(0.01, 1, 0.5, 1, 0.01), text("DUR"), trackerColour(0, 255, 0, 255), outlineColour(0, 0, 0, 50), textColour(0, 0, 0, 255)
    rslider bounds(110, 10, 100, 100), channel("den"), range(1, 20, 1, 1, 0.01), text("DEN"), trackerColour(0, 255, 0, 255), outlineColour(0, 0, 0, 50), textColour(0, 0, 0, 255)

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

        giStrumento2 init 0; inizializzo la variabile del contatore dello strumento 2

        instr GUI; strumento per l'interfaccia grafica, sempre acceso (vedere nello score)
                    
            gkDur cabbageGetValue "dur";durata di ogni evento sonoro
            gkDen cabbageGetValue "den";densità - eventi sonori / secondo

        endin

        instr 1

            ktrig metro gkDen;densità - EVENTI AL SECONDO
            schedkwhen ktrig,0,0,2,0,gkDur ;accende lo strumento 2 - Nel dettaglio VEDERE 3_GENERATORE.csd

        endin

        instr 2

            ;stamperà il valore del contatore inizializzato a 0 
            ;e poi stamperà i valori fino all'infinito (vedi in console) 
            ; vedi contatore giStrumento2 = giStrumento2 + 1
            print giStrumento2
            ;instr 2:  giStrumento2 = 0.000
            ;instr 2:  giStrumento2 = 1.000
            ;instr 2:  giStrumento2 = 2.000
            ;instr 2:  giStrumento2 = 3.000.........

            ;Contatore da 1 fino ad infinito 
            ;aumenta di un'unità ogni volta che viene chiamato lo strumento 2
            giStrumento2 = giStrumento2 + 1

        endin

    </CsInstruments>

    <CsScore>
        ;causes Csound to run for about 7000 years...
        f0 z
        ;starts instrument 1 and runs it for a week
        i "GUI" 0 [60*60*24*7] 
        i1 0 [60*60*24*7] 
    </CsScore>

</CsoundSynthesizer>
