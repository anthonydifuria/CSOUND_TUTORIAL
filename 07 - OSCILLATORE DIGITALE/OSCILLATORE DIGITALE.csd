<Cabbage>

    form caption("ADDITIVA ARRAY 1") size(400, 300), guiMode("queue") pluginId("def1")
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

            giTableSize = 2 * 44100 //LUNGHEZZA BUFFER SCRITTURA
            giTableCopy ftgen   0, 0, -giTableSize, 2, 0

            iSR = sr//FREQUENZA DI CAMPIONAMENTO

            iFN = iSR / giTableSize;//FREQUENZA NATURALE 

            iFX = 300;//FREQUENZA DA CALCOLARE
            giIncr = iFX / iFN; //INCREMENTO

            iPiGreco = 4 * taninv(1) ;calcolo PiGreco

            ;inizializzazione Tabella
            giTable[] init giTableSize

            ;SCRITTURA TABELLA
            index = 0;indice array
            while index < giTableSize do;ciclo

                giTable[index] = sin(2 * iPiGreco * index / giTableSize) //SCRITTURA SU TABELLA
                index += 1  
        
            od
 
            copya2ftab giTable, giTableCopy;Copia l'array in una tabella ftgen
 
            andx phasor giIncr * iFN; frequenza 
            aIncr = int(andx * giTableSize) ;incremento

            ares tab aIncr, giTableCopy,0 ;lettura tabella

            outs ares * 0.5, ares * 0.5;uscita


        endin

    </CsInstruments>
    
    <CsScore>
        ;causes Csound to run for about 7000 years...
        f0 z
        ;f1 0 4096 10 1 ;SINE
        ;starts instrument 1 and runs it for a week
        i1 0 [60*60*24*7] 
    </CsScore>
    
</CsoundSynthesizer>
