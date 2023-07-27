pushpc

incsrc ../buttons.asm
incsrc ../quickmet.asm
incsrc ../loadout.asm

; Start in Big Pink
%quickmet(!green_hills)

; Disable creating a save file
org InitGameState_save
NOP #6
JSL InitializeForTesting

org $DFFDB0
InitializeForTesting: {
        %setup_controller()

        ; Add equipment and beams
        %add_items(!MorphingBall,!Bombs,!SpaceJump,!ScrewAttack,!GravitySuit,!VariaSuit,!SpeedBooster)
        %add_beams(!PlasmaBeam,!WaveBeam,!IceBeam,!SpazerBeam,!ChargeBeam)
        %unequip_beams(!SpazerBeam)

        ; Add some ammo
        LDA.w #10 : STA.w CurrentPBs : STA.w CurrentSupers
        LDA.w #20 : STA.w MaxPBs : STA.w MaxSupers
        LDA.w #40 : STA.w CurrentMissiles
        LDA.w #60 : STA.w MaxMissiles

        LDA.w #20 : STA.w CurrentHealth

        ; Make sure Zebes is awake
        LDA.l EventFlags : ORA.w #$0001 : STA.l EventFlags

        ; Kill bosses
        LDA.l BossFlagsVanilla   : ORA.w #$0100 : STA.l BossFlagsVanilla ; Kraid
        LDA.l BossFlagsVanilla+2 : ORA.w #$0100 : STA.l BossFlagsVanilla+2 ; Phantoon
        LDA.l BossFlagsVanilla+4 : ORA.w #$0001 : STA.l BossFlagsVanilla+4 ; Draygon
        LDA.l BossFlagsVanilla+2 : ORA.w #$0001 : STA.l BossFlagsVanilla+2 ; Ridley

        LDA.l BossFlagsVanilla+2 : ORA.w #$0002 : STA.l BossFlagsVanilla+2 ; Crocomire

        if !AREA == 1
        ; ---- Setup portals ----
        pushpc

        macro Setup(door,vector)
        org Door_<door> : dw DoorVectorTo<vector>
        endmacro

        %Setup(GreenHills,Tourian)

        pullpc
        ; ---- End portals ----
        endif

        RTL
}

pullpc
