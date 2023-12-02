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
        org NoFanfare : dw $0001 ; Disable fanfares

        ;---- Round Trip 0 ----
        macro BossRoundTrip(boss)
        org DoorToKraidBoss : dw DoorVectorTo<boss>InBrinstar
        org DoorFrom<boss>InBrinstar : dw DoorVectorToPrePhantoon
        org DoorToPhantoonBoss : dw DoorVectorTo<boss>InWreckedShip
        org DoorFrom<boss>InWreckedShip : dw DoorVectorToPreDraygon
        org DoorToDraygonBoss : dw DoorVectorTo<boss>InMaridia
        org DoorFrom<boss>InMaridia : dw DoorVectorToPreRidley
        org DoorToRidleyBoss : dw DoorVectorTo<boss>InNorfair
        org DoorFrom<boss>InNorfair : dw DoorVectorToPreKraid
        endmacro

        %BossRoundTrip(Ridley)

        ; Testing Kraid in LN
        ;org DoorFromKraidInBrinstar : dw DoorVectorToPreRidley
        ;org DoorToRidleyBoss : dw DoorVectorToKraidInNorfair

        ;---- Round Trip 2 ----
        ;org DoorToKraidBoss : dw DoorVectorToKraidInWreckedShip
        ;org DoorToPhantoonBoss : dw DoorVectorToKraidInMaridia
        ;org DoorToDraygonBoss : dw DoorVectorToKraidInNorfair
        ;org DoorToRidleyBoss : dw DoorVectorToKraidInBrinstar

        ;---- Round Trip 6 ----
        ;org DoorToKraidBoss : dw DoorVectorToPhantoonInWreckedShip
        ;org DoorToPhantoonBoss : dw DoorVectorToKraidInBrinstar

        ;---- Round Trip 7 ----
        ;org DoorToKraidBoss : dw DoorVectorToDraygonInMaridia
        ;org DoorToDraygonBoss : dw DoorVectorToPhantoonInWreckedShip
        ;org DoorToPhantoonBoss : dw DoorVectorToRidleyInNorfair
        ;org DoorToRidleyBoss : dw DoorVectorToKraidInBrinstar

        pullpc
        ; ---- End bosses ----

        RTL
}

pullpc
