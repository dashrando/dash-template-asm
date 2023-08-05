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
; Door Edits
;------------------------------------------------------------------------------
if !RECALL == 1
    org $8FC571 ; Plasma Spark
    dw NoopPLM : dw $0000, $0000 ; Plasma door blue

    org $8FC773 ; Halfie Shaft
    skip $26 : dw NoopPLM : dw $0000, $0000 ; Plasma door blue

    org $8FC611 ; Back door to Draygon
    dw $0000    ; Make door blue
    ;dw NoopPLM : dw $0000, $0000 ; Crashes! but why?
    
    org $8F823E ; Forgotten Highway before elevator
    dw $0000    ; Make door blue
    
    org $8FCE9C         ; WS Save room header Phantoon alive
    skip $14 : dw $C2C9 ; Turn on save station
    
    org $8FCC39         ; WS E-tank room header Phantoon alive
    skip $14 : dw $C337 ; Show WS E-tank item

    org $8FCBE7         ; WS back room Phantoon alive
    skip $14 : dw $C323 ; Add missile door back
    
    org $8F8B4E         ; Norfair above Croc 8b96
    skip $48 : dw $0000 ; Make upper Croc door blue

    org $8F8B9E ; Croc room
    dw NoopPLM : dw $0000, $0000 ; Make top door blue

endif

if !AREA == 1
    org $8FCE9C         ; WS Save room header Phantoon alive
    skip $14 : dw $C2C9 ; Turn on save station

    org $8FCBE7         ; WS back room Phantoon alive
    skip $14 : dw $C323 ; Add missile door back

    org $83A63C                 ; West Sand Hall left door 
    dw $D6FD                    ; Connect to Below Botwoon Energy Tank
    db $00,$05,$3E,$06,$03,$00
	dw $8000,$0000
endif

org $8F84EC ; Green Brin pre-map
dw $0000    ; Unlock grey door

pullpc

;------------------------------------------------------------------------------
; Lock doors for area
;------------------------------------------------------------------------------

WestSandHall_GreyDoor_PLM:
dw $C842,$060E,$1000,$0000

SandFalls_GreyDoor_PLM:
dw $C842,$063E,$1000,$0000

if !AREA == 1
    pushpc
    org $8FD273
    dw WestSandHall_GreyDoor_PLM

    org $8FD71E
    dw SandFalls_GreyDoor_PLM
    pullpc
endif

;------------------------------------------------------------------------------
; Flashing doors for area
; Grey Door Facing Left  : $C842
; Grey Door Facing Right : $C848
; Grey Door Facing Up    : $C84E
; Grey Door Facing Down  : $C854
;------------------------------------------------------------------------------

if !AREA == 1
    pushpc

    ; n00b bridge portal - Room $9FBA
    org $8F87A6 : dw $C842,$065E,$9C33
    ;org $A19325 : db $00

    ; Green Hills portal - Room $9E52
    org $8F8670 : dw $C842,$061E,$9C30
    ;org $A19D5B : db $00

    ; Retro PBs portal - Room $9E9F
    org $8F874B : db $9C
    ;org $A193A8 : db $00

    ; Croc Entry portal - Room $A923
    org $8F8B4E         ; Norfair above Croc 8b96
    skip $48 : dw $0000 ; Make upper Croc door blue

    ; Croc Exit portal - Room $A98D
    org $8F8B9E ; Croc room
    dw NoopPLM : dw $0000, $0000 ; Make top door blue
 
    ; G4 portal - Room $99BD
    org $8F844C
    skip 36 : dw $C842 : skip 2 : dw $9C1E
    ;org $A18572 : db $00

    ; Crabs - Room $948C
    org $8F81FE 
    skip 42 : dw $C84E : skip 2 : dw $9C0E
    ;org $A18F7B : db $00

    ; Red Elevator - Room $962A
    org $8F8250
    skip 6 : dw $C854 : skip 2 : dw $9C10
    ;org $8F825D : db $00

    ; Highway (Maridia) - Room $95A8
    org $8F823E
    skip 0 : dw $C842 : db $0E : db $06 : dw $9C0F ; Adjusted PLM coords

    ; Lava Dive - Room $AE74
    org $8F8D1E
    skip 48 : dw $C848 : skip 2 : dw $9C58
    ;org $A1B9D7 : db $00

    ; PreAqueduct - Room $D1A3
    org $8FC4EF
    skip 12 : dw $C842 : skip 2 : dw $9C8F
    ;org $A1D005 : db $00

    ; Back door WS - Room $CAF6
    org $8FC247
    skip 42 : dw NoopPLM : dw $0000, $0000

    ; Main Street - Room $CFC9
    org $8FCFD6
    skip 20 : dw CustomPLMs_MainStreet
    ;org $A1DF2F : db $00

    ; Ridley Mouth - Room $AF14
    org $8FAF21
    skip 20 : dw CustomPLMs_RidleyMouth
    ;org $A1AD6B : db $00

    pullpc
endif

;------------------------------------------------------------------------------
; Custom PLM lists ($AD-$CF are good values)
;------------------------------------------------------------------------------

CustomPLMs_MainStreet:
%CopyBytes($8FC42B,24)           ; copy existing list
dw $C84E : db $16,$7D : dw $9CAD ; flashing door cap
dw $0000

CustomPLMs_RidleyMouth:
%CopyBytes($8F8D7E,0)            ; copy existing list (none)
dw $C842 : db $3E,$06 : dw $9CAE ; flashing door cap
dw $0000

;------------------------------------------------------------------------------
; Logic to position Samus using misaligned door transitions
;------------------------------------------------------------------------------

TeleportSamus:
        LDA.w DoorMisaligned : BEQ .done

        PHA : BIT.w #$4000 : BEQ .iframes

        ; Reset position in the room
        PHX
        AND.w #$0FFF : TAX
        LDA.l DoorDirectionTable+6,X
        STA.w SamusXPos
        LDA.l DoorDirectionTable+8,X
        STA.w SamusYPos
        PLX

        ; Reset pose variables
        STZ $0A1C : STZ $0A1E
        STZ $0A20 : STZ $0A22
        STZ $0A24 : STZ $0A26

        ; Reset speed variables
        STZ $0B2C : STZ $0B2E
        STZ $0B42 : STZ $0B44
        STZ $0B46 : STZ $0B48

        LDA.w #$FFFF
        STA $0A2A : STA $0A2C : STA $0A2E

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
        STZ.w CREBitset
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
dw Door_GreenHills,DoorVectorToRetroPBs,$0001,$0020,$0288
dw Door_RetroPBs,DoorVectorToGreenHills,$0002,$01A0,$0088
dw Door_Moat,DoorVectorToOcean,$0001,$0024,$0488
dw Door_Ocean,DoorVectorToMoat,$0002,$01A0,$0088
dw Door_G4,DoorVectorToTourian,$0001,$0010,$0088
dw Door_Tourian,DoorVectorToG4,$0002,$00A0,$0688
dw Door_GreenElevator,DoorVectorToKago,$0001,$0020,$0088
dw Door_Kago,DoorVectorToGreenElevator,$0002,$00A0,$0088
dw Door_Highway,DoorVectorToHighwayExit,$0001,$0022,$0188
dw Door_HighwayExit,DoorVectorToHighway,$0002,$00A0,$0088
dw Door_NoobBridge,DoorVectorToRedTower,$0001,$0028,$0488
dw Door_RedTower,DoorVectorToNoobBridge,$0002,$05B0,$0088
dw Door_MaridiaEscape,DoorVectorToRedFish,$0001,$0020,$0088
dw Door_RedFish,DoorVectorToMaridiaEscape,$0002,$02A0,$0388
dw Door_KraidEntry,DoorVectorToElevatorEntry,$0001,$0037,$0088
dw Door_ElevatorEntry,DoorVectorToKraidEntry,$0002,$00A0,$0188
dw Door_AboveKraid,DoorVectorToMaridiaMap,$0001,$0008,$0188
dw Door_MaridiaMap,DoorVectorToAboveKraid,$0002,$03A0,$0088
dw Door_KraidMouth,DoorVectorToKraidsLair,$0001,$0020,$0088
dw Door_KraidsLair,DoorVectorToKraidMouth,$0002,$02A0,$0098
dw Door_SingleChamber,DoorVectorToMuskateers,$0001,$0138,$0088
dw Door_Muskateers,DoorVectorToSingleChamber,$0002,$05A4,$0088
dw Door_RidleyMouth,DoorVectorToLavaDive,$0001,$0138,$0288
dw Door_LavaDive,DoorVectorToRidleyMouth,$0002,$03A0,$0088
dw Door_PreAqueduct,DoorVectorToAqueduct,$0001,$0030,$0188
dw Door_Aqueduct,DoorVectorToPreAqueduct,$0002,$01A0,$0388

; Up / Down Doors
dw Door_Crabs,DoorVectorToRedElevator,$0003,$0060,$0058
dw Door_RedElevator,DoorVectorToCrabs,$0004,$014F,$02B8
dw Door_MaridiaTube,DoorVectorToMainStreet,$0005,$00F0,$07A8
dw Door_MainStreet,DoorVectorToMaridiaTube,$0006,$0044,$0078
dw Door_CrocEntry,DoorVectorToCroc,$0007,$037E,$0098
dw Door_Croc,DoorVectorToCrocEntry,$0008,$0C70,$02B8

; Boss Entry Doors (keep vanilla pairings first)
dw DoorToKraidBoss,DoorVectorToKraidInBrinstar,$0001,$0030,$0188 ; good
dw DoorToKraidBoss,DoorVectorToPhantoonInBrinstar,$0001,$0030,$00B8 ; good
dw DoorToKraidBoss,DoorVectorToDraygonInBrinstar,$0002,$01A0,$0088 ; good
dw DoorToKraidBoss,DoorVectorToRidleyInBrinstar,$0009,$0084,$0198 ; good

dw DoorToPhantoonBoss,DoorVectorToPhantoonInWreckedShip,$0001,$0030,$00B8 ; good
dw DoorToPhantoonBoss,DoorVectorToKraidInWreckedShip,$0001,$0030,$0188 ; good
dw DoorToPhantoonBoss,DoorVectorToDraygonInWreckedShip,$0002,$01A0,$0088 ; good
dw DoorToPhantoonBoss,DoorVectorToRidleyInWreckedShip,$000A,$0084,$0198 ; good

dw DoorToDraygonBoss,DoorVectorToDraygonInMaridia,$0002,$01A0,$0088 ; good
dw DoorToDraygonBoss,DoorVectorToKraidInMaridia,$0001,$0030,$0188 ; good
dw DoorToDraygonBoss,DoorVectorToPhantoonInMaridia,$0001,$0030,$00B8 ; good
dw DoorToDraygonBoss,DoorVectorToRidleyInMaridia,$0002,$0084,$0198 ; good

dw DoorToRidleyBoss,DoorVectorToRidleyInNorfair,$0002,$0084,$0198 ; good
dw DoorToRidleyBoss,DoorVectorToKraidInNorfair,$0001,$0030,$0188 ; good
dw DoorToRidleyBoss,DoorVectorToPhantoonInNorfair,$0001,$0030,$00B8 ; good
dw DoorToRidleyBoss,DoorVectorToDraygonInNorfair,$0002,$01A0,$0088 ; good

; Boss Exit Doors (keep vanilla pairings first)
dw DoorFromKraidInBrinstar,DoorVectorToPreKraid,$0002,$01B0,$0188 ; good
dw DoorFromPhantoonInBrinstar,DoorVectorToPreKraid,$0002,$01B0,$0188 ; good
dw DoorFromDraygonInBrinstar,DoorVectorToPreKraid,$0001,$01B0,$0188 ; good
dw DoorFromRidleyInBrinstar,DoorVectorToPreKraid,$0001,$01B0,$0188 ; good

dw DoorFromPhantoonInWreckedShip,DoorVectorToPrePhantoon,$0002,$04C4,$0088 ; testing
dw DoorFromKraidInWreckedShip,DoorVectorToPrePhantoon,$0002,$04C4,$0088 ; testing
dw DoorFromDraygonInWreckedShip,DoorVectorToPrePhantoon,$0001,$04C4,$0088 ; testing
dw DoorFromRidleyInWreckedShip,DoorVectorToPrePhantoon,$0001,$04C4,$0088 ; testing

dw DoorFromDraygonInMaridia,DoorVectorToPreDraygon,$0001,$003C,$0288 ; good
dw DoorFromKraidInMaridia,DoorVectorToPreDraygon,$0002,$003C,$0288 ; good
dw DoorFromPhantoonInMaridia,DoorVectorToPreDraygon,$0002,$003C,$0288 ; good
dw DoorFromRidleyInMaridia,DoorVectorToPreDraygon,$0001,$003C,$0288 ; good

dw DoorFromRidleyInNorfair,DoorVectorToPreRidley,$0001,$0020,$0098 ; good
dw DoorFromKraidInNorfair,DoorVectorToPreRidley,$0002,$0020,$0098 ; good
dw DoorFromPhantoonInNorfair,DoorVectorToPreRidley,$0002,$0020,$0098 ; good
dw DoorFromDraygonInNorfair,DoorVectorToPreRidley,$0001,$0020,$0098 ; good

; End
dw $0000

pullpc