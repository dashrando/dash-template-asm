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

    pullpc
endif

;------------------------------------------------------------------------------
; Use vanilla door vector to reposition Samus
;------------------------------------------------------------------------------

macro Teleport(vanilla_door_vector)
        PEA.w <vanilla_door_vector>
        JMP.w TeleportSamus
endmacro

;------------------------------------------------------------------------------
; Boss Door Transitions
;------------------------------------------------------------------------------
AppearInKraidRoom:    %Teleport(DoorVectorToKraid)
AppearInPhantoonRoom: %Teleport(DoorVectorToPhantoon)
AppearInDraygonRoom:  %Teleport(DoorVectorToDraygon)
AppearInRidleyRoom:   %Teleport(DoorVectorToRidley)

AppearInPreKraid:    %Teleport(DoorVectorToPreKraid)
AppearInPrePhantoon: %Teleport(DoorVectorToPrePhantoon)
AppearInPreDraygon:  %Teleport(DoorVectorToPreDraygon)
AppearInPreRidley:   %Teleport(DoorVectorToPreRidley)

;------------------------------------------------------------------------------
; Area Door Transitions
;------------------------------------------------------------------------------

AppearInRetroPBs:      %Teleport(DoorVectorToRetroPBs)
AppearInGreenHills:    %Teleport(DoorVectorToGreenHills)
AppearInMoat:          %Teleport(DoorVectorToMoat)
AppearInOcean:         %Teleport(DoorVectorToOcean)
AppearInG4:            %Teleport(DoorVectorToG4)
AppearInTourian:       %Teleport(DoorVectorToTourian)
AppearInKago:          %Teleport(DoorVectorToKago)
AppearInGreenElevator: %Teleport(DoorVectorToGreenElevator)
AppearInCrabs:         %Teleport(DoorVectorToCrabs)
AppearInRedElevator:   %Teleport(DoorVectorToRedElevator)
AppearInHighwayExit:   %Teleport(DoorVectorToHighwayExit)
AppearInHighway:       %Teleport(DoorVectorToHighway)
AppearInNoobBridge:    %Teleport(DoorVectorToNoobBridge)
AppearInRedTower:      %Teleport(DoorVectorToRedTower)
AppearInMaridiaEscape: %Teleport(DoorVectorToMaridiaEscape)
AppearInRedFish:       %Teleport(DoorVectorToRedFish)
AppearInMaridiaTube:   %Teleport(DoorVectorToMaridiaTube)
AppearInMainStreet:    %Teleport(DoorVectorToMainStreet)
AppearInKraidEntry:    %Teleport(DoorVectorToKraidEntry)
AppearInElevatorEntry: %Teleport(DoorVectorToElevatorEntry)
AppearInAboveKraid:    %Teleport(DoorVectorToAboveKraid)
AppearInMaridiaMap:    %Teleport(DoorVectorToMaridiaMap)
AppearInKraidMouth:    %Teleport(DoorVectorToKraidMouth)
AppearInKraidsLair:    %Teleport(DoorVectorToKraidsLair)
AppearInCrocEntry:     %Teleport(DoorVectorToCrocEntry)
AppearInCroc:          %Teleport(DoorVectorToCroc)
AppearInSingleChamber: %Teleport(DoorVectorToSingleChamber)
AppearInMuskateers:    %Teleport(DoorVectorToMuskateers)
AppearInLavaDive:      %Teleport(DoorVectorToLavaDive)
AppearInRidleyMouth:   %Teleport(DoorVectorToRidleyMouth)
AppearInPreAqueduct:   %Teleport(DoorVectorToPreAqueduct)
AppearInAqueduct:      %Teleport(DoorVectorToAqueduct)

;------------------------------------------------------------------------------
; Logic to position Samus using misaligned door transitions
;------------------------------------------------------------------------------

TeleportSamus:
        PHX
        LDA $03,S : TAX

        ;
        LDA $83000A,X : BEQ .xpos
                STA $12
                PEA .xpos-1
                JMP ($0012)
        .xpos
        
        ;
        LDA $830004,X
        AND.w #$00FF : ASL #4
        STA.w SamusXPos

        ;
        LDA $830005,X
        AND.w #$00FF : ASL #4
        ADC.w #$28  ; TODO: based on samus height?
        STA.w SamusYPos

        ;
        LDA $830003,X
        AND.w #$0003
        CMP.w #$0003 ; 00 = right, 01 = left, 02 = down, 03 = up
        ; TODO: add a little x for left, subtract a little x for right
        ;       add a little y for down
        BNE +
                LDA.w SamusYPos
                SBC.w #$0058
                STA.w SamusYPos
                STZ $0791
        +

        ;
        PLX : PLA
RTS

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

DoorVectorTeleportToKraid:
dw $A59F : db $40,$04,$01,$16,$00,$01 : dw $8000,AppearInKraidRoom
;dx A59F,00,04,01,16,00,01,8000,0000

DoorVectorTeleportToPhantoon:
dw $CD13 : db $40,$04,$01,$06,$00,$00 : dw $8000,AppearInPhantoonRoom
;dx CD13,00,04,01,06,00,00,8000,0000

DoorVectorTeleportToDraygon:
dw $DA60 : db $40,$05,$1E,$06,$01,$00 : dw $8000,AppearInDraygonRoom
;dx DA60,00,05,1E,06,01,00,8000,0000

DoorVectorTeleportToRidley:
dw $B32E : db $40,$05,$0E,$06,$00,$00 : dw $8000,AppearInRidleyRoom
;dx B32E,00,05,0E,06,00,00,8000,0000

;---

DoorVectorTeleportToPreKraid:
dw $A56B : db $40,$05,$1E,$16,$01,$01 : dw $8000,AppearInPreKraid
;dx A56B,00,05,1E,16,01,01,8000,0000

DoorVectorTeleportToPrePhantoon:
dw $CC6F : db $40,$05,$4E,$06,$04,$00 : dw $8000,AppearInPrePhantoon
;dx CC6F,00,05,4E,06,04,00,8000,E1FE

DoorVectorTeleportToPreDraygon:
dw $D78F : db $40,$04,$01,$26,$00,$02 : dw $8000,AppearInPreDraygon
;dx D78F,00,04,01,26,00,02,8000,E3D9

DoorVectorTeleportToPreRidley:
dw $B37A : db $40,$04,$01,$06,$00,$00 : dw $8000,AppearInPreRidley
;dx B37A,00,04,01,06,00,00,8000,0000

;---

DoorVectorTeleportToRetroPBs:
dw $9E9F : db $40,$04,$01,$26,$00,$02 : dw $8000,AppearInRetroPBs
;dx 9E9F,00,04,01,26,00,02,8000,0000

;---

DoorVectorTeleportToGreenHills:
dw $9E52 : db $40,$05,$1E,$06,$01,$00 : dw $8000,AppearInGreenHills
;dx 9E52,00,05,1E,06,01,00,8000,0000

;---

DoorVectorTeleportToMoat:
dw $95FF : db $40,$05,$1E,$06,$01,$00 : dw $8000,AppearInMoat
;dx 95FF,00,05,1E,06,01,00,8000,0000

;---

DoorVectorTeleportToOcean:
dw $93FE : db $40,$04,$01,$46,$00,$04 : dw $8000,AppearInOcean
;dx 93FE,00,04,01,46,00,04,8000,0000

;---

DoorVectorTeleportToG4:
dw $99BD : db $40,$05,$0E,$66,$00,$06 : dw $8000,AppearInG4
;dx 99BD,00,05,0E,66,00,06,8000,0000

;---

DoorVectorTeleportToTourian:
dw $A5ED : db $40,$04,$01,$06,$00,$00 : dw $8000,AppearInTourian
;dx A5ED,00,04,01,06,00,00,8000,0000

;---

DoorVectorTeleportToKago:
dw $9969 : db $40,$04,$01,$06,$00,$00 : dw $8000,AppearInKago
;dx 9969,00,04,01,06,00,00,8000,0000

;---

DoorVectorTeleportToGreenElevator:
dw $9938 : db $40,$05,$0E,$06,$00,$00 : dw $8000,AppearInGreenElevator
;dx 9938,00,05,0E,06,00,00,8000,0000

;---

;DoorVectorToCrabs:
;dx 948C,00,07,16,2D,01,02,01C0,B9F1

DoorVectorReverseToCrabs:
dw $948C : db $40,$07,$16,$2D,$01,$02 : dw $01C0,AppearInCrabs

DoorVectorTeleportToCrabs:
dw $948C : db $40,$00,$16,$2D,$01,$02 : dw $0000,AppearInCrabs

;---

DoorVectorTeleportToRedElevator:
dw $962A : db $40,$06,$06,$02,$00,$00 : dw $8000,AppearInRedElevator
;dx 962A,00,06,06,02,00,00,8000,0000

;---

DoorVectorTeleportToHighwayExit:
dw $957D : db $40,$04,$01,$16,$00,$01 : dw $8000,AppearInHighwayExit
;dx 957D,00,04,01,16,00,01,8000,0000

;---

DoorVectorTeleportToHighway:
dw $95A8 : db $40,$05,$0E,$06,$00,$00 : dw $8000,AppearInHighway
;dx 95A8,00,05,0E,06,00,00,8000,0000

;---

DoorVectorTeleportToNoobBridge:
dw $9FBA : db $40,$05,$5E,$06,$05,$00 : dw $8000,AppearInNoobBridge
;dx 9FBA,00,05,5E,06,05,00,8000,0000

;---

DoorVectorTeleportToRedTower:
dw $A253 : db $40,$04,$01,$46,$00,$04 : dw $8000,AppearInRedTower
;dx A253,00,04,01,46,00,04,8000,0000

;---

DoorVectorTeleportToMaridiaEscape:
dw $A322 : db $40,$05,$2E,$36,$02,$03 : dw $8000,AppearInMaridiaEscape
;dx A322,40,05,2E,36,02,03,8000,E367

;---

DoorVectorTeleportToRedFish:
dw $D104 : db $40,$04,$01,$06,$00,$00 : dw $8000,AppearInRedFish
;dx D104,40,04,01,06,00,00,8000,BDAF

;---

DoorVectorTeleportToMaridiaTube:
dw $CEFB : db $40,$06,$06,$02,$00,$00 : dw $0170,AppearInMaridiaTube
;dx CEFB,00,06,06,02,00,00,0170,0000

;---

;DoorVectorToMainStreet:
;dx CFC9,00,07,16,7D,01,07,0200,0000

DoorVectorReverseToMainStreet:
dw $CFC9 : db $40,$07,$16,$7D,$01,$07 : dw $0200,AppearInMainStreet

DoorVectorTeleportToMainStreet:
dw $CFC9 : db $40,$00,$16,$7D,$01,$07 : dw $0000,AppearInMainStreet

;---

DoorVectorTeleportToKraidEntry:
dw $CF80 : db $40,$05,$0E,$16,$00,$01 : dw $8000,AppearInKraidEntry
;dx CF80,40,05,0E,16,00,01,8000,BDD1

;---

DoorVectorTeleportToElevatorEntry:
dw $A6A1 : db $40,$04,$01,$06,$00,$00 : dw $8000,AppearInElevatorEntry
;dx A6A1,40,04,01,06,00,00,8000,0000

;---

DoorVectorTeleportToAboveKraid:
dw $CF80 : db $40,$05,$3E,$06,$03,$00 : dw $8000,AppearInAboveKraid
;dx CF80,00,05,3E,06,03,00,8000,0000

;---

DoorVectorTeleportToMaridiaMap:
dw $D21C : db $40,$04,$01,$16,$00,$01 : dw $8000,AppearInMaridiaMap
;dx D21C,00,04,01,16,00,01,8000,E356

;---

DoorVectorTeleportToKraidMouth:
dw $A6A1 : db $40,$05,$2E,$06,$02,$00 : dw $8000,AppearInKraidMouth
;dx A6A1,00,05,2E,06,02,00,8000,BD3F

;---

DoorVectorTeleportToKraidsLair:
dw $A471 : db $40,$04,$01,$06,$00,$00 : dw $8000,AppearInKraidsLair
;dx A471,00,04,01,06,00,00,8000,0000

;---

;DoorVectorToCrocEntry:
;dx A923,00,07,C6,2D,0C,02,01C0,0000

DoorVectorReverseToCrocEntry:
dw $A923 : db $40,$07,$C6,$2D,$0C,$02 : dw $01C0,AppearInCrocEntry

DoorVectorTeleportToCrocEntry:
dw $A923 : db $40,$00,$C6,$2D,$0C,$02 : dw $0000,AppearInCrocEntry

;---

DoorVectorTeleportToCroc:
dw $A98D : db $40,$06,$36,$02,$03,$00 : dw $8000,AppearInCroc
;dx A98D,00,06,36,02,03,00,8000,0000

;---

DoorVectorTeleportToSingleChamber:
dw $AD5E : db $40,$05,$5E,$06,$05,$00 : dw $8000,AppearInSingleChamber
;dx AD5E,00,05,5E,06,05,00,8000,0000

;---

DoorVectorTeleportToMuskateers:
dw $B656 : db $40,$04,$11,$06,$01,$00 : dw $8000,AppearInMuskateers
;dx B656,00,04,11,06,01,00,8000,0000

;---

DoorVectorTeleportToLavaDive:
dw $AE74 : db $40,$04,$11,$26,$01,$02 : dw $8000,AppearInLavaDive
;dx AE74,00,04,11,26,01,02,8000,0000

;---

DoorVectorTeleportToRidleyMouth:
dw $AF14 : db $40,$05,$3E,$06,$03,$00 : dw $8000,AppearInRidleyMouth
;dx AF14,00,05,3E,06,03,00,8000,0000

;---

DoorVectorTeleportToPreAqueduct:
dw $D1A3 : db $40,$05,$1E,$36,$01,$03 : dw $8000,AppearInPreAqueduct
;dx D1A3,00,05,1E,36,01,03,8000,E398

;---

DoorVectorTeleportToAqueduct:
dw $D5A7 : db $40,$04,$01,$16,$00,$01 : dw $8000,AppearInAqueduct
;dx D5A7,00,04,01,16,00,01,8000,0000

pullpc