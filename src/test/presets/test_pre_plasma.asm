pushpc

incsrc ../buttons.asm
incsrc ../quickmet.asm
incsrc ../loadout.asm

; Start in the Pre-Plasma room
%quickmet(!pre_plasma)

; Disable creating a save file
org InitGameState_save
NOP #3
JSL InitializeForTesting

org $DFFDB0
InitializeForTesting: {
        %setup_controller()

        ; Add equipment and beams
        %add_items(!MorphingBall,!HiJumpBoots,!Bombs,!GravitySuit,!ScrewAttack)
        %add_beams(!ChargeBeam,!WaveBeam,!PlasmaBeam,!SpazerBeam,!IceBeam)
        %unequip_beams(!ChargeBeam,!WaveBeam,!PlasmaBeam,!SpazerBeam,!IceBeam)

        ; Equip some power bombs
        lda.w #10
        sta CurrentPBs
        sta MaxPBs

        RTL
}

pullpc
