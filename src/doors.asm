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
; Boss Door Transitions
;------------------------------------------------------------------------------
AppearInKraidRoom:    %SetPos($0034,$0188)
AppearInPhantoonRoom: %SetPos($002E,$00B8)
AppearInDraygonRoom:  %SetPos($01D0,$0070)
AppearInRidleyRoom:   %SetPos($00C4,$0084)

AppearInPreKraid:                  %SetPos($01CD,$0188)
AppearInPrePhantoon: JSR.w $E1FE : %SetPos($049F,$00B8)
AppearInPreDraygon:  JSR.w $E3D9 : %SetPos($0034,$0288)
AppearInPreRidley:                 %SetPos($002E,$0098)

;------------------------------------------------------------------------------
; Area Door Transitions
;------------------------------------------------------------------------------

AppearInRetroPBs:      %SetPos($0000,$0000)
AppearInGreenHills:    %SetPos($0000,$0000)
AppearInMoat:          %SetPos($0000,$0000)
AppearInOcean:         %SetPos($0000,$0000)
AppearInG4:            %SetPos($0000,$0000)
AppearInTourian:       %SetPos($0000,$0000)
AppearInKago:          %SetPos($0000,$0000)
AppearInGreenElevator: %SetPos($0000,$0000)
AppearInCrabs:         %SetPos($0000,$0000)
AppearInRedElevator:   %SetPos($0000,$0000)
AppearInHighwayExit:   %SetPos($0000,$0000)
AppearInHighway:       %SetPos($0000,$0000)
AppearInNoobBridge:    %SetPos($0000,$0000)
AppearInRedTower:      %SetPos($0000,$0000)
AppearInMaridiaEscape: %SetPos($0000,$0000)
AppearInRedFish:       %SetPos($0000,$0000)
AppearInMaridiaTube:   %SetPos($0000,$0000)
AppearInMainStreet:    %SetPos($0000,$0000)
AppearInKraidEntry:    %SetPos($0000,$0000)
AppearInElevatorEntry: %SetPos($0000,$0000)
AppearInAboveKraid:    %SetPos($0000,$0000)
AppearInMaridiaMap:    %SetPos($0000,$0000)
AppearInKraidMouth:    %SetPos($0000,$0000)
AppearInKraidsLair:    %SetPos($0000,$0000)
AppearInCrocEntry:     %SetPos($0000,$0000)
AppearInCroc:          %SetPos($0000,$0000)
AppearInSingleChamber: %SetPos($0000,$0000)
AppearInMuskateers:    %SetPos($0000,$0000)
AppearInLavaDive:      %SetPos($0000,$0000)
AppearInRidleyMouth:   %SetPos($0000,$0000)
AppearInPreAqueduct:   %SetPos($0000,$0000)
AppearInAqueduct:      %SetPos($0000,$0000)

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
; vanilla = dx A59F,00,04,01,16,00,01,8000,0000

DoorVectorTeleportToPhantoon:
dw $CD13 : db $40,$04,$01,$06,$00,$00 : dw $8000,AppearInPhantoonRoom
; vanilla = dx CD13,00,04,01,06,00,00,8000,0000

DoorVectorTeleportToDraygon:
dw $DA60 : db $40,$05,$1E,$06,$01,$00 : dw $8000,AppearInDraygonRoom
; vanilla = dx DA60,00,05,1E,06,01,00,8000,0000

DoorVectorTeleportToRidley:
dw $B32E : db $40,$05,$0E,$06,$00,$00 : dw $8000,AppearInRidleyRoom
; vanilla = dx B32E,00,05,0E,06,00,00,8000,0000

DoorVectorTeleportToPreKraid:
dw $A56B : db $40,$05,$1E,$16,$01,$01 : dw $8000,AppearInPreKraid
; vanilla = dx A56B,00,05,1E,16,01,01,8000,0000

DoorVectorTeleportToPrePhantoon:
dw $CC6F : db $40,$05,$4E,$06,$04,$00 : dw $8000,AppearInPrePhantoon
; vanilla = dx CC6F,00,05,4E,06,04,00,8000,E1FE

DoorVectorTeleportToPreDraygon:
dw $D78F : db $40,$04,$01,$26,$00,$02 : dw $8000,AppearInPreDraygon
; vanilla = dx D78F,00,04,01,26,00,02,8000,E3D9

DoorVectorTeleportToPreRidley:
dw $B37A : db $40,$04,$01,$06,$00,$00 : dw $8000,AppearInPreRidley
; vanilla = dx B37A,00,04,01,06,00,00,8000,0000

DoorVectorTeleportToRetroPBs:
dw $0000 : db $00,$00,$00,$00,$00,$00 : dw $8000,AppearInRetroPBs

DoorVectorTeleportToGreenHills:
dw $0000 : db $00,$00,$00,$00,$00,$00 : dw $8000,AppearInGreenHills

DoorVectorTeleportToMoat:
dw $0000 : db $00,$00,$00,$00,$00,$00 : dw $8000,AppearInMoat

DoorVectorTeleportToOcean:
dw $0000 : db $00,$00,$00,$00,$00,$00 : dw $8000,AppearInOcean

DoorVectorTeleportToG4:
dw $0000 : db $00,$00,$00,$00,$00,$00 : dw $8000,AppearInG4

DoorVectorTeleportToTourian:
dw $0000 : db $00,$00,$00,$00,$00,$00 : dw $8000,AppearInTourian

DoorVectorTeleportToKago:
dw $0000 : db $00,$00,$00,$00,$00,$00 : dw $8000,AppearInKago

DoorVectorTeleportToGreenElevator:
dw $0000 : db $00,$00,$00,$00,$00,$00 : dw $8000,AppearInGreenElevator

DoorVectorTeleportToCrabs:
dw $0000 : db $00,$00,$00,$00,$00,$00 : dw $8000,AppearInCrabs

DoorVectorTeleportToRedElevator:
dw $0000 : db $00,$00,$00,$00,$00,$00 : dw $8000,AppearInRedElevator

DoorVectorTeleportToHighwayExit:
dw $0000 : db $00,$00,$00,$00,$00,$00 : dw $8000,AppearInHighwayExit

DoorVectorTeleportToHighway:
dw $0000 : db $00,$00,$00,$00,$00,$00 : dw $8000,AppearInHighway

DoorVectorTeleportToNoobBridge:
dw $0000 : db $00,$00,$00,$00,$00,$00 : dw $8000,AppearInNoobBridge

DoorVectorTeleportToRedTower:
dw $0000 : db $00,$00,$00,$00,$00,$00 : dw $8000,AppearInRedTower

DoorVectorTeleportToMaridiaEscape:
dw $0000 : db $00,$00,$00,$00,$00,$00 : dw $8000,AppearInMaridiaEscape

DoorVectorTeleportToRedFish:
dw $0000 : db $00,$00,$00,$00,$00,$00 : dw $8000,AppearInRedFish

DoorVectorTeleportToMaridiaTube:
dw $0000 : db $00,$00,$00,$00,$00,$00 : dw $8000,AppearInMaridiaTube

DoorVectorTeleportToMainStreet:
dw $0000 : db $00,$00,$00,$00,$00,$00 : dw $8000,AppearInMainStreet

DoorVectorTeleportToKraidEntry:
dw $0000 : db $00,$00,$00,$00,$00,$00 : dw $8000,AppearInKraidEntry

DoorVectorTeleportToElevatorEntry:
dw $0000 : db $00,$00,$00,$00,$00,$00 : dw $8000,AppearInElevatorEntry

DoorVectorTeleportToAboveKraid:
dw $0000 : db $00,$00,$00,$00,$00,$00 : dw $8000,AppearInAboveKraid

DoorVectorTeleportToMaridiaMap:
dw $0000 : db $00,$00,$00,$00,$00,$00 : dw $8000,AppearInMaridiaMap

DoorVectorTeleportToKraidMouth:
dw $0000 : db $00,$00,$00,$00,$00,$00 : dw $8000,AppearInKraidMouth

DoorVectorTeleportToKraidsLair:
dw $0000 : db $00,$00,$00,$00,$00,$00 : dw $8000,AppearInKraidsLair

DoorVectorTeleportToCrocEntry:
dw $0000 : db $00,$00,$00,$00,$00,$00 : dw $8000,AppearInCrocEntry

DoorVectorTeleportToCroc:
dw $0000 : db $00,$00,$00,$00,$00,$00 : dw $8000,AppearInCroc

DoorVectorTeleportToSingleChamber:
dw $0000 : db $00,$00,$00,$00,$00,$00 : dw $8000,AppearInSingleChamber

DoorVectorTeleportToMuskateers:
dw $0000 : db $00,$00,$00,$00,$00,$00 : dw $8000,AppearInMuskateers

DoorVectorTeleportToLavaDive:
dw $0000 : db $00,$00,$00,$00,$00,$00 : dw $8000,AppearInLavaDive

DoorVectorTeleportToRidleyMouth:
dw $0000 : db $00,$00,$00,$00,$00,$00 : dw $8000,AppearInRidleyMouth

DoorVectorTeleportToPreAqueduct:
dw $0000 : db $00,$00,$00,$00,$00,$00 : dw $8000,AppearInPreAqueduct

DoorVectorTeleportToAqueduct:
dw $0000 : db $00,$00,$00,$00,$00,$00 : dw $8000,AppearInAqueduct

pullpc