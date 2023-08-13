;------------------------------------------------------------------------------
; Custom PLM lists ($AD-$CF are good values)
;------------------------------------------------------------------------------

;------------------------------------------------------------------------------
; Flashing doors for area
; Grey Door Facing Left  : $C842
; Grey Door Facing Right : $C848
; Grey Door Facing Up    : $C84E
; Grey Door Facing Down  : $C854
;------------------------------------------------------------------------------

;------------------------------------------------------------------------------
; Crateria
;------------------------------------------------------------------------------

CustomPLMs_Kago:
dw $C848 : db $01,$06 : dw $9CAD  ; flashing door cap
dw $0000

CustomPLMs_Moat:
dw $C842 : db $1E,$06 : dw $9CAE  ; flashing door cap
dw $0001,$0000,PLMList1Moat       ; run vanilla list

pushpc
if !AREA == 1
    ; Kago - Room $9969
    org RoomState1Kago
    skip 20 : dw CustomPLMs_Kago

    ; Moat - Room $95FF
    org RoomState1Moat
    skip 20 : dw CustomPLMs_Moat

    ; G4 portal - Room $99BD
    org PLMList1G4
    skip 36                           ; replace red cap with
    dw $C842 : db $0E,$66 : dw $9C1E  ; flashing door cap

    ; Retro PBs portal - Room $9E9F
    org PLMList2RetroPBs
    skip 96
    dw $C848 : db $01,$26 : dw $9C31  ; flashing door cap

    ; Crabs - Room $948C
    org PLMList1Crabs
    skip 42
    dw $C84E : db $16,$2D : dw $9C0E  ; flashing door cap
endif
pullpc

;------------------------------------------------------------------------------
; Green Brinstar
;------------------------------------------------------------------------------

CustomPLMs_GreenElevator:
dw $C842 : db $0E,$06 : dw $9CAF      ; flashing door cap
dw $0001,$0000,PLMList1GreenElevator  ; run vanilla list

pushpc
if !AREA == 1
    ; Green Elevator - Room $9938
    org RoomState1GreenElevator
    skip 20 : dw CustomPLMs_GreenElevator

    ; Green Hills - Room $9E52
    org PLMList1GreenHills            ; update vanilla PLM list
    dw $0002 : skip 4                 ; remove the blue gate
    skip 6                            ; replace yellow cap
    dw $C842 : db $1E,$06 : dw $9C30  ; with flashing cap

    ; n00b bridge - Room $9FBA
    org PLMList1NoobBridge            ; update vanilla PLM list
    dw $C842 : db $5E,$06 : dw $9C33  ; flashing door cap
endif

; Green Tower - Room $9AD9
org PLMList1GreenTower
skip 36
dw $0002 : skip 4                 ; remove the pink save door
skip 18
dw $0002 : skip 4                 ; remove the pink refill door

; Green Brinstar Pre Map - Room $9B9D
org PLMList1GreenBrinstarPreMap
dw $0000                          ; remove grey door
pullpc

;------------------------------------------------------------------------------
; Red Brinstar
;------------------------------------------------------------------------------

CustomPLMs_KraidEntryAndAboveKraid:
dw $C842 : db $0E,$16 : dw $9CB2  ; flashing door cap (Kraid Entry)
dw $0001,$0000,PLMList1KraidEntry

pushpc
; Red Tower - Room $A253
org PLMList1RedTower
skip 12                           ; overwrite green cap with
if !AREA == 1
dw $C848 : db $01,$46 : dw $9C38  ; flashing door cap (reusing 38 from the green door PLM variable)
else
dw $0002 : skip 4                 ; nothing!
endif

if !AREA == 1
    ; Red Elevator - Room $962A
    org PLMList1RedElevator           ; TODO: double check variable
    skip 6                            ; overwrite yellow cap with
    dw $C854 : db $06,$02 : dw $9C10  ; flashing door cap

    ; Maridia Escape - Room $A322
    org PLMList1MaridiaEscape
    skip 30                           ; overwrite green gate with
    dw $C842 : db $2E,$36 : dw $9CB0  ; flashing door cap
endif

; Maridia Tube - Room $CEFB
org PLMList1MaridiaTube           ; TODO: reuse variable
skip 90                           ; replace pink cap with
if !AREA == 1
dw $C854 : db $06,$02 : dw $9CB1  ; flashing door cap
else
dw $0002 : skip 4                 ; nothing! 
endif

if !AREA == 1
    ; Kraid Entry And Above Kraid - Room $CF80
    org RoomState1KraidEntry
    skip 20 : dw CustomPLMs_KraidEntryAndAboveKraid

    org PLMList1KraidEntry
    skip 60
    dw $C842 : db $3E,$06 : dw $9CB3  ; flashing door cap (Above Kraid)
endif
pullpc

;------------------------------------------------------------------------------
; Maridia - West
;------------------------------------------------------------------------------
CustomPLMs_MainStreet:
dw $C84E : db $16,$7D : dw $9CB4  ; flashing door cap
dw $B76F : db $18,$59 : dw $0005  ; add save station
dw $0001,$0000,PLMList1MainStreet ; run the vanilla list

CustomPLMs_PreAqueduct:
dw $B76F : db $0D,$29 : dw $0004  ; add save station
dw $0001,$0000,PLMList1PreAqueduct

CustomPLMs_RedFish:
dw $C848 : db $01,$06 : dw $9CB5  ; flashing door cap
dw $0001,$0000,PLMList1RedFish

CustomPLMs_MaridiaMap:
dw $C848 : db $01,$16 : dw $9CB6  ; flashing door cap
dw $0001,$0000,PLMList1MaridiaMap

CustomPLMs_WestSandHallTunnel:
dw $C842,$060E,$1000              ; grey door
dw $0000

pushpc
if !AREA == 1
    ; Main Street - Room $CFC9
    org RoomState1MainStreet
    skip 20 : dw CustomPLMs_MainStreet

    ; PreAqueduct - Room $D1A3
    org RoomState1PreAqueduct
    skip 20 : dw CustomPLMs_PreAqueduct

    org PLMList1PreAqueduct           ; TODO: verify variable
    skip 12                           ; overwrite green cap with
    dw $C842 : skip 2     : dw $9C8F  ; flashing door cap

    ; Red Fish - Room $D104
    org RoomState1RedFish
    skip 20 : dw CustomPLMs_RedFish

    ; Maridia Map - Room $D21C
    org RoomState1MaridiaMap
    skip 20 : dw CustomPLMs_MaridiaMap

    ; West Sand Hall Tunnel - Room $D252
    org RoomState1WestSandHallTunnel
    skip 20 : dw CustomPLMs_WestSandHallTunnel
endif

if !AREA == 1 || !RECALL == 1
    ; Crab Shaft - Room $D08A
    org PLMList1CrabShaft
    dw $0002 : skip 4                 ; gate always open
endif
pullpc

;------------------------------------------------------------------------------
; Maridia - East
;------------------------------------------------------------------------------
CustomPLMs_Highway:
dw $C842 : db $0E,$06 : dw $9C0F  ; flashing door cap
dw $0000

CustomPLMs_SandFalls:
dw $C842,$063E,$1000              ; grey door
dw $0000

pushpc
; Aqueduct - Room $D5A7
org PLMList1Aqueduct                  ; overwrite pink door with
if !AREA == 1
    dw $C848 : db $01,$16 : dw $9CB7  ; flashing door cap TODO: reuse variable
else
    dw $0002 : skip 4                 ; nothing!
endif

if !AREA == 1
    ; Highway (Maridia) - Room $95A8
    org RoomState1Highway
    skip 20 : dw CustomPLMs_Highway

    ; Collosseum - Room $D72A
    org PLMList1Collosseum
    skip 6
    dw $0002 : skip 4

    ; Highway Maridia Elevator - Room $D30B
    org PLMList1HighwayElevator
    dw $0002 : skip 4

    ; Sand Falls - Room $D6FD
    org RoomState1SandFalls
    skip 20 : dw CustomPLMs_SandFalls
endif

if !RECALL == 1
    org $8FC571 ; Plasma Spark
    dw $0002 : skip 4 ; Plasma door blue

    org $8FC773 ; Halfie Shaft
    skip $26
    dw $0002 : skip 4 ; Back door to plasma

    org $8FC611 ; Back door to Draygon
    dw $0000    ; Make door blue
    
    org $8F823E ; Forgotten Highway before elevator
    dw $0000    ; Make door blue
endif
pullpc

;------------------------------------------------------------------------------
; Wrecked Ship
;------------------------------------------------------------------------------
CustomPLMs_Ocean:
%CopyBytes($8F81DC,30)            ; copy existing list
dw $C848 : db $01,$46 : dw $9CB8  ; flashing door cap
dw $0000

CustomPLMs_HighwayExit:
%CopyBytes($8F823C,0)             ; copy existing list
dw $C848 : db $01,$16 : dw $9CB9  ; flashing door cap
dw $0000

CustomPLMs_WSShaft:
%CopyBytes($8FC247,42)             ; copy existing list minus grey door
%CopyBytes($8FC247+48,6)           ; copy the rest of the existing list
dw $0000

pushpc
org $8FCE9C         ; WS Save room header Phantoon alive
skip $14 : dw $C2C9 ; Turn on save station

if !RECALL == 1
    org $8FCC39         ; WS E-tank room header Phantoon alive
    skip $14 : dw $C337 ; Show WS E-tank item

    org $8FCBE7         ; WS back room Phantoon alive
    skip $14 : dw $C323 ; Add missile door back
endif

if !AREA == 1
    org $8FCBE7         ; WS back room Phantoon alive
    skip $14 : dw $C323 ; Add missile door back
endif

if !AREA == 1
    ; Ocean - Room $93FE
    org RoomState1Ocean
    skip 20 : dw CustomPLMs_Ocean

    ; HighwayExit - Room $957D
    org RoomState1HighwayExit
    skip 20 : dw CustomPLMs_HighwayExit

    ; Back door WS - Room $CAF6
    org RoomState1WSShaft
    skip 20 : dw CustomPLMs_WSShaft
    org RoomState2WSShaft
    skip 20 : dw CustomPLMs_WSShaft
endif
pullpc

;------------------------------------------------------------------------------
; Upper Norfair
;------------------------------------------------------------------------------
CustomPLMs_ElevatorEntryAndKraidMouth:
%CopyBytes($8F8A5C,108)           ; copy existing list
dw $C848 : db $01,$06 : dw $9CBA  ; flashing door cap (Elevator Entry)
dw $C842 : db $2E,$06 : dw $9CBB  ; flashing door cap (Kraid Mouth)
dw $0000

CustomPLMs_SingleChamber:
%CopyBytes($8F8C8A,36)            ; copy existing list
dw $C842 : db $5E,$06 : dw $9CBC  ; flashing door cap
dw $0000

CustomPLMs_CrocEntry:
%CopyBytes($8F8B4E,48)            ; copy existing minus green door
dw $C84E : db $C6,$2D : dw $9C4E  ; flashing door cap
dw $0000

CustomPLMs_LavaDive:
%CopyBytes($8F8D1E,48)            ; copy existing minus orange door
dw $C848 : db $11,$26 : dw $9C58  ; flashing door cap
dw $0000

pushpc
if !RECALL == 1
    org $8F8B4E         ; Norfair above Croc 8b96
    skip $48 : dw $0000 ; Make upper Croc door blue
endif

if !AREA == 1
    ; Elevator Entry And Kraid Mouth - Room $A6A1
    org RoomState1ElevatorEntry
    skip 20 : dw CustomPLMs_ElevatorEntryAndKraidMouth

    ; Single Chamber - Room $AD5E
    org RoomState1SingleChamber
    skip 20 : dw CustomPLMs_SingleChamber

    ; Croc Entry (UN) - Room $A923
    org RoomState1CrocEntry
    skip 20 : dw CustomPLMs_CrocEntry

    ; Lava Dive - Room $AE74
    org RoomState1LavaDive
    skip 20 : dw CustomPLMs_LavaDive
endif
pullpc

;------------------------------------------------------------------------------
; Crocamire
;------------------------------------------------------------------------------
pushpc
; Croc - Room $A98D
org PLMList1Croc
if !AREA == 1
    dw $C854 : db $36,$02 : dw $9C4F  ; flashing door cap
elseif !RECALL == 1
    dw $0002 : skip 4                 ; open top door
endif

if !RECALL == 1
    ; Croc Green Gate - Room $AB64
    org PLMList1CrocGreenGate
    dw $0002 : skip 4                 ; gate always open
endif
pullpc

;------------------------------------------------------------------------------
; Lower Norfair
;------------------------------------------------------------------------------
CustomPLMs_Muskateers:
%CopyBytes($8F90D0,54)            ; copy existing list
dw $C848 : db $11,$06 : dw $9CBD  ; flashing door cap
dw $0000

CustomPLMs_RidleyMouth:
%CopyBytes($8F8D7E,0)             ; copy existing list (none)
dw $C842 : db $3E,$06 : dw $9CBE  ; flashing door cap
dw $0000

pushpc
if !AREA == 1
    ; Muskateers - Room $B656
    org RoomState1Muskateers
    skip 20 : dw CustomPLMs_Muskateers

    ; Ridley Mouth - Room $AF14
    org RoomState1RidleyMouth
    skip 20 : dw CustomPLMs_RidleyMouth
endif
pullpc

;------------------------------------------------------------------------------
; Kraid's Lair
;------------------------------------------------------------------------------
CustomPLMs_PreKraidsLair:
%CopyBytes($8F8A02,18)            ; copy existing list minus green door
%CopyBytes($8F8A02+24,18)         ; copy the rest of the existing list
dw $0000

pushpc
if !AREA == 1
    ; Pre Kraid's Lair - Room $A56B
    org RoomState1PreKraidsLair
    skip 20 : dw CustomPLMs_PreKraidsLair

    ; Kraid's Lair - Room $A471
    org RoomState1KraidsLair
    skip 20 : dw CustomPLMs_KraidsLair
endif
pullpc

CustomPLMs_KraidsLair:
%CopyBytes($8F8976,30)            ; copy existing list
dw $C848 : db $01,$06 : dw $9CBF  ; flashing door cap
dw $0000

;------------------------------------------------------------------------------
; Tourian
;------------------------------------------------------------------------------
CustomPLMs_Tourian:
%CopyBytes($8FA83C,0)             ; copy existing list
dw $C848 : db $01,$06 : dw $9CC0  ; flashing door cap
dw $0000

pushpc
if !AREA == 1
    ; Tourian - Room $A5ED
    org RoomState1Tourian
    skip 20 : dw CustomPLMs_Tourian
endif
pullpc