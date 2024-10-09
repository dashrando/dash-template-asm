pushpc

incsrc ../buttons.asm
incsrc ../quickmet.asm
incsrc ../loadout.asm

; Start in Big Pink next to Charge Missiles
%quickmet(!big_pink_bottom)

; Disable creating a save file
org InitGameState_save
NOP #3
JSL InitializeForTesting

org $DFFDB0
InitializeForTesting: {
        %setup_controller()

        ; Add equipment and beams
        %add_items(!MorphingBall,!Bombs,!HiJumpBoots,!SpeedBooster)
        %add_beams(!ChargeBeam,!PlasmaBeam,!WaveBeam,!IceBeam,!SpazerBeam)
        %add_dash_items(!DoubleJump,!PressureValve)
        %unequip_beams(!SpazerBeam)

        ; Add some ammo
        LDA.w #5
        STA.w CurrentPBs : STA.w MaxPBs
        STA.w CurrentSupers : STA.w MaxSupers
        LDA.w #10
        STA.w CurrentMissiles : STA.w MaxMissiles

        ; Make sure Zebes is awake
        LDA.l EventFlags : ORA.w #$0001 : STA.l EventFlags

        ; Place Heat Reduction items
        pushpc
        org $8F860E : dw $EF0B  ; Gravity at Charge Missiles
        org $8F8608 : dw $EFE4  ; Heat Shield at Big Pink Missiles
        org $8F8614 : dw $EF07+$54  ; Varia at Charge Beam

        org NoFanfare : dw $0001 ; Disable fanfares
        pullpc

        RTL
}

pullpc

