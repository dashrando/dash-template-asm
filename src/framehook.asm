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
        LDX.w $4210 ; What we wrote over
RTS

PostNMIHook:
; End of NMI
        JSR.w HUDPaletteNMITransfer
        REP #$30
        LDA.w NMIAux : BEQ +
                PHK : PEA .return-1 ; Setup RTL return
                JMP.w [NMIAux]
                .return
                STZ.w NMIAux
        +
        JSR.w HandleTimersNMI
        INC.w NMICounter
RTL
