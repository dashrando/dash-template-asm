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

        ; aligned doors
        ;org Door_GreenHills : dw DoorVectorToOcean
        ;org Door_Ocean : dw DoorVectorToNoobBridge
        ;org Door_NoobBridge : dw DoorVectorToRedFish
        ;org Door_RedFish : dw DoorVectorToGreenElevator
        ;org Door_GreenElevator : dw DoorVectorToTourian
        ;org Door_Tourian : dw DoorVectorToMoat
        ;org Door_Moat : dw DoorVectorToLavaDive

        ; misaligned doors
        org Door_GreenHills : dw DoorVectorToPreAqueduct
        org Door_PreAqueduct : dw DoorVectorToRidleyMouth
        org Door_RidleyMouth : dw DoorVectorToSingleChamber
        org Door_SingleChamber : dw DoorVectorToKraidMouth
        org Door_ElevatorEntry : dw DoorVectorToRetroPBs
        org Door_RetroPBs : dw DoorVectorToAqueduct
        org Door_Aqueduct : dw DoorVectorToOcean
        org Door_Ocean : dw DoorVectorToMainStreet
        org Door_MainStreet : dw DoorVectorToKraidEntry
        org Door_KraidEntry : dw DoorVectorToMaridiaTube
        org Door_MaridiaTube : dw DoorVectorToTourian
        org Door_Tourian : dw DoorVectorToKago
        org Door_Kago : dw DoorVectorToCrabs
        org Door_Crabs : dw DoorVectorToCrocEntry
        org Door_CrocEntry : dw DoorVectorToMaridiaEscape
        org Door_MaridiaEscape : dw DoorVectorToRedElevator
        org Door_RedElevator : dw DoorVectorToRedTower
        org Door_RedTower : dw DoorVectorToCroc
        org Door_Croc : dw DoorVectorToAboveKraid
        org Door_AboveKraid : dw DoorVectorToHighwayExit
        org Door_HighwayExit : dw DoorVectorToMuskateers
        org Door_Muskateers : dw DoorVectorToLavaDive
        org Door_LavaDive : dw DoorVectorToKraidsLair
        org Door_KraidsLair : dw DoorVectorToMaridiaMap
        org Door_MaridiaMap : dw DoorVectorToRedFish
        org Door_RedFish : dw DoorVectorToGreenElevator
        org Door_GreenElevator : dw DoorVectorToNoobBridge
        org Door_NoobBridge : dw DoorVectorToGreenHills

        ; shows garbage in ridley mouth room
        ;org Door_GreenHills : dw DoorVectorToCroc
        ;org Door_Croc : dw DoorVectorToRidleyMouth

        pullpc
        ; ---- End portals ----
        endif

        RTL
}

pullpc
