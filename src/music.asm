;------------------------------------------------------------------------------
; Fix music for area portals
;------------------------------------------------------------------------------
if !AREA == 1
pushpc

org RoomState1Kago
skip 4 : db $09,$05

org RoomState1G4
skip 4 : db $09,$05

org RoomState1RidleyMouth
skip 4 : db $15,$05

org RoomState1Moat
skip 4 : db $0C,$05

org RoomState1Crabs
skip 4 : db $0C,$05

org RoomState1HighwayExit
skip 4 : db $0C,$05

org RoomState1KraidsLair
skip 4 : db $12,$05

org RoomState2Croc
skip 4 : db $15,$05

org RoomState1LavaDive
skip 4 : db $15,$05

pullpc
endif