;------------------------------------------------------------------------------
; PLM List Updates
;------------------------------------------------------------------------------
; Most of the changes in this file deal with opening doors/gates but
; also include things like activating save stations.
;
; There are two primary ways to update the PLMs for a room:
;   1) Update the entries in the vanilla PLM list
;   2) Create a custom PLM list
;
; Because item locations are in the vanilla lists, it is important that
; we always execute those PLMs. With that in mind, we added a special PLM
; that jumps from one list to another. We can use that PLM ($0001) in our
; custom lists to jump back to the vanilla list. Additionally, we added
; a special PLM ($0002) for skipping a PLM.
;
; Custom PLM Notes:
;   - Each PLM needs a variable assigned to it. This is placed in the
;     lo byte so for $9CC0 the variable is $C0.
;   - According to the online docs, $AD-$CF are unused PLM variables that
;     we can use for this.
;   - If replacing one door cap with another, we can reuse the variable
;     from the original cap. When we do this, we avoid specifying the
;     variable by using skip commands.
;   - Sometimes we replace a gate with a door cap, but we are not
;     reusing the gate variable for now. Maybe in the future.
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
    skip 36                         ; replace red cap with
    dw $C842 : skip 3 : db $9C      ; flashing door cap

    ; Retro PBs portal - Room $9E9F
    org PLMList2RetroPBs
    skip 96                         ; replace enemy kill cap with
    dw $C848 : skip 3 : db $9C      ; flashing door cap

    ; Crabs - Room $948C
    org PLMList1Crabs
    skip 42                         ; replace yellow cap with
    dw $C84E : skip 3 : db $9C      ; flashing door cap
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
    org PLMList1GreenHills
    dw $0002 : skip 4               ; remove the blue gate
    skip 6                          ; overwrite yellow cap with
    dw $C842 : skip 3 : db $9C      ; flashing door cap

    ; n00b bridge - Room $9FBA
    org PLMList1NoobBridge          ; overwrite green cap with
    dw $C842 : skip 3 : db $9C      ; flashing door cap
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
dw $C842 : db $0E,$16 : dw $9CB0  ; flashing door cap (Kraid Entry)
dw $0001,$0000,PLMList1KraidEntry

pushpc
; Red Tower - Room $A253
org PLMList1RedTower
skip 12                                 ; overwrite green cap with
if !AREA == 1
dw $C848 : db $01,$46 : skip 1   : db $9C ; flashing door cap
dw $B76F : db $03,$38 : dw $0005          ; add save station
else
dw $0002 : skip 4                       ; nothing!
endif

if !AREA == 1
    ; Red Elevator - Room $962A
    org PLMList1RedElevator
    skip 6                          ; overwrite yellow cap with
    dw $C854 : skip 3 : db $9C      ; flashing door cap

    ; Maridia Escape - Room $A322
    org PLMList1MaridiaEscape
    skip 30                           ; overwrite green gate with
    dw $C842 : db $2E,$36 : dw $9CB1  ; flashing door cap
endif

; Maridia Tube - Room $CEFB
org PLMList1MaridiaTube
skip 90                                 ; replace pink cap with
if !AREA == 1
dw $C854 : db $06,$02 : skip 1 : db $9C ; flashing door cap
                                        ; NOTE: reusing save room variable
else
dw $0002 : skip 4                       ; nothing! 
endif

if !AREA == 1
    ; Kraid Entry And Above Kraid - Room $CF80
    org RoomState1KraidEntry
    skip 20 : dw CustomPLMs_KraidEntryAndAboveKraid

    org PLMList1KraidEntry
    skip 60                             ; overwrite green gate with
    dw $C842 : db $3E,$06 : dw $9CB2    ; flashing door cap (Above Kraid)
endif

pullpc

;------------------------------------------------------------------------------
; Maridia - West
;------------------------------------------------------------------------------
CustomPLMs_MainStreet:
dw $C84E : db $16,$7D : dw $9CB3  ; flashing door cap
dw $0001,$0000,PLMList1MainStreet ; run the vanilla list

CustomPLMs_CrabTunnel:
dw SaveStationMini_entry : db $07,$0D : dw $0005  ; add save station
dw $0001,$0000,PLMList1CrabTunnel

CustomPLMs_PreAqueduct:
dw $B76F : db $0D,$29 : dw $0004  ; add save station
dw $0001,$0000,PLMList1PreAqueduct

CustomPLMs_RedFish:
dw $C848                 : db $01,$06 : dw $9CB4  ; flashing door cap
dw SaveStationMini_entry : db $8C,$07 : dw $0006  ; save station
dw $0001,$0000,PLMList1RedFish

CustomPLMs_MaridiaMap:
dw $C848 : db $01,$16 : dw $9CB5  ; flashing door cap
dw $0001,$0000,PLMList1MaridiaMap

CustomPLMs_WestSandHallTunnel:
dw $C842,$060E,$1000              ; grey door
dw $0000

CustomPLMs_WestSandHall:
dw $C848 : db $01,$06 : dw $9CB6  ; flashing door cap
dw $0000

pushpc
if !AREA == 1
    ; Main Street - Room $CFC9
    org RoomState1MainStreet
    skip 20 : dw CustomPLMs_MainStreet

    ; Crab Tunnel - Room $D08a
    org RoomState1CrabTunnel
    skip 20 : dw CustomPLMs_CrabTunnel

    ; PreAqueduct - Room $D1A3
    org RoomState1PreAqueduct
    skip 20 : dw CustomPLMs_PreAqueduct

    org PLMList1PreAqueduct
    skip 12                         ; overwrite green cap with
    dw $C842 : skip 3 : db $9C      ; flashing door cap

    ; Red Fish - Room $D104
    org RoomState1RedFish
    skip 20 : dw CustomPLMs_RedFish

    ; Maridia Map - Room $D21C
    org RoomState1MaridiaMap
    skip 20 : dw CustomPLMs_MaridiaMap

    ; West Sand Hall Tunnel - Room $D252
    org RoomState1WestSandHallTunnel
    skip 20 : dw CustomPLMs_WestSandHallTunnel

    ; West Sand Hall - Room $D461
    org RoomState1WestSandHall
    skip 20 : dw CustomPLMs_WestSandHall
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
CustomPLMs_SandFalls:
dw $C842,$063E,$9CB7              ; flashing door cap
dw $0000

pushpc
; Aqueduct - Room $D5A7
org PLMList1Aqueduct                        ; overwrite pink door with
if !AREA == 1
    dw $C848 : db $01,$16 : skip 1 : db $9C ; flashing door cap
                                            ; NOTE: reusing save door variable
else
    dw $0002 : skip 4                       ; nothing!
endif

; Colosseum - Room $D72A
org PLMList1Colosseum   ; overwrite pink door with
dw $0002 : skip 4       ; nothing!

; TODO: Use labels
if !RECALL == 1
    ; Plasma Spark - Room $D340
    org $8FC571
    dw $0002 : skip 4 ; Open Plasma door

    ; Halfie Shaft - Room $D913
    org $8FC773
    skip 36
    dw $0002 : skip 4 ; Door to cac alley

    ; Butterfly Room - Room $D5EC
    org $8FC611 ; Back door to Draygon
    dw $0000    ; Make door blue
    
    ; Highway (Maridia) - Room $95A8
    org PLMList1HighwayElbow
    dw $0000    ; Make door blue
endif

if !AREA == 1
    ; Highway Elbow (Maridia) - Room $95A8
    org PLMList1HighwayElbow
    dw $C842 : db $0E,$06 : skip 1 : db $9C ; flashing door cap
                                            ; NOTE: reusing yellow cap variable

    ; Highway Maridia Elevator - Room $D30B
    org PLMList1HighwayElevator
    skip 6
    dw $0002 : skip 4

    ; Sand Falls - Room $D6FD
    org RoomState1SandFalls
    skip 20 : dw CustomPLMs_SandFalls
endif

; Draygon's Boss Room - Room $DA60
org $8FC7BB
skip 4
dw $809E                ; Set FRONT door as always solid grey so each version
                        ; of the boss room is locked for true boss rando.
skip 4
dw $809F                ; Set BACK door as always solid grey so each version
                        ; of the boss room is locked for true boss rando.

pullpc

;------------------------------------------------------------------------------
; Wrecked Ship
;------------------------------------------------------------------------------
CustomPLMs_Ocean:
dw $C848 : db $01,$46 : dw $9CB8  ; flashing door cap
dw $0001,$0000,PLMList1Ocean

CustomPLMs_HighwayExit:
dw $C848 : db $01,$16 : dw $9CB9  ; flashing door cap
dw $0001,$0000,PLMList1HighwayExit 

pushpc
; Wrecked Ship Save Room - Room $CE8A
org RoomState1WreckedShipSave     ; update asleep room state
skip $14 : dw $C2C9               ; turn on save station

; TODO: Use labels
if !RECALL == 1
    org $8FCC39         ; WS E-tank room header Phantoon alive
    skip $14 : dw $C337 ; Show WS E-tank item

    org $8FCBE7         ; WS back room Phantoon alive
    skip $14 : dw $C323 ; Add missile door back
endif

if !AREA == 1 ; TODO: Do we need this?
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

    ; Wrecked Ship Main Shaft - Room $CAF6
    org PLMList1WSShaft
    skip 42                 ; open the back door
    dw $0002 : skip 4
endif

; Phantoon's Boss Room - Room $CD13
org $8FC2B3
skip 4
dw $8086                ; Set door as always solid grey so each version
                        ; of the boss room is locked for true boss rando.
    
pullpc

;------------------------------------------------------------------------------
; Upper Norfair
;------------------------------------------------------------------------------
CustomPLMs_ElevatorEntryAndKraidMouth:
dw $C848 : db $01,$06 : dw $9CBA  ; flashing door cap (Elevator Entry)
dw $C842 : db $2E,$06 : dw $9CBB  ; flashing door cap (Kraid Mouth)
dw $0001,$0000,PLMList1KraidMouth ; run vanilla list

CustomPLMs_SingleChamber:
dw $C842 : db $5E,$06 : dw $9CBC      ; flashing door cap
dw $0001,$0000,PLMList1SingleChamber  ; run vanilla list

pushpc
if !RECALL == 1
    ; Croc Entry (UN) - Room $A923
    org PLMList1CrocEntry
    skip 72 : dw $0000 ; Make upper Croc door blue
endif

if !AREA == 1
    ; Elevator Entry And Kraid Mouth - Room $A6A1
    org RoomState1ElevatorEntry
    skip 20 : dw CustomPLMs_ElevatorEntryAndKraidMouth

    ; Single Chamber - Room $AD5E
    org RoomState1SingleChamber
    skip 20 : dw CustomPLMs_SingleChamber

    ; Croc Entry (UN) - Room $A923
    org PLMList1CrocEntry
    skip 72                         ; overwrite green door with
    dw $C84E : skip 3 : db $9C      ; flashing door cap

    ; Lava Dive - Room $AE74
    org PLMList1LavaDive
    skip 48                         ; overwrite orange door with
    dw $C848 : skip 3 : db $9C      ; flashing door cap
endif

pullpc

;------------------------------------------------------------------------------
; Crocamire
;------------------------------------------------------------------------------
pushpc
; Croc - Room $A98D
org PLMList1Croc                    ; overwrite boss kill door with
if !AREA == 1
    dw $C854 : skip 3 : db $9C      ; flashing door cap
elseif !RECALL == 1
    dw $0002 : skip 4               ; nothing!
endif

if !RECALL == 1
    ; Croc Green Gate - Room $AB64
    org PLMList1CrocGreenGate
    dw $0002 : skip 4               ; gate always open
endif

pullpc

;------------------------------------------------------------------------------
; Lower Norfair
;------------------------------------------------------------------------------
CustomPLMs_Muskateers:
dw $C848 : db $11,$06 : dw $9CBD  ; flashing door cap
dw $0001,$0000,PLMList1Muskateers ; run vanilla list

CustomPLMs_RidleyMouth:
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

; Ridley's Boss Room - Room $B32E
org $8F8E98
skip 4                  
dw $805A                ; Set FRONT door as always solid grey so each version
                        ; of the boss room is locked for true boss rando.
skip 4
dw $805B                ; Set BACK door as always solid grey so each version
                        ; of the boss room is locked for true boss rando.

pullpc

;------------------------------------------------------------------------------
; Kraid's Lair
;------------------------------------------------------------------------------
CustomPLMs_KraidsLair:
dw $C848 : db $01,$06 : dw $9CBF    ; flashing door cap
dw $0001,$0000,PLMList1KraidsLair   ; run vanilla list

pushpc
if !AREA == 1
    ; Kraid Eye Door Room - Room $A56B
    org PLMList1KraidEyeDoorRoom
    skip 18                         ; overwrite green door with
    dw $0002 : skip 4               ; nothing!

    ; Kraid's Lair - Room $A471
    org RoomState1KraidsLair
    skip 20 : dw CustomPLMs_KraidsLair
endif

; Kraid's Boss Room - Room $A59F
org $8F8A2E
skip 4                  
dw $8046                ; Set BACK door as always solid grey so each version
                        ; of the boss room is locked for true boss rando.
skip 4
dw $8047                ; Set FRONT door as always solid grey so each version
                        ; of the boss room is locked for true boss rando.

pullpc

;------------------------------------------------------------------------------
; Tourian
;------------------------------------------------------------------------------
CustomPLMs_Tourian:
dw $C848 : db $01,$06 : dw $9CC0  ; flashing door cap
dw $0000

pushpc
if !AREA == 1
    ; Tourian - Room $A5ED
    org RoomState1Tourian
    skip 20 : dw CustomPLMs_Tourian
endif

pullpc
