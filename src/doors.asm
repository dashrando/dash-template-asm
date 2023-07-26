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

if !AREA == 1
    WestSandHall_GreyDoor_PLM:
    dw $C842,$060E,$1000,$0000

    SandFalls_GreyDoor_PLM:
    dw $C842,$063E,$1000,$0000

    pushpc
    org $8FD273
    dw WestSandHall_GreyDoor_PLM

    org $8FD71E
    dw SandFalls_GreyDoor_PLM
    pullpc
endif

;------------------------------------------------------------------------------
; Flashing doors for area
;------------------------------------------------------------------------------

if !AREA == 1
    pushpc

    ; n00b bridge portal
    org $8F87A6 : dw $C842,$065E,$8C33
    org $A19325 : db $00

    ; Green Hills portal
    org $8F8670 : dw $C842,$061E,$8C30
    org $A19D5B : db $00

    ; Retro PBs portal
    org $8F874B : db $8C
    org $A193A8 : db $00

    ; Croc Entry portal
    org $8F8B4E         ; Norfair above Croc 8b96
    skip $48 : dw $0000 ; Make upper Croc door blue

    ; Croc Exit portal
    org $8F8B9E ; Croc room
    dw NoopPLM : dw $0000, $0000 ; Make top door blue
    
    ; G4 portal
    org $8F844C
    skip 36 : dw $0000

    ; Crabs
    org $8F81FE
    skip 42 : dw $0000

    ; Red Elevator
    org $8F8250
    skip 6 : dw $0000

    ; Highway (Maridia)
    org $8F823E
    skip 0 : dw $0000

    ; Lava Dive
    org $8F8D1E
    skip 48 : dw $0000

    ; PreAqueduct
    org $8FC4EF
    skip 12 : dw $0000

    ; Back door WS
    org $8FC247
    skip 42 : dw NoopPLM : dw $0000, $0000

    pullpc
endif

;------------------------------------------------------------------------------
; Logic to position Samus using misaligned door transitions
;------------------------------------------------------------------------------

TeleportSamus:
        LDA.w DoorMisaligned : BEQ .done

        PHA : BIT.w #$8000 : BEQ +
        LDA.w #$0080
        STA.w $18a8
        +

        PLA : BIT.w #$4000 : BEQ .done

        PHX
        AND.w #$0FFF : TAX
        LDA.l DoorDirectionTable+6,X
        STA.w SamusXPos
        LDA.l DoorDirectionTable+8,X
        STA.w SamusYPos
        PLX

        STZ $0B2C : STZ $0B2E
        STZ $0B42 : STZ $0B44
        STZ $0B46 : STZ $0B48

        STZ $0A1C : STZ $0A1E
        STZ $0A20 : STZ $0A22
        STZ $0A24 : STZ $0A26

        LDA.w #$FFFF
        STA $0A2A : STA $0A2C : STA $0A2E

        STZ.w SamusAnimationFrame

        LDA $0A6E : CMP #$0002 : BNE +
            LDA #$CACA
            STA.w $0741
        +

        .done:
        PLB : PLP
RTL

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
dw RoomHeaderVariaSuitIn<area> : %CopyBytes($8391DA+2,$8391E6)
DoorVectorToKraidFromVariaSuitIn<area>:
dw RoomHeaderKraidIn<area>     : %CopyBytes($839252+2,$83925E)
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
dw RoomHeaderPhantoonIn<area> : db $40,$04,$01,$06,$00,$01 : dw $8000,$0000
endmacro

%PhantoonVector(Brinstar)
%PhantoonVector(Maridia)
%PhantoonVector(Norfair)

;---

macro SpaceJumpVectors(area)
DoorVectorToSpaceJumpIn<area>:
dw RoomHeaderSpaceJumpIn<area> : %CopyBytes($83A978+2,$83A984) ; verify (ok)
DoorVectorToDraygonFromSpaceJumpIn<area>:
dw RoomHeaderDraygonIn<area>   : %CopyBytes($83A924+2,$83A930) ; verify (ok)
endmacro

%SpaceJumpVectors(Brinstar)
%SpaceJumpVectors(WreckedShip)
%SpaceJumpVectors(Norfair)

;---

macro DraygonVector(area)
DoorVectorToDraygonIn<area>:
dw RoomHeaderDraygonIn<area> : db $40,$05,$1E,$06,$01,$01 : dw $8000,$0000
endmacro

%DraygonVector(Brinstar)
%DraygonVector(WreckedShip)
%DraygonVector(Norfair)

;---

macro RidleyTankVectors(area)
DoorVectorToRidleyTankIn<area>:
dw RoomHeaderRidleyTankIn<area> : %CopyBytes($8398B2+2,$8398BE) ; verify
DoorVectorToRidleyFromTankIn<area>:
dw RoomHeaderRidleyIn<area>     : %CopyBytes($839A62+2,$839A6E) ; verify
endmacro

%RidleyTankVectors(Brinstar)
%RidleyTankVectors(WreckedShip)
%RidleyTankVectors(Maridia)

;---

macro RidleyVector(area)
DoorVectorToRidleyIn<area>:
dw RoomHeaderRidleyIn<area> : db $40,$05,$0E,$06,$00,$01 : dw $8000,$0000
endmacro

%RidleyVector(Brinstar)
%RidleyVector(WreckedShip)
%RidleyVector(Maridia)

;--------------------------------------------------------------------
; Door Alignment Table
;    types: 0001 right-to-left
;           0002 left-to-right
;           0003+ unique (don't try to align)
;--------------------------------------------------------------------
DoorDirectionTable:

; Left / Right Doors
dw Door_GreenHills,DoorVectorToRetroPBs,$0001,$0020,$0288 ; testing
dw Door_RetroPBs,DoorVectorToGreenHills,$0002,$01A0,$0088 ; testing
dw Door_Moat,DoorVectorToOcean,$0001,$0024,$0488 ; testing
dw Door_Ocean,DoorVectorToMoat,$0002,$01BF,$0088 ; testing
dw Door_G4,DoorVectorToTourian,$0001,$0034,$0088
dw Door_Tourian,DoorVectorToG4,$0002,$00BC,$0688
dw Door_GreenElevator,DoorVectorToKago,$0001,$003C,$0088
dw Door_Kago,DoorVectorToGreenElevator,$0002,$00C6,$0088
dw Door_Highway,DoorVectorToHighwayExit,$0001,$00C7,$0088
dw Door_HighwayExit,DoorVectorToHighway,$0002,$003A,$0188
dw Door_NoobBridge,DoorVectorToRedTower,$0001,$0038,$0488
dw Door_RedTower,DoorVectorToNoobBridge,$0002,$05CB,$0088
dw Door_MaridiaEscape,DoorVectorToRedFish,$0001,$0038,$0088
dw Door_RedFish,DoorVectorToMaridiaEscape,$0002,$02A0,$0388 ; testing
dw Door_KraidEntry,DoorVectorToElevatorEntry,$0001,$0037,$0088 ; good
dw Door_ElevatorEntry,DoorVectorToKraidEntry,$0002,$00C0,$0188 ; testing
dw Door_AboveKraid,DoorVectorToMaridiaMap,$0001,$002C,$0188
dw Door_MaridiaMap,DoorVectorToAboveKraid,$0002,$03C2,$0088
dw Door_KraidMouth,DoorVectorToKraidsLair,$0001,$003A,$0088
dw Door_KraidsLair,DoorVectorToKraidMouth,$0002,$02A0,$0098 ; testing
dw Door_SingleChamber,DoorVectorToMuskateers,$0001,$0138,$0088
dw Door_Muskateers,DoorVectorToSingleChamber,$0002,$05B0,$0088 ; good
dw Door_RidleyMouth,DoorVectorToLavaDive,$0001,$0138,$0288
dw Door_LavaDive,DoorVectorToRidleyMouth,$0002,$03A0,$0088 ; good
dw Door_PreAqueduct,DoorVectorToAqueduct,$0001,$0030,$0188 ; good
dw Door_Aqueduct,DoorVectorToPreAqueduct,$0002,$01A0,$0388 ; good
dw Door_Crabs,DoorVectorToRedElevator,$0003,$007D,$0058 ; testing

; Up / Down Doors
dw Door_RedElevator,DoorVectorToCrabs,$0004,$014F,$02B8 ; testing
dw Door_MaridiaTube,DoorVectorToMainStreet,$0005,$014B,$07A8
dw Door_MainStreet,DoorVectorToMaridiaTube,$0006,$007B,$0078
dw Door_CrocEntry,DoorVectorToCroc,$0007,$037E,$0098
dw Door_Croc,DoorVectorToCrocEntry,$0008,$0CA4,$02B8

; Boss Entry Doors (keep vanilla pairings first)
dw DoorToKraidBoss,DoorVectorToKraidInBrinstar,$0001,$0030,$0188 ; testing
dw DoorToKraidBoss,DoorVectorToPhantoonInBrinstar,$0001,$0030,$00B8 ; testing
dw DoorToKraidBoss,DoorVectorToDraygonInBrinstar,$0002,$01A0,$0088 ; testing
dw DoorToKraidBoss,DoorVectorToRidleyInBrinstar,$0009,$0084,$0198 ; testing

dw DoorToPhantoonBoss,DoorVectorToPhantoonInWreckedShip,$0001,$0030,$00B8 ; testing
dw DoorToPhantoonBoss,DoorVectorToKraidInWreckedShip,$0001,$0030,$0188 ; testing
dw DoorToPhantoonBoss,DoorVectorToDraygonInWreckedShip,$0002,$01B8,$0088
dw DoorToPhantoonBoss,DoorVectorToRidleyInWreckedShip,$000A,$0084,$0198

dw DoorToDraygonBoss,DoorVectorToDraygonInMaridia,$0002,$01B8,$0088 ; testing
dw DoorToDraygonBoss,DoorVectorToKraidInMaridia,$0001,$0030,$0188 ; testing
dw DoorToDraygonBoss,DoorVectorToPhantoonInMaridia,$0001,$0030,$00B8 ; testing
dw DoorToDraygonBoss,DoorVectorToRidleyInMaridia,$000B,$0084,$0198 ; good (TODO: should be able to align)

dw DoorToRidleyBoss,DoorVectorToRidleyInNorfair,$0002,$0084,$0198 ; testing
dw DoorToRidleyBoss,DoorVectorToKraidInNorfair,$0001,$0030,$0188 ; testing
dw DoorToRidleyBoss,DoorVectorToPhantoonInNorfair,$0001,$0030,$00B8 ; testing
dw DoorToRidleyBoss,DoorVectorToDraygonInNorfair,$0002,$01B8,$0088

; Boss Exit Doors (keep vanilla pairings first)
dw DoorFromKraidInBrinstar,DoorVectorToPreKraid,$0002,$01B0,$0188 ; good
dw DoorFromPhantoonInBrinstar,DoorVectorToPreKraid,$0002,$01B0,$0188 ; good
dw DoorFromDraygonInBrinstar,DoorVectorToPreKraid,$0001,$01B0,$0188 ; good
dw DoorFromRidleyInBrinstar,DoorVectorToPreKraid,$0001,$01B0,$0188 ; good

dw DoorFromPhantoonInWreckedShip,DoorVectorToPrePhantoon,$0002,$04C4,$0088 ; testing
dw DoorFromKraidInWreckedShip,DoorVectorToPrePhantoon,$0002,$04C4,$0088
dw DoorFromDraygonInWreckedShip,DoorVectorToPrePhantoon,$0001,$04C4,$0088
dw DoorFromRidleyInWreckedShip,DoorVectorToPrePhantoon,$0001,$04C4,$0088

dw DoorFromDraygonInMaridia,DoorVectorToPreDraygon,$0001,$003C,$0288
dw DoorFromKraidInMaridia,DoorVectorToPreDraygon,$0002,$003C,$0288
dw DoorFromPhantoonInMaridia,DoorVectorToPreDraygon,$0002,$003C,$0288 ; good
dw DoorFromRidleyInMaridia,DoorVectorToPreDraygon,$0001,$003C,$0288

dw DoorFromRidleyInNorfair,DoorVectorToPreRidley,$0001,$0020,$0098 ; testing
dw DoorFromKraidInNorfair,DoorVectorToPreRidley,$0002,$0020,$0098 ; testing
dw DoorFromPhantoonInNorfair,DoorVectorToPreRidley,$0002,$0020,$0098 ;testing
dw DoorFromDraygonInNorfair,DoorVectorToPreRidley,$0001,$0020,$0098 ; testing

; End
dw $0000

pullpc