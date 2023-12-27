<Cabbage>
    form caption("ARRAY 2") size(400, 300), guiMode("queue"), pluginId("def1")

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

    ;instrument will be triggered by keyboard widget
    instr 1

        iArr[]   init 4

        iArr[] fillarray 1, 2, 3, 4


         index = 0
         while index < lenarray(iArr) do
          iArr2 = iArr[index]
          index += 1
          print iArr2
         od
 
        printarray iArr 
        print iArr2

    endin

    instr 2

        iArr[]   init 4

        iArr[] fillarray 1, 2, 3, 4

         index = 0
         while index < lenarray(iArr) do
          iArr2 = iArr[index]
          schedule("Play",index/2,1,iArr[index])

          index += 1
  
         od
 
        printarray iArr 
        print iArr2

    endin

    instr Play

        iTest = 0
        print iTest

    endin

    </CsInstruments>
    
    <CsScore>
        ;causes Csound to run for about 7000 years...
        f0 z
        i 1 0 360
        i 2 0 360
    </CsScore>
    
</CsoundSynthesizer>
