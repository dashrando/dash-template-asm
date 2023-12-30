pushpc

incsrc ../buttons.asm
incsrc ../quickmet.asm
incsrc ../loadout.asm

; Start in the Wrecked Ship Reserve room
%quickmet(!wrecked_ship_reserve)

; Disable creating a save file
org InitGameState_save
NOP #3
JSL InitializeForTesting

org $DFFDB0
InitializeForTesting: {
        %setup_controller()

        ; Add equipment and beams
        %add_items(!MorphingBall,!HiJumpBoots,!Bombs,!GravitySuit,!SpeedBooster)
        %add_beams(!ChargeBeam,!WaveBeam)

        ; Equip some power bombs
        lda.w #10
        sta.w CurrentPBs
        sta.w MaxPBs

        RTL
}

pullpc
