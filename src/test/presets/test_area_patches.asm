pushpc

incsrc ../buttons.asm
incsrc ../quickmet.asm
incsrc ../loadout.asm

; Start in Big Pink
%quickmet(!green_hills)

; Disable creating a save file
org InitGameState_save
NOP #3
JSL InitializeForTesting

org $DFFDB0
InitializeForTesting: {
        %setup_controller()

        ; Add equipment and beams
        %add_items(!MorphingBall,!Bombs,!SpaceJump,!ScrewAttack,!GravitySuit,!VariaSuit,!SpeedBooster)
        %add_beams(!PlasmaBeam,!WaveBeam,!IceBeam,!SpazerBeam,!ChargeBeam)
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

        ;LDA.l BossFlagsVanilla+2 : ORA.w #$0002 : STA.l BossFlagsVanilla+2 ; Crocomire

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

        macro Setup(door,vector)
        org Door_<door> : dw DoorVectorTo<vector>
        endmacro

        ; misaligned doors
        %Setup(GreenHills,MainStreet)

        %Setup(MainStreet,PreAqueduct)
        %Setup(PreAqueduct,RidleyMouth)
        %Setup(RidleyMouth,SingleChamber)
        %Setup(SingleChamber,KraidMouth)
        %Setup(KraidMouth,G4)
        %Setup(G4,Moat)
        %Setup(Moat,GreenElevator)
        %Setup(GreenElevator,Highway)
        %Setup(Highway,NoobBridge)
        %Setup(NoobBridge,MaridiaEscape)
        %Setup(MaridiaEscape,KraidEntry)
        %Setup(KraidEntry,AboveKraid)

        %Setup(AboveKraid,Croc)

        %Setup(Croc,RetroPBs)
        %Setup(RetroPBs,Aqueduct)
        %Setup(Aqueduct,Ocean)
        %Setup(Ocean,ElevatorEntry)
        %Setup(ElevatorEntry,HighwayExit)
        %Setup(HighwayExit,LavaDive)
        %Setup(LavaDive,Muskateers)
        %Setup(Muskateers,Tourian)
        %Setup(Tourian,Kago)
        %Setup(Kago,RedFish)
        %Setup(RedFish,MaridiaMap)
        %Setup(MaridiaMap,KraidsLair)
        %Setup(KraidsLair,RedTower)

        %Setup(RedTower,RedElevator)
        %Setup(RedElevator,MaridiaTube)
        %Setup(MaridiaTube,CrocEntry)
        %Setup(CrocEntry,Crabs)
        %Setup(Crabs,GreenHills)

        ; shows garbage in ridley mouth room
        ;org Door_GreenHills : dw DoorVectorToCroc
        ;org Door_Croc : dw DoorVectorToRidleyMouth

        ; test contact state between doors (screw attack, pseudo, etc.)
        ;%Setup(GreenHills,Croc)
        ;%Setup(Croc,RetroPBs)

        pullpc
        ; ---- End portals ----
        endif

        RTL
}

pullpc
