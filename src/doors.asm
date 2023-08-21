;------------------------------------------------------------------------------
; Doors
;------------------------------------------------------------------------------
PreOpenG4:
        LDA.l BossFlagsVanilla+$01 : AND.w #$0101 : CMP.w #$0101 : BNE +
        LDA.l BossFlagsVanilla+$03 : AND.w #$0101 : CMP.w #$0101 : BNE +
        LDA.l EventFlags
        ORA.w #$0400
        STA.l EventFlags
+
RTS

WakeUpZebes: 
    LDA.l ItemBitArray+$02 : BIT.w #$0400 : BEQ .exit ; TODO: Fresh file save marker
    LDA.l EventFlags : ORA.w #$0001 : STA.l EventFlags
.exit
RTS

pushpc
;------------------------------------------------------------------------------
; Door ASM Pointers
;------------------------------------------------------------------------------
org $838EB4 ; Into Construction Zone
dw WakeUpZebes

org $838C5C ; G4 Elevator
dw PreOpenG4

;------------------------------------------------------------------------------
; Connect West Sand Hall to Below Botwoon Energy Tank
;------------------------------------------------------------------------------

if !AREA == 1
    org $83A63C                 ; West Sand Hall left door 
    dw $D6FD                    ; Connect to Below Botwoon Energy Tank
    db $00,$05,$3E,$06,$03,$00
	dw $8000,$0000
endif

pullpc

;------------------------------------------------------------------------------
; Logic to position Samus using misaligned door transitions
;------------------------------------------------------------------------------

TeleportSamus:
        ; Jump to the end if nothing to do
        LDA.w DoorMisaligned : BEQ .done

        ; Jump to iframes code if doors are ok
        PHA : BIT.w #$4000 : BEQ .iframes

        ; Reset position in the room
        PHX
        AND.w #$0FFF : TAX
        LDA.l DoorDirectionTable+6,X
        STA.w SamusXPos
        LDA.l DoorDirectionTable+8,X
        STA.w SamusYPos
        PLX

        ; Cancel movement
        STZ.w SamusYSubSpeed : STZ.w SamusYSpeed
        STZ.w SamusXRunSpeed : STZ.w SamusXRunSubSpeed
        STZ.w SamusXMomentum : STZ.w SamusXSubMomentum
        STZ.w SamusDoorSpeed : STZ.w SamusDoorSubSpeed

        ; Force Samus to elevator pose
        STZ $0A1C : STZ $0A1E
        STZ $0A20 : STZ $0A22
        STZ $0A24 : STZ $0A26

        ; Set pose transition values to FFFF
        LDA.w #$FFFF
        STA $0A2A : STA $0A2C : STA $0A2E

        ; Reset animation timer
        STZ.w SamusAnimationFrame

        ; Shinesparking? TODO: clear out remaining frames
        LDA.w SamusContactDamageIndex : CMP #$0002 : BNE +
            LDA #$CACA
            STA.w $0741
        +

        ; Clear contact damage index (screw attack, pseudo screw, speedboosting, etc.)
        STZ.w SamusContactDamageIndex

        .iframes:
        PLA : BIT.w #$8000 : BEQ .cleanup
            if !AREA == 1
                LDA.w #$0080
                STA.w InvincibilityTimer
            else
                NOP #6
            endif

        .cleanup:
        STZ.w DoorMisaligned
        
        ; TODO: Remove this? Added when we were always blacking out the screen
        ;STZ.w CREBitset

        .done:
        ; Clear this flag to avoid graphics issues when leaving Crocomire
        STZ.w RequestEnemyBG2Tilemap

        ; We over wrote to call this routine
        PLB : PLP
RTL

RefillAll:
        LDA.w MaxHealth
        STA.w CurrentHealth
        LDA.w MaxReserves
        STA.w CurrentReserves
        LDA.w MaxMissiles
        STA.w CurrentMissiles
        LDA.w MaxSupers
        STA.w CurrentSupers
        LDA.w MaxPBs
        STA.w CurrentPBs
RTS

if !AREA == 1
        pushpc
        org DoorVectorToTourianElevator
        skip 10 : dw RefillAll
        pullpc
endif

pushpc

;------------------------------------------------------------------------------
; Always reload CRE when leaving boss rooms
;------------------------------------------------------------------------------
org RoomHeaderPreKraid
skip 8 : db $02

org RoomHeaderPrePhantoon
skip 8 : db $02

org RoomHeaderPreDraygon
skip 8 : db $02

org RoomHeaderPreRidley
skip 8 : db $02

;------------------------------------------------------------------------------
; Create door vectors for entering a room from an unexpected direction
;------------------------------------------------------------------------------
org $83AD70

;---

macro VariaSuitVectors(area)
DoorVectorToVariaSuitIn<area>:
dw RoomHeaderVariaSuitIn<area> : %CopyRange($8391DA+2,$8391E6)
DoorVectorToKraidFromVariaSuitIn<area>:
dw RoomHeaderKraidIn<area>     : %CopyRange($839252+2,$83925E)
endmacro

%VariaSuitVectors(Norfair)
%VariaSuitVectors(WreckedShip)
%VariaSuitVectors(Maridia)

;---

macro KraidVector(area)
DoorVectorToKraidIn<area>:
dw RoomHeaderKraidIn<area> : db $40,$04,$01,$16,$00,$01 : dw $8000,$0000
endmacro

%KraidVector(WreckedShip)
%KraidVector(Maridia)
%KraidVector(Norfair)

;---

macro PhantoonVector(area)
DoorVectorToPhantoonIn<area>:
dw RoomHeaderPhantoonIn<area> : db $40,$04,$01,$06,$00,$00 : dw $8000,$0000
endmacro

%PhantoonVector(Brinstar)
%PhantoonVector(Maridia)
%PhantoonVector(Norfair)

;---

macro SpaceJumpVectors(area)
DoorVectorToSpaceJumpIn<area>:
dw RoomHeaderSpaceJumpIn<area> : %CopyRange($83A978+2,$83A984) ; verify (ok)
DoorVectorToDraygonFromSpaceJumpIn<area>:
dw RoomHeaderDraygonIn<area>   : %CopyRange($83A924+2,$83A930) ; verify (ok)
endmacro

%SpaceJumpVectors(Brinstar)
%SpaceJumpVectors(WreckedShip)
%SpaceJumpVectors(Norfair)

;---

macro DraygonVector(area)
DoorVectorToDraygonIn<area>:
dw RoomHeaderDraygonIn<area> : db $40,$05,$1E,$06,$01,$00 : dw $8000,$0000
endmacro

%DraygonVector(Brinstar)
%DraygonVector(WreckedShip)
%DraygonVector(Norfair)

;---

macro RidleyTankVectors(area)
DoorVectorToRidleyTankIn<area>:
dw RoomHeaderRidleyTankIn<area> : %CopyRange($8398B2+2,$8398BE) ; verify
DoorVectorToRidleyFromTankIn<area>:
dw RoomHeaderRidleyIn<area>     : %CopyRange($839A62+2,$839A6E) ; verify
endmacro

%RidleyTankVectors(Brinstar)
%RidleyTankVectors(WreckedShip)
%RidleyTankVectors(Maridia)

;---

macro RidleyVector(area,cre_bitset)
DoorVectorToRidleyIn<area>:
dw RoomHeaderRidleyIn<area> : db $40,$05,$0E,$06,$00,<cre_bitset> : dw $8000,$0000
endmacro

%RidleyVector(Brinstar,$01)
%RidleyVector(WreckedShip,$01)
%RidleyVector(Maridia,$00)

;--------------------------------------------------------------------
; Door Alignment Table
;    types: 0001 right-to-left
;           0002 left-to-right
;           0003+ unique (don't try to align)
;--------------------------------------------------------------------
DoorDirectionTable:

; Left / Right Doors
dw Door_GreenHills,DoorVectorToRetroPBs,$0001,$0034,$0288
dw Door_RetroPBs,DoorVectorToGreenHills,$0002,$01C7,$0088
dw Door_Moat,DoorVectorToOcean,$0001,$0034,$0488
dw Door_Ocean,DoorVectorToMoat,$0002,$01CF,$0088
dw Door_G4,DoorVectorToTourian,$0001,$0034,$0088
dw Door_Tourian,DoorVectorToG4,$0002,$00CC,$0688
dw Door_GreenElevator,DoorVectorToKago,$0001,$0036,$0088
dw Door_Kago,DoorVectorToGreenElevator,$0002,$00CC,$0088
dw Door_Highway,DoorVectorToHighwayExit,$0001,$0034,$0188
dw Door_HighwayExit,DoorVectorToHighway,$0002,$00D1,$0088
dw Door_NoobBridge,DoorVectorToRedTower,$0001,$002F,$0488
dw Door_RedTower,DoorVectorToNoobBridge,$0002,$05CE,$0088
dw Door_MaridiaEscape,DoorVectorToRedFish,$0001,$0034,$0088
dw Door_RedFish,DoorVectorToMaridiaEscape,$0002,$02CD,$0388
dw Door_KraidEntry,DoorVectorToElevatorEntry,$0001,$0034,$0088
dw Door_ElevatorEntry,DoorVectorToKraidEntry,$0002,$00CE,$0188
dw Door_AboveKraid,DoorVectorToMaridiaMap,$0001,$0028,$0188
dw Door_MaridiaMap,DoorVectorToAboveKraid,$0002,$03C6,$0088
dw Door_KraidMouth,DoorVectorToKraidsLair,$0001,$0034,$0088
dw Door_KraidsLair,DoorVectorToKraidMouth,$0002,$02C7,$0098
dw Door_SingleChamber,DoorVectorToMuskateers,$0001,$0134,$0088
dw Door_Muskateers,DoorVectorToSingleChamber,$0002,$05CF,$0088
dw Door_RidleyMouth,DoorVectorToLavaDive,$0001,$0134,$0288
dw Door_LavaDive,DoorVectorToRidleyMouth,$0002,$03D0,$0088
dw Door_PreAqueduct,DoorVectorToAqueduct,$0001,$0034,$0188
dw Door_Aqueduct,DoorVectorToPreAqueduct,$0002,$01CA,$0388

; Up / Down Doors
dw Door_Crabs,DoorVectorToRedElevator,$0003,$0080,$0058
dw Door_RedElevator,DoorVectorToCrabs,$0004,$014C,$02B8
dw Door_MaridiaTube,DoorVectorToMainStreet,$0005,$014A,$07A8
dw Door_MainStreet,DoorVectorToMaridiaTube,$0006,$0081,$0078
dw Door_CrocEntry,DoorVectorToCroc,$0007,$0383,$0098
dw Door_Croc,DoorVectorToCrocEntry,$0008,$0C57,$02B8

; Boss Entry Doors (keep vanilla pairings first)
dw DoorToKraidBoss,DoorVectorToKraidInBrinstar,$0001,$0034,$0188
dw DoorToKraidBoss,DoorVectorToPhantoonInBrinstar,$0001,$002E,$00B8
dw DoorToKraidBoss,DoorVectorToDraygonInBrinstar,$0002,$01C8,$0088
dw DoorToKraidBoss,DoorVectorToRidleyInBrinstar,$0009,$00BF,$0198

dw DoorToPhantoonBoss,DoorVectorToPhantoonInWreckedShip,$0001,$002E,$00B8
dw DoorToPhantoonBoss,DoorVectorToKraidInWreckedShip,$0001,$0034,$0188
dw DoorToPhantoonBoss,DoorVectorToDraygonInWreckedShip,$0002,$01C8,$0088
dw DoorToPhantoonBoss,DoorVectorToRidleyInWreckedShip,$000A,$00BF,$0198

dw DoorToDraygonBoss,DoorVectorToDraygonInMaridia,$0002,$01C8,$0088
dw DoorToDraygonBoss,DoorVectorToKraidInMaridia,$0001,$0034,$0188
dw DoorToDraygonBoss,DoorVectorToPhantoonInMaridia,$0001,$002E,$00B8
dw DoorToDraygonBoss,DoorVectorToRidleyInMaridia,$0002,$00BF,$0198

dw DoorToRidleyBoss,DoorVectorToRidleyInNorfair,$0002,$00BF,$0198
dw DoorToRidleyBoss,DoorVectorToKraidInNorfair,$0001,$0034,$0188
dw DoorToRidleyBoss,DoorVectorToPhantoonInNorfair,$0001,$002E,$00B8
dw DoorToRidleyBoss,DoorVectorToDraygonInNorfair,$0002,$01C8,$0088

; Boss Exit Doors (keep vanilla pairings first)
dw DoorFromKraidInBrinstar,DoorVectorToPreKraid,$0002,$01CD,$0188
dw DoorFromPhantoonInBrinstar,DoorVectorToPreKraid,$0002,$01CD,$0188
dw DoorFromDraygonInBrinstar,DoorVectorToPreKraid,$0001,$01CD,$0188
dw DoorFromRidleyInBrinstar,DoorVectorToPreKraid,$0001,$01CD,$0188

dw DoorFromPhantoonInWreckedShip,DoorVectorToPrePhantoon,$0002,$049F,$00B8
dw DoorFromKraidInWreckedShip,DoorVectorToPrePhantoon,$0002,$049F,$00B8
dw DoorFromDraygonInWreckedShip,DoorVectorToPrePhantoon,$0001,$049F,$00B8
dw DoorFromRidleyInWreckedShip,DoorVectorToPrePhantoon,$0001,$049F,$00B8

dw DoorFromDraygonInMaridia,DoorVectorToPreDraygon,$0001,$0034,$0288
dw DoorFromKraidInMaridia,DoorVectorToPreDraygon,$0002,$0034,$0288
dw DoorFromPhantoonInMaridia,DoorVectorToPreDraygon,$0002,$0034,$0288
dw DoorFromRidleyInMaridia,DoorVectorToPreDraygon,$0001,$0034,$0288

dw DoorFromRidleyInNorfair,DoorVectorToPreRidley,$0001,$002E,$0098
dw DoorFromKraidInNorfair,DoorVectorToPreRidley,$0002,$002E,$0098
dw DoorFromPhantoonInNorfair,DoorVectorToPreRidley,$0002,$002E,$0098
dw DoorFromDraygonInNorfair,DoorVectorToPreRidley,$0001,$002E,$0098

; End
dw $0000

pullpc