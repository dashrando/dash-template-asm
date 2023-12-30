;------------------------------------------------------------------------------
; Enemies
;------------------------------------------------------------------------------
EnemyCollisionCheck:
        LDA.w SamusCollisionPtr : CMP.w #SamusHandlerInitialFanfare : BEQ .no_collision
                                  CMP.w #SamusHandlerLocked         : BEQ .no_collision
                JSL.l ExecuteEnemyTouch
        .no_collision
RTL

pushpc
if !RECALL == 1
; Plasma Room Green Pirates
org $A1D3ED : dw $F693
org $A1D3FD : dw $F693
org $A1D40D : dw $F693
org $A1D41D : dw $F393
org $A1D42D : dw $F393
org $A1D43D : dw $F693
org $B48E42 : dw $F693
skip 2 : dw $F393
endif
pullpc
