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

;----------------------------------
; Crateria
;----------------------------------
CustomPLMs_Kago:
%CopyBytes($8F8442,0)             ; copy existing list
dw $C848 : db $01,$06 : dw $9CAD  ; flashing door cap
dw $0000

CustomPLMs_Moat:
%CopyBytes($8F8248,6)             ; copy existing list
dw $C842 : db $1E,$06 : dw $9CAE  ; flashing door cap
dw $0000

CustomPLMs_G4:
%CopyBytes($8F844C,36)            ; copy existing list
dw $C842 : db $0E,$66 : dw $9C1E  ; flashing door cap
dw $0000

CustomPLMs_RetroPBs:
%CopyBytes($8F86E6,108)           ; copy existing list
skip -12
dw $C848 : db $01,$26 : dw $9C31  ; flashing door cap
skip 6
dw $0000

CustomPLMs_Crabs:
%CopyBytes($8F81FE,42)            ; copy existing list minus orange door
dw $C84E : db $16,$2D : dw $9C0E  ; flashing door cap
dw $0000

;----------------------------------
; Green Brinstar
;----------------------------------
CustomPLMs_GreenElevator:
%CopyBytes($8F843A,6)             ; copy existing list
dw $C842 : db $0E,$06 : dw $9CAF  ; flashing door cap
dw $0000

CustomPLMs_GreenHills:
%CopyBytes($8F8664+6,18)          ; copy existing minus blue gate
skip -12                          ; rewind to overwrite orange door
dw $C842 : db $1E,$06 : dw $9C30  ; flashing door cap
skip 6                            ; finish with vanilla plm
dw $0000

CustomPLMs_NoobBridge:
dw $C842 : db $5E,$06 : dw $9C33  ; flashing door cap
dw $0000

CustomPLMs_GreenTower:
%CopyBytes($8F848E,36)             ; copy existing minus pink save door
%CopyBytes($8F848E+42,18)          ; copy existing minus pink refill door
%CopyBytes($8F848E+72,6)           ; copy the last of the existing list
dw $0000

;----------------------------------
; Red Brinstar
;----------------------------------
CustomPLMs_RedTower:
%CopyBytes($8F8854,12)            ; copy existing list
%CopyBytes($8F8854+18,6)          ; minus green door
dw $C848 : db $01,$46 : dw $9C38  ; flashing door cap (reusing 38 byte from the green door PLM variable)
dw $0000

CustomPLMs_RedElevator:
%CopyBytes($8F8250,6)             ; copy existing list minus orange door
dw $C854 : db $06,$02 : dw $9C10  ; flashing door cap
dw $0000

CustomPLMs_MaridiaEscape:
%CopyBytes($8F8880,30)            ; copy existing list
%CopyBytes($8F8880+36,24)         ; minus green gate
dw $C842 : db $2E,$36 : dw $9CB0  ; flashing door cap
dw $0000

CustomPLMs_MaridiaTube:
%CopyBytes($8FC37D,90)            ; copy existing minus pink door
dw $C854 : db $06,$02 : dw $9CB1  ; flashing door cap
dw $0000

CustomPLMs_KraidEntryAndAboveKraid:
%CopyBytes($8FC3E1,60)            ; copy existing list
%CopyBytes($8FC3E1+66,6)          ; minus green gate
dw $C842 : db $0E,$16 : dw $9CB2  ; flashing door cap (Kraid Entry)
dw $C842 : db $3E,$06 : dw $9CB3  ; flashing door cap (Above Kraid)
dw $0000

;----------------------------------
; Maridia - West
;----------------------------------
CustomPLMs_MainStreet:
%CopyBytes($8FC42B,24)            ; copy existing list
dw $C84E : db $16,$7D : dw $9CB4  ; flashing door cap
dw $B76F : db $18,$59 : dw $0005  ; add save station
dw $0000

CustomPLMs_PreAqueduct:
%CopyBytes($8FC4EF,18)            ; copy existing list
skip -6                           ; rewind to overwrite green door
dw $C842 : skip 2     : dw $9C8F  ; flashing door cap
dw $B76F : db $0D,$29 : dw $0004  ; add save station
dw $0000

CustomPLMs_RedFish:
%CopyBytes($8FC49B,12)            ; copy existing list
dw $C848 : db $01,$06 : dw $9CB5  ; flashing door cap
dw $0000

CustomPLMs_MaridiaMap:
%CopyBytes($8FC53B,18)            ; copy existing list
dw $C848 : db $01,$16 : dw $9CB6  ; flashing door cap
dw $0000

CustomPLMs_CrabShaft:
%CopyBytes($8FC48B+6,6)            ; copy existing minus green gate
dw $0000

;----------------------------------
; Maridia - East
;----------------------------------
CustomPLMs_Aqueduct:
%CopyBytes($8FC5FD+6,12)          ; copy existing minus pink door
dw $C848 : db $01,$16 : dw $9CB7  ; flashing door cap
dw $0000

CustomPLMs_Highway:
dw $C842 : db $0E,$06 : dw $9C0F  ; flashing door cap
dw $0000

CustomPLMs_Collosseum:
%CopyBytes($8FC6EF+6,12)          ; copy existing minus pink door
dw $0000

CustomPLMs_HighwayElevator:
%CopyBytes($8FC563,6)             ; copy existing minus pink door
dw $0000

;----------------------------------
; Wrecked Ship
;----------------------------------
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

;----------------------------------
; Upper Norfair
;----------------------------------
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

;----------------------------------
; Crocamire
;----------------------------------
CustomPLMs_Croc:
dw $C854 : db $36,$02 : dw $9C4F  ; flashing door cap
%CopyBytes($8F8B9E+6,6)           ; copy existing minus upper door
dw $0000

;----------------------------------
; Lower Norfair
;----------------------------------
CustomPLMs_Muskateers:
%CopyBytes($8F90D0,54)            ; copy existing list
dw $C848 : db $11,$06 : dw $9CBD  ; flashing door cap
dw $0000

CustomPLMs_RidleyMouth:
%CopyBytes($8F8D7E,0)             ; copy existing list (none)
dw $C842 : db $3E,$06 : dw $9CBE  ; flashing door cap
dw $0000

;----------------------------------
; Kraid's Lair
;----------------------------------
CustomPLMs_PreKraidsLair:
%CopyBytes($8F8A02,18)            ; copy existing list minus green door
%CopyBytes($8F8A02+24,18)         ; copy the rest of the existing list
dw $0000

CustomPLMs_KraidsLair:
%CopyBytes($8F8976,30)            ; copy existing list
dw $C848 : db $01,$06 : dw $9CBF  ; flashing door cap
dw $0000

;----------------------------------
; Tourian
;----------------------------------
CustomPLMs_Tourian:
%CopyBytes($8FA83C,0)             ; copy existing list
dw $C848 : db $01,$06 : dw $9CC0  ; flashing door cap
dw $0000
