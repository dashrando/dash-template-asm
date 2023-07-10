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

        ;org Door_GreenHills : dw DoorVectorToOcean
        ;org Door_Ocean : dw DoorVectorToNoobBridge
        ;org Door_NoobBridge : dw DoorVectorToRedFish
        ;org Door_RedFish : dw DoorVectorToGreenElevator
        ;org Door_GreenElevator : dw DoorVectorToTourian
        ;org Door_Tourian : dw DoorVectorToMoat
        ;org Door_Moat : dw DoorVectorToLavaDive

        ;org Door_GreenHills : dw DoorVectorTeleportToCrocEntry
        ;org Door_GreenHills : dw DoorVectorTeleportToMoat
        org Door_GreenHills : dw DoorVectorTeleportToPreAqueduct
        org Door_PreAqueduct : dw DoorVectorTeleportToRidleyMouth
        org Door_RidleyMouth : dw DoorVectorTeleportToSingleChamber
        org Door_SingleChamber : dw DoorVectorTeleportToKraidMouth
        org Door_ElevatorEntry : dw DoorVectorTeleportToRetroPBs
        org Door_RetroPBs : dw DoorVectorTeleportToAqueduct
        org Door_Aqueduct : dw DoorVectorTeleportToOcean
        org Door_Ocean : dw DoorVectorToGreenHills

        pullpc
        ; ---- End portals ----
        endif

        RTL
}

pullpc
