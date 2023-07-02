pushpc

incsrc ../buttons.asm
incsrc ../quickmet.asm
incsrc ../loadout.asm

; Start in Sand Falls
%quickmet(!sandfalls)

; Disable creating a save file
org InitGameState_save
NOP #6
JSL InitializeForTesting

org $DFFDB0
InitializeForTesting: {
        %setup_controller()

        ; Add equipment and beams
        %add_items(!MorphingBall,!Bombs,!SpaceJump,!ScrewAttack,!GravitySuit)
        %add_beams(!PlasmaBeam,!WaveBeam,!IceBeam,!SpazerBeam)
        %unequip_beams(!SpazerBeam)

        ; Add some ammo
        LDA.w #10
        STA.w CurrentPBs : STA.w MaxPBs
        STA.w CurrentSupers : STA.w MaxSupers
        LDA.w #40
        STA.w CurrentMissiles : STA.w MaxMissiles

        ; Make sure Zebes is awake
        LDA.l EventFlags : ORA.w #$0001 : STA.l EventFlags

        ; Place Dash items for collecting
        ;pushpc
        ;org $8F860E : dw $EFEC  ; Beam Upgrade at Charge Missiles
        ;org $8F8608 : dw $EFEC  ; Beam Upgrade at Big Pink Missiles
        ;org $8F8614 : dw $F040  ; Beam Upgrade at Charge Beam
        ;pullpc

        RTL
}

pullpc
