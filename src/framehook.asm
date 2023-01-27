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
RTL

PostNMIHook:
        ; End of NMI
        JSR.w HandleTimersNMI
        REP #$30 : INC.w NMICounter
RTL
