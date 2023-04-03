; Bank 80

FrameHook:
        ; Beginning of main game loop
        JSL.l HDMAObjectHandler ; What we wrote over
RTL

PostFrameHook:
        ; End of game loop before waiting for NMI
        JSL.l WaitForNMI
RTL

NMIHook:
        ; Beginning of NMI
        LDA.w #$0000 : TCD ; What we wrote over
        LDA.w HUDHDMAPtr : BEQ .return
                PHK : PEA.w .return-1 ; Arrange stack for RTL return
                JMP.w (HUDHDMAPtr)
        .return

RTL

PostNMIHook:
        ; End of NMI
        REP #$30
        SEP #$20
        STZ.w NMIRequestFlag
        REP #$20
        JSR.w HandleTimersNMI
        INC.w NMICounter
RTL
