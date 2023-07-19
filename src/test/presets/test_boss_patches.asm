pushpc

incsrc ../buttons.asm
incsrc ../quickmet.asm
incsrc ../loadout.asm

;%quickmet(!pre_draygon)
%quickmet(!pre_kraid)
;%quickmet(!pre_phantoon)

; Disable creating a save file
org InitGameState_save
NOP #6
JSL InitializeForTesting

org $DFFDB0
InitializeForTesting: {
        %setup_controller()

        ; Add equipment and beams
        %add_items(!MorphingBall,!Bombs,!SpaceJump,!ScrewAttack,!GravitySuit,!VariaSuit)
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

        ; Kill bosses
        LDA.l BossFlagsVanilla   : ORA.w #$0100 : STA.l BossFlagsVanilla ; Brinstar
        LDA.l BossFlagsVanilla+2 : ORA.w #$0100 : STA.l BossFlagsVanilla+2 ; Wrecked Ship
        LDA.l BossFlagsVanilla+4 : ORA.w #$0001 : STA.l BossFlagsVanilla+4 ; Maridia
        LDA.l BossFlagsVanilla+2 : ORA.w #$0001 : STA.l BossFlagsVanilla+2 ; Norfair

        ; ---- Setup bosses ----
        pushpc

        ; Disable fanfare
        org NoFanfare : dw $0001 ; Disable fanfares

        ;---- Round Trip 0 ----
        ;org DoorToKraidBoss : dw DoorVectorToPhantoonInWreckedShip
        ;org DoorToPhantoonBoss : dw DoorVectorToPhantoonInMaridia
        ;org DoorToDraygonBoss : dw DoorVectorToPhantoonInNorfair
        ;org DoorToRidleyBoss : dw DoorVectorToPhantoonInBrinstar

        ;---- Round Trip 1 ----
        ;org DoorToDraygonBoss : dw DoorVectorToKraidInBrinstar
        ;org DoorFromKraidRoom : dw DoorVectorTeleportToPreDraygon

        ;---- Round Trip 2 ----
        org DoorToKraidBoss : dw DoorVectorToKraidInWreckedShip
        org DoorToPhantoonBoss : dw DoorVectorToKraidInMaridia
        org DoorToDraygonBoss : dw DoorVectorToKraidInNorfair
        org DoorToRidleyBoss : dw DoorVectorToKraidInBrinstar

        ;---- Round Trip 3 ----
        ;org DoorToDraygonBoss : dw DoorVectorToRidley
        ;org DoorFromRidleyRoom : dw DoorVectorToPreDraygon

        ;---- Round Trip 4 ----
        ;org DoorToDraygonBoss : dw DoorVectorToRidley
        ;org DoorFromRidleyRoom : dw DoorVectorToPreRidley
        ;org DoorToRidleyBoss : dw DoorVectorToDraygon
        ;org DoorFromDraygonRoom : dw DoorVectorToPreDraygon

        ;---- Round Trip 5 ----
        ;org DoorToKraidBoss : dw DoorVectorToPhantoon
        ;org DoorFromPhantoonRoom : dw DoorVectorToPreKraid

        ;---- Round Trip 6 ----
        ;org DoorToKraidBoss : dw DoorVectorToPhantoon
        ;org DoorFromPhantoonRoom : dw DoorVectorToPrePhantoon
        ;org DoorToPhantoonBoss : dw DoorVectorToKraid
        ;org DoorFromKraidRoom : dw DoorVectorToPreKraid

        pullpc
        ; ---- End bosses ----

        RTL
}

pullpc
