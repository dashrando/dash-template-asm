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
        PHX
        
        ; Update Samus X position
        LDA $830004,X
        AND.w #$00FF : ASL #4
        STA.w SamusXPos

        ; Update Samus Y position
        LDA $830005,X
        AND.w #$00FF : ASL #4
        ADC.w #$28  ; TODO: based on samus height?
        STA.w SamusYPos

        ; Tweak Samus position based on door location
        LDA $830003,X
        AND.w #$0003
        CMP.w #$0003 ; 00 = right, 01 = left, 02 = down, 03 = up
        ; TODO: add a little x for left, subtract a little x for right
        ;       add a little y for down
        BNE +
                LDA.w SamusYPos
                SBC.w #$0058
                STA.w SamusYPos
                ;STZ DoorDirection
        +

        PLX
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
dw RoomHeaderPhantoonIn<area> : db $40,$04,$01,$06,$00,$00 : dw $8000,$0000
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
dw RoomHeaderDraygonIn<area> : db $40,$05,$1E,$06,$01,$00 : dw $8000,$0000
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
dw RoomHeaderRidleyIn<area> : db $40,$05,$0E,$06,$00,$00 : dw $8000,$0000
endmacro

%RidleyVector(Brinstar)
%RidleyVector(WreckedShip)
%RidleyVector(Maridia)

;---

DoorDirectionTable:
dw Door_GreenHills,$0001
dw Door_RetroPBs,$0002
dw Door_Moat,$0001
dw Door_Ocean,$0002
dw Door_G4,$0001
dw Door_Tourian,$0002
dw Door_GreenElevator,$0001
dw Door_Kago,$0002
dw Door_Highway,$0001
dw Door_HighwayExit,$0002
dw Door_NoobBridge,$0001
dw Door_RedTower,$0002
dw Door_MaridiaEscape,$0001
dw Door_RedFish,$0002
dw Door_KraidEntry,$0001
dw Door_ElevatorEntry,$0002
dw Door_AboveKraid,$0001
dw Door_MaridiaMap,$0002
dw Door_KraidMouth,$0001
dw Door_KraidsLair,$0002
dw Door_SingleChamber,$0001
dw Door_Muskateers,$0002
dw Door_RidleyMouth,$0001
dw Door_LavaDive,$0002
dw Door_PreAqueduct,$0001
dw Door_Aqueduct,$0002
dw Door_Crabs,$0003
dw Door_RedElevator,$0004
dw Door_MaridiaTube,$0005
dw Door_MainStreet,$0006
dw Door_CrocEntry,$0007
dw Door_Croc,$0008
dw DoorToKraidBoss,$0001
dw DoorFromKraidInBrinstar,$0002
dw DoorFromKraidInWreckedShip,$0002
dw DoorFromKraidInMaridia,$0002
dw DoorFromKraidInNorfair,$0002
dw DoorToPhantoonBoss,$0001
dw DoorFromPhantoonInBrinstar,$0002
dw DoorFromPhantoonInWreckedShip,$0002
dw DoorFromPhantoonInMaridia,$0002
dw DoorFromPhantoonInNorfair,$0002
dw DoorToDraygonBoss,$0002
dw DoorFromDraygonInBrinstar,$0001
dw DoorFromDraygonInWreckedShip,$0001
dw DoorFromDraygonInMaridia,$0001
dw DoorFromDraygonInNorfair,$0001
dw DoorToRidleyBoss,$0002
dw DoorFromRidleyInBrinstar,$0001
dw DoorFromRidleyInWreckedShip,$0001
dw DoorFromRidleyInMaridia,$0001
dw DoorFromRidleyInNorfair,$0001
dw $0000

DoorVectorTable:
dw DoorVectorToGreenHills,$0002
dw DoorVectorToRetroPBs,$0001
dw DoorVectorToMoat,$0002
dw DoorVectorToOcean,$0001
dw DoorVectorToG4,$0002
dw DoorVectorToTourian,$0001
dw DoorVectorToGreenElevator,$0002
dw DoorVectorToKago,$0001
dw DoorVectorToHighway,$0002
dw DoorVectorToHighwayExit,$0001
dw DoorVectorToNoobBridge,$0002
dw DoorVectorToRedTower,$0001
dw DoorVectorToMaridiaEscape,$0002
dw DoorVectorToRedFish,$0001
dw DoorVectorToKraidEntry,$0002
dw DoorVectorToElevatorEntry,$0001
dw DoorVectorToAboveKraid,$0002
dw DoorVectorToMaridiaMap,$0001
dw DoorVectorToKraidMouth,$0002
dw DoorVectorToKraidsLair,$0001
dw DoorVectorToSingleChamber,$0002
dw DoorVectorToMuskateers,$0001
dw DoorVectorToRidleyMouth,$0002
dw DoorVectorToLavaDive,$0001
dw DoorVectorToPreAqueduct,$0002
dw DoorVectorToAqueduct,$0001
dw DoorVectorToCrabs,$0004
dw DoorVectorToRedElevator,$0003
dw DoorVectorToMaridiaTube,$0006
dw DoorVectorToMainStreet,$0005
dw DoorVectorToCrocEntry,$0008
dw DoorVectorToCroc,$0007
dw DoorVectorToPreKraid,$0002
dw DoorVectorToKraidInBrinstar,$0001
dw DoorVectorToKraidInWreckedShip,$0001
dw DoorVectorToKraidInMaridia,$0001
dw DoorVectorToKraidInNorfair,$0001
dw DoorVectorToPrePhantoon,$0002
dw DoorVectorToPhantoonInBrinstar,$0001
dw DoorVectorToPhantoonInWreckedShip,$0001
dw DoorVectorToPhantoonInMaridia,$0001
dw DoorVectorToPhantoonInNorfair,$0001
dw DoorVectorToPreDraygon,$0001
dw DoorVectorToDraygonInBrinstar,$0002
dw DoorVectorToDraygonInWreckedShip,$0002
dw DoorVectorToDraygonInMaridia,$0002
dw DoorVectorToDraygonInNorfair,$0002
dw DoorVectorToPreRidley,$0001
dw DoorVectorToRidleyInBrinstar,$0002
dw DoorVectorToRidleyInWreckedShip,$0002
dw DoorVectorToRidleyInMaridia,$0002
dw DoorVectorToRidleyInNorfair,$0002
dw $0000

pullpc