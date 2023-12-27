<Cabbage>
form caption("GENERATORE 3") size(700, 400), guiMode("queue") pluginId("def1")
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
                
            ;l'OPCODE schedkwhen ha il compito di accendere lo strumento numero 2 e
            ;lo mantiene acceso per la durata gkDur in secondi - quindi se gkDur = 1, lo strumento
            ;numero 2 resterà acceso per 1 secondo, se gkDur = 0.5 resterà acceso per mezzo secondo o 500 millisecondi
            schedkwhen ktrig,0,0,2,0,gkDur 
            ;ktrig -> densità - quante volte deve accendere lo strumento 2 ogni secondo
            ;0,0 -> per adesso non li teniamo in considerazione
            ;,2 -> strumento da accendere
            ;,gkDur -> quanto tempo deve rimanere acceso

        endin

        ;i valori iniziali di Durata e Densità sono i seguenti
        ;gkDen = 1
        ;dkDur = 0.5
        ;quindi lo strumento numero 2 si accenderà 1 volta al secondo e durerà 500millisecondi o 0.5 secondi
        instr 2

            ;di seguito un esempio con un oscillatore
            aSig oscili 0.1, 440
            outs aSig, aSig

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
