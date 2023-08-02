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
        %add_items(!MorphingBall,!Bombs,!SpeedBooster)
        %add_beams(!ChargeBeam,!PlasmaBeam,!WaveBeam,!IceBeam,!SpazerBeam)
        %unequip_beams(!SpazerBeam)

        ; Add some ammo
        LDA.w #5
        STA.w CurrentPBs : STA.w MaxPBs
        STA.w CurrentSupers : STA.w MaxSupers
        LDA.w #10
        STA.w CurrentMissiles : STA.w MaxMissiles

        ; Make sure Zebes is awake
        LDA.l EventFlags : ORA.w #$0001 : STA.l EventFlags

        ; Place Dash items for collecting
        pushpc
        org $8F8614 : dw $F040  ; Beam Upgrade at Charge Beam
        org pctosnes($787FA) : dw $EFE8 ; Pressure Valve at Waterway
        pullpc

        RTL
}

pullpc

