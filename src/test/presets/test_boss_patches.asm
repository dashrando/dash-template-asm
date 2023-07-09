pushpc

incsrc ../buttons.asm
incsrc ../quickmet.asm
incsrc ../loadout.asm

; Start in Sand Falls
;%quickmet(!pre_draygon)
%quickmet(!pre_kraid)

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
        LDA.l BossFlagsVanilla   : ORA.w #$0100 : STA.l BossFlagsVanilla ; Kraid
        LDA.l BossFlagsVanilla+2 : ORA.w #$0100 : STA.l BossFlagsVanilla+2 ; Phantoon
        LDA.l BossFlagsVanilla+4 : ORA.w #$0001 : STA.l BossFlagsVanilla+4 ; Draygon
        LDA.l BossFlagsVanilla+2 : ORA.w #$0001 : STA.l BossFlagsVanilla+2 ; Ridley

        if !AREA == 1
        ; ---- Setup portals ----
        pushpc

        ; n00b bridge to Retro PBs
        ;org $838F0A : dw $9E9F,$0400,$2601,$0200,$8000,$0000
        ; Retro PBs to n00b bridge
        ;org $838E9E : dw $9FBA,$0500,$065E,$0005,$8000,$0000

        ; Green Hills to Red Tower
        ;org $838E86 : dw $A253,$0400,$4601,$0400,$8000,$0000
        ; Red Tower to Green Hills
        ;org $83902A : dw $9E52,$0500,$061E,$0001,$8000,$0000

        pullpc
        ; ---- End portals ----

        ; ---- Setup bosses ----
        pushpc

        ;---- Round Trip 1 ----
        org DoorToDraygonBoss : dw DoorVectorTeleportToKraid
        org DoorToKraidBoss : dw DoorVectorTeleportToRidley
        org DoorToRidleyBoss : dw DoorVectorTeleportToPhantoon
        org DoorToPhantoonBoss : dw DoorVectorTeleportToDraygon

        ;---- Round Trip 2 ----

        ;org DoorFromDraygonRoom : dw DoorVectorTeleportToPreKraid
        ;org DoorFromKraidRoom : dw DoorVectorTeleportToPreRidley
        ;org DoorFromRidleyRoom : dw DoorVectorTeleportToPrePhantoon
        ;org DoorFromPhantoonRoom : dw DoorVectorTeleportToPreDraygon

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
        endif
        ; ---- End bosses ----

        RTL
}

pullpc
