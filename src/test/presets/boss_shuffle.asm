pushpc

incsrc ../buttons.asm
incsrc ../quickmet.asm
incsrc ../loadout.asm

;%quickmet(!pre_draygon)
%quickmet(!pre_kraid)
;%quickmet(!pre_phantoon)

; Disable creating a save file
org InitGameState_save
NOP #3
JSL InitializeForTesting

org $DFFDB0
InitializeForTesting: {
        %setup_controller()

        ; Add equipment and beams
        %add_items(!MorphingBall,!Bombs,!SpaceJump,!ScrewAttack,!GravitySuit,!VariaSuit,!XrayScope)
        %add_beams(!PlasmaBeam,!WaveBeam,!IceBeam,!SpazerBeam,!ChargeBeam)
        %unequip_beams(!SpazerBeam)

        ; Add some ammo
        LDA.w #80
        STA.w CurrentPBs : STA.w MaxPBs
        STA.w CurrentSupers : STA.w MaxSupers
        LDA.w #100
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
        org NoFanfare : dw $0001

        ;---- Round Trip 0 ----
        org DoorToKraidBoss : dw DoorVectorToDraygonInMaridia
        org DoorFromDraygonInMaridia : dw DoorVectorToPrePhantoon
        org DoorToPhantoonBoss : dw DoorVectorToRidleyInNorfair
        org DoorFromRidleyInNorfair : dw DoorVectorToPreDraygon
        org DoorToDraygonBoss : dw DoorVectorToKraidInBrinstar
        org DoorFromKraidInBrinstar : dw DoorVectorToPreRidley
        org DoorToRidleyBoss : dw DoorVectorToPhantoonInWreckedShip
        org DoorFromPhantoonInWreckedShip : dw DoorVectorToPreKraid

        ;---- Round Trip 1 ----
        ;org DoorToKraidBoss : dw DoorVectorToRidleyInNorfair
        ;TODO: add the other bosses

        pullpc
        ; ---- End bosses ----

        RTL
}

pullpc
