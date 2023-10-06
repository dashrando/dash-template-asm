; Hacks to provisionally, minimally support SpriteSomething until we have our own
; sprite injector. At which point it should be deleted our replaced with in-house sprite
; support. Do not rely on any code or data in this module until this warning is removed
; - 26/09/23

JumpAroundInjectedCode:
; In: A - PreviousMovementType
        CMP.w #$0014 : BNE .not_wall_jumping
                LDA.w #$0001 : STA.w SamusAnimationFrameSkip
                JML.l SamusHandleTurnaround_check_previous_direction
        .not_wall_jumping
JML.l SamusHandleTurnaround_not_wall_jumping

AnimationDelayTable:
dw $B56F, $B298, $B298, $B222, $B222, $B2B4, $B2B4, $B2B4, $B2B4, $B20A, $B20A, $B20A, $B20A, $B20A, $B20A, $B20A
dw $B20A, $B20A, $B20A, $B346, $B346, $B33A, $B33A, $B33E, $B33E, $B384, $B384, $B391, $B391, $B378, $B378, $B378
dw $B378, $B378, $B378, $B378, $B378, $B3BB, $B3C0, $B2A3, $B2A3, $B34A, $B34A, $B35C, $B35C, $B366, $B366, $B3C5
dw $B3CA, $B378, $B378, $B378, $B378, $B4C2, $B4C5, $B4C8, $B4D1, $B4DA, $B4DD, $B4E0, $B4E3, $B4E6, $B4EA, $B4EE
dw $B4F4, $B378, $B378, $B3CF, $B3D4, $B20A, $B20A, $B2B4, $B2B4, $B226, $B226, $B308, $B30B, $B326, $B326, $B32E
dw $B32E, $B342, $B342, $B36A, $B36A, $B30E, $B312, $B316, $B31A, $B31E, $B322, $B378, $B378, $B378, $B378, $B378
dw $B378, $B378, $B378, $B47E, $B482, $B486, $B486, $B353, $B353, $B346, $B346, $B346, $B346, $B361, $B361, $B361
dw $B361, $B2B4, $B2B4, $B2B4, $B2B4, $B226, $B226, $B226, $B226, $B378, $B378, $B378, $B378, $B378, $B378, $B378
dw $B378, $B39E, $B39E, $B491, $B491, $B222, $B222, $B3D9, $B3DE, $B2B4, $B2B4, $B3E3, $B3E8, $B3ED, $B3F2, $B3F7
dw $B3FC, $B401, $B406, $B40B, $B410, $B415, $B41A, $B41F, $B424, $B429, $B42E, $B56F, $B433, $B438, $B43D, $B442
dw $B447, $B44C, $B451, $B456, $B22D, $B231, $B235, $B23A, $B2B6, $B2B6, $B2B6, $B2B6, $B2B8, $B2B8, $B2BC, $B2BC
dw $B2C0, $B2C0, $B2C4, $B2C4, $B2B4, $B2B4, $B2B4, $B2B4, $B2B4, $B2B4, $B2B4, $B2B4, $B2B4, $B2B4, $B53C, $B45B
dw $B460, $B465, $B46A, $B46F, $B474, $B378, $B479, $B326, $B326, $B543, $B543, $B543, $B543, $B543, $B543, $B2B4
dw $B2B4, $B2B4, $B2B4, $B545, $B556, $B2AE, $B2AE, $B567, $B567, $B2AE, $B2AE, $B4FA, $B504, $B50E, $B513, $B378
dw $B23F, $B243, $B247, $B24B, $B24F, $B253, $B22D, $B231, $B257, $B268, $B288, $B290, $B2B4, $B2B4, $B2B4, $B2B4
dw $B53C, $B518, $B51B, $B51E, $B521, $B524, $B527, $B52A, $B52D, $B530, $B533, $B536, $B539

MovementJumpTable:
; EDITOR'S NOTE: Ridiculous
dw $804D ; 0: Standing
dw $8066 ; 1: Running
dw $806E ; 2: Normal jumping
dw $8076 ; 3: Spin jumping
dw $807E ; 4: Morph ball - on ground
dw $8087 ; 5: Crouching
dw $80B6 ; 6: Falling
dw $8086 ; 7: Unused
dw $810A ; 8: Morph ball - falling
dw $8112 ; 9: Unused
dw $8113 ; Ah: Knockback / crystal flash ending
dw $812D ; Bh: Unused
dw $8132 ; Ch: Unused
dw $813A ; Dh: Unused
dw TurnAroundOnGround ; Eh: Turning around - on ground
dw $8112 ; Fh: Crouching/standing/morphing/unmorphing transition
dw $8147 ; 10h: Moonwalking
dw $814F ; 11h: Spring ball - on ground
dw $8157 ; 12h: Spring ball - in air
dw $815F ; 13h: Spring ball - falling
dw $8167 ; 14h: Wall jumping
dw $816F ; 15h: Ran into a wall
dw $8181 ; 16h: Grappling
dw $8189 ; 17h: Turning around - jumping
dw $818D ; 18h: Turning around - falling
dw $8191 ; 19h: Damage boost
dw $8199 ; 1Ah: Grabbed by Draygon
dw $81A1 ; 1Bh: Shinespark / crystal flash / drained by metroid / damaged by MB's attacks

LookupAnimationDelay:
        CLC
        ADC.l AnimationDelayTable,X
RTL

WallJumpCheck:
        .initial
        LDA.w SamusAnimationFrame : CMP.w #$001B : BMI .spinning
                JMP.w $9DDD
        .spinning
        JMP.w $9D6B

        .collision
        LDA.w #$0001 : STA.w SamusAnimationTimer
        LDA.w #$001A : STA.w SamusAnimationFrame
        JMP.w $9D77

AdvanceScrewAttackWallAnimation:
        LDA.w SamusAnimationFrame
        CLC : ADC.w #$0015
        STA.w SamusAnimationFrame
        TAY
        SEC
RTS

pushpc
org $91FC42
MovementHandler:
        PHP : PHB
        PHK : PLB
        REP #$30
        LDA.w SamusMovementType : AND.w #$00FF
        ASL : TAX
        LDA.l MovementJumpTable,X
        STA.b $0C
        LDX.w #$0000
        JSR.w ($000C,X)
        PLB : PLP
RTL

TurnAroundOnGround:
        JSR.w $81A9
RTS
warnpc $91FC66

org $91EC9D
WallJumpCheckPaletteFix:
        LDA.w SamusAnimationFrame : BEQ +
                CMP.w #$001B : BPL ++
                        JMP.w $DA1B
        +
        JMP.w $D9EA
        ++
        JMP.w $DA48
warnpc $91ECD0

org $90847E : JMP.w AdvanceScrewAttackWallAnimation
org $909D60 : JMP.w WallJumpCheck_initial
org $909DCE : JMP.w WallJumpCheck_collision
org $90E913 : JSL.l MovementHandler
org $90E921 : JSL.l MovementHandler
org $90E93D : JSL.l MovementHandler
org $9082F0 : LDA.l AnimationDelayTable,X

org $91D9FF : JMP.w WallJumpCheckPaletteFix
org $91F62F : JML.l JumpAroundInjectedCode
org $91FB7A : JSL.l LookupAnimationDelay
pullpc
