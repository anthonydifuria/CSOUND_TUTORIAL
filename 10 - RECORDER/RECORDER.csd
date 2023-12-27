<Cabbage>
    form caption("RECORDER") size(230, 200), colour(255,125,0) pluginId("FRec")

    checkbox bounds(10, 10, 209, 78), channel("record"), text("Record"), colour("red"), fontColour("white")

    hmeter bounds(10, 100, 211, 20) channel("left") value(0) outlineColour(0, 0, 0), overlayColour(0, 0, 0) meterColour:0(255, 0, 0) meterColour:1(255, 255, 0) meterColour:2(0, 255, 0) outlineThickness(1) 
    hmeter bounds(10, 140, 211, 20) channel("right") value(0) outlineColour(0, 0, 0), overlayColour(0, 0, 0) meterColour:0(255, 0, 0) meterColour:1(255, 255, 0) meterColour:2(0, 255, 0) outlineThickness(1) 

</Cabbage>

<CsoundSynthesizer>

    <CsOptions>
        -n -dm0
    </CsOptions>

    <CsInstruments>

        ; sr set by host
        ksmps = 64
        nchnls = 2
        0dbfs = 1

        gkFileRecorded        init    0

        instr    1
         gaL,gaR ins;FLUSSO AUDIO DA REGISTRARE
         gkrecord    cabbageGetValue    "record"
         kRecStart   trigger    gkrecord,0.5,0
         gkleft rms gaL
         gkright rms gaR

         if kRecStart == 1  then
                     event     "i",9000,0,-1 ;STRUMENTO DA CHIAMARE PER REGISTRARE
         endif
  
        endin

        instr 9000;STRUMENTO DI REGISTRAZIONE
        
         if gkrecord==0 then;SPEGNE LA REGIATRAZIONE
            cabbageSetValue "left", portk(0, .25), metro(10)
            cabbageSetValue "right", portk(0, .25), metro(10)
                     turnoff
         endif
 
         gkFileRecorded        init    1
         itim        date
         Stim        dates     itim
         itim        date
         Stim        dates     itim
         Syear       strsub    Stim, 20, 24
         Smonth      strsub    Stim, 4, 7
         Sday        strsub    Stim, 8, 10
         iday        strtod    Sday
         Shor        strsub    Stim, 11, 13
         Smin        strsub    Stim, 14, 16
         Ssec        strsub    Stim, 17, 19
         Sfilnam     sprintf   "%s_%s_%02d_%s_%s_%s.wav", Syear, Smonth, iday, Shor,Smin, Ssec
         gSname      sprintf   "FileRecorder_%s", Sfilnam

         if gkrecord == 1 then ;REGISTRAZIONE
             
            cabbageSetValue "left", portk(gkleft*10, .25), metro(10)
            cabbageSetValue "right", portk(gkright*10, .25), metro(10)
            fout gSname, 8, gaL, gaR ;REGISTRAZIONE
            
         endif
 
        endin

    </CsInstruments>  

    <CsScore>
        i 1 0 [60*60*24*7]
    </CsScore>

</CsoundSynthesizer>