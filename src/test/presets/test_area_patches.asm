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

        ;org Door_GreenHills : dw DoorVectorToPreAqueduct
        ;org Door_PreAqueduct : dw DoorVectorToRidleyMouth
        ;org Door_RidleyMouth : dw DoorVectorToSingleChamber
        ;org Door_SingleChamber : dw DoorVectorToKraidMouth
        ;org Door_ElevatorEntry : dw DoorVectorToRetroPBs
        ;org Door_RetroPBs : dw DoorVectorToAqueduct
        ;org Door_Aqueduct : dw DoorVectorToOcean
        ;org Door_Ocean : dw DoorVectorToGreenHills

        ; shows garbage in ridley mouth room
        org Door_GreenHills : dw DoorVectorToCroc
        org Door_Croc : dw DoorVectorToRidleyMouth

        ;org Door_GreenHills : dw DoorVectorToCrabs
        ;org Door_Crabs : dw DoorVectorToMainStreet
        ;org Door_MainStreet : dw DoorVectorToCrocEntry
        ;org Door_CrocEntry : dw DoorVectorToNoobBridge
        ;org Door_NoobBridge : dw DoorVectorToRedElevator
        ;org Door_RedElevator : dw DoorVectorToMaridiaTube
        ;org Door_MaridiaTube : dw DoorVectorToCroc
        ;org Door_Croc : dw DoorVectorToRidleyMouth

        ;org Door_GreenHills : dw DoorVectorTeleportToCrabs
        ;org Door_Crabs : dw DoorVectorToMaridiaTube
        ;org Door_MaridiaTube : dw DoorVectorToCrocEntry
        ;org Door_CrocEntry : dw DoorVectorToRedElevator
        ;org Door_RedElevator : dw DoorVectorToMainStreet
        ;org Door_MainStreet : dw DoorVectorToCroc
        ;org Door_Croc : dw DoorVectorTeleportToLavaDive

        ;org Door_MainStreet : dw DoorVectorTeleportToCrocEntry
        ;org Door_CrocEntry : dw DoorVectorTeleportToNoobBridge
        ;org Door_NoobBridge : dw DoorVectorTeleportToRedElevator
        ;org Door_RedElevator : dw DoorVectorTeleportToMaridiaTube
        ;org Door_MaridiaTube : dw DoorVectorTeleportToCroc
        ;org Door_Croc : dw DoorVectorTeleportToRidleyMouth

        ; pretty hard
        ;org Door_GreenHills : dw DoorVectorToMainStreet
        ;org Door_MainStreet : dw DoorVectorToG4
        ;org Door_G4 : dw DoorVectorToCroc
        ;org Door_Croc : dw DoorVectorToRidleyMouth
        ;org Door_RidleyMouth : dw DoorVectorToCrocEntry
        ;org Door_CrocEntry : dw DoorVectorToRedTower
        ;org Door_RedTower : dw DoorVectorToRedElevator
        ;org Door_RedElevator : dw DoorVectorToPreAqueduct
        ;org Door_PreAqueduct : dw DoorVectorToHighway
        ;org Door_Highway : dw DoorVectorToLavaDive
        ;org Door_LavaDive : dw DoorVectorToMaridiaEscape
        ;org Door_MaridiaEscape : dw DoorVectorToCrabs

        ;org Door_GreenHills : dw DoorVectorToOcean
        ;org Door_GreenHills : dw DoorVectorToMoat
        ;org Door_GreenHills : dw DoorVectorToCrabs

        ;org Door_GreenHills : dw DoorVectorTeleportToRedTower
        ;org Door_RedTower : dw DoorVectorTeleportToRetroPBs
        ;org Door_GreenHills : dw DoorVectorTeleportToRedTower

        pullpc
        ; ---- End portals ----
        endif

        RTL
}

pullpc
