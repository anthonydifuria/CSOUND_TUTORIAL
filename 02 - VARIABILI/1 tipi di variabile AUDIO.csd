<Cabbage>

    form caption("Untitled") size(400, 300), guiMode("queue") pluginId("def1")
    rslider bounds(296, 162, 100, 100), channel("gain"), range(0, 1, 0, 1, .01), text("Gain"), trackerColour("lime"), outlineColour(0, 0, 0, 50), textColour("black")       

</Cabbage>

<CsoundSynthesizer>

    <CsOptions>
     -n -d -+rtmidi=NULL -M0 -m0d 
    </CsOptions>

    <CsInstruments>
        ; Initialize the global variables. 
        ksmps = 10
        nchnls = 2
        0dbfs = 1

        instr 1


            aSignal oscili 0.1, 400
            ;la variabile di tipo "a" è una variabile audio, vuol dire che è in relazione alla frequenza di campionamento
            ;la utilizzeremo per tutti i flussi audio (es. per ascoltare una sinusoide, per ascoltare l'audio che catturiamo dall'esterno, quando abbiamo bisogno di un controllo più dettagliato)
            ;ricordiamoci che la frequenza di campionamneto (audio) è il numero campioni disponibili nell'unità di tempo, ed è il massimo di risoluzione audio che possiamo avere in un sistema

            outs aSignal, aSignal;ascoltiamo il segnale audio composto da una sinusoide di ampiezza = 0.1 e frequenza = 400hz

        endin

    </CsInstruments>
    
    <CsScore>
        ;causes Csound to run for about 7000 years...
        f0 z
        ;starts instrument 1 and runs it for a week
        i1 0 [60*60*24*7] 
    </CsScore>

</CsoundSynthesizer>
