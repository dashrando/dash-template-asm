;------------------------------------------------------------------------------
; Custom Rooms
;------------------------------------------------------------------------------
; DASH uses custom rooms to support modes like Boss Shift. Most are copies
; of existing rooms with slight tweaks like the area associated with the
; new room. Macros are used when a room is copied more than once.
;------------------------------------------------------------------------------

macro SetupVariaSuit(areaName,areaIndex,roomIndex,variable)
RoomHeaderVariaSuitIn<areaName>:
      ; Room $A6E2: Header
      db $35, $01, $39, $13, $01, $01, $70, $A0, $02
      dw $A709, $E5E6

      ; Room $A6E2, state $A6EF: Header
      dl $C6E355
      db $07, $00, $03
      dw $842A, $9666, $8499, $0000, $0000, $0000, $0000, $8ACA, $0000, $91F4
.doors:
      dw DoorVectorToKraidFromVariaSuitIn<areaName>
.item_plm:
      dw $EF6F       ; Item Value
      db $07,$09     ; Location in room (x,y)
      dw <variable>  ; PLM variable
      dw $0000       ; End
%UpdateRoom(RoomHeaderVariaSuitIn<areaName>,<roomIndex>,<areaIndex>)
%UpdateItem(RoomHeaderVariaSuitIn<areaName>)
endmacro

%SetupVariaSuit(Norfair,     $02,$4E, $00A1)
%SetupVariaSuit(WreckedShip, $03,$11, $00A2)
%SetupVariaSuit(Maridia,     $04,$39, $00A3)

;-------

macro SetupKraid(areaName,areaIndex,roomIndex,exitRoom)
RoomHeaderKraidIn<areaName>:
      ; Room $A59F: Header
      db $2F, $01, $37, $12, $02, $02, $70, $A0, $05
      dw $A5E5, $E629 : db $01 : dw $A5CB, $E5E6

      ; Room $A59F, state $A5B1: Header
      dl $C6D620
      db $1A, $27, $06
      dw $83F4, $9EB5, $85EF, $0101, $A5E9, $0000, $0000, $8A2E, $B815, $91D6

      ; Room $A59F, state $A5CB: Header
      dl $C6D620
      db $1A, $00, $00
      dw $83F4, $9EB5, $85EF, $0101, $A5E9, $0000, $0000, $8A2E, $B840, $91D6
.doors:
DoorFromKraidIn<areaName>:
      dw DoorVectorTo<exitRoom>,DoorVectorToVariaSuitIn<areaName>
%UpdateRoom(RoomHeaderKraidIn<areaName>,<roomIndex>,<areaIndex>)
endmacro

%SetupKraid(Norfair,     $02,$4D, PreRidley)
%SetupKraid(WreckedShip, $03,$10, PrePhantoon)
%SetupKraid(Maridia,     $04,$38, PreDraygon)

;-------

macro SetupPhantoon(areaName,areaIndex,roomIndex,exitRoom)
RoomHeaderPhantoonIn<areaName>:
      ; Room $CD13: Header
      db $0A, $03, $13, $13, $01, $01, $70, $A0, $00
      dw $CD59, $E629 : db $01 : dw $CD3F, $E5E6

      ; Room $CD13, state $CD25: Header
      dl $C4E58C
      db $05, $27, $06
      dw $9C44, $CCD4, $8D1D, $0101, $CD5B, $0000, $0000, $C2B3, $E0FD, $C8D0

      ; Room $CD13, state $CD3F: Header
      dl $C4E58C
      db $04, $00, $03
      dw $9B62, $C1E4, $8C1D, $0101, $CD5B, $0000, $0000, $C2B3, $E113, $C8D0
.doors:
DoorFromPhantoonIn<areaName>:
      dw DoorVectorTo<exitRoom>
%UpdateRoom(RoomHeaderPhantoonIn<areaName>,<roomIndex>,<areaIndex>)
endmacro

%SetupPhantoon(Brinstar, $01,$38, PreKraid)
%SetupPhantoon(Norfair,  $02,$4F, PreRidley)
%SetupPhantoon(Maridia,  $04,$3A, PreDraygon)

;-------

macro SetupSpaceJump(areaName,areaIndex,roomIndex,variable)
RoomHeaderSpaceJumpIn<areaName>:
      ; Room $D9AA: Header
      db $33, $04, $26, $0A, $01, $01, $70, $A0, $00
      dw $D9D1, $E5E6

      ; Room $D9AA, state $D9B7: Header
      dl $CD991E
      db $0C, $00, $03
      dw $9FB4, $D450, $8E54, $0000, $D9D3, $0000, $0000, $C7A7, $0000, $C8DC
.doors:
      dw DoorVectorToDraygonFromSpaceJumpIn<areaName>
.item_plm:
      dw $EF6F       ; Item Value
      db $04,$08     ; Location in room (x,y)
      dw <variable>  ; PLM variable
      dw $0000       ; End
%UpdateRoom(RoomHeaderSpaceJumpIn<areaName>,<roomIndex>,<areaIndex>)
%UpdateItem(RoomHeaderSpaceJumpIn<areaName>)
endmacro

%SetupSpaceJump(Brinstar,    $01,$3A, $00A4)
%SetupSpaceJump(Norfair,     $02,$51, $00A5)
%SetupSpaceJump(WreckedShip, $03,$13, $00A6)

;-------

macro SetupDraygon(areaName,areaIndex,roomIndex,exitRoom)
RoomHeaderDraygonIn<areaName>:
      ; Room $DA60: Header
      db $37, $04, $27, $09, $02, $02, $70, $A0, $01
      dw $DAA6, $E629 : db $01 : dw $DA8C, $E5E6

      ; Room $DA60, state $DA72: Header
      dl $CDB19D
      db $1C, $24, $05
      dw $9FF4, $D314, $8E10, $0101, $DAAA, $0000, $0000, $C7BB, $E108, $C8DD

      ; Room $DA60, state $DA8C: Header
      dl $CDB19D
      db $1C, $00, $03
      dw $9FF4, $8000, $8000, $0101, $DAAA, $0000, $0000, $C7BB, $E113, $C8DD
.doors:
DoorFromDraygonIn<areaName>:
      dw DoorVectorTo<exitRoom>,DoorVectorToSpaceJumpIn<areaName>
%UpdateRoom(RoomHeaderDraygonIn<areaName>,<roomIndex>,<areaIndex>)
endmacro

%SetupDraygon(Brinstar,    $01,$39, PreKraid)
%SetupDraygon(Norfair,     $02,$50, PreRidley)
%SetupDraygon(WreckedShip, $03,$12, PrePhantoon)

;-------

macro SetupRidleyTank(areaName,areaIndex,roomIndex,variable)
RoomHeaderRidleyTankIn<areaName>:
      ; Room $B698: Header
      db $49, $02, $16, $11, $01, $01, $70, $A0, $00
      dw $B6BF, $E5E6

      ; Room $B698, state $B6A5: Header
      dl $C9C30D
      db $09, $00, $00
      dw $88BC, $AEAB, $88F3, $0101, $0000, $0000, $0000, $9108, $BF32, $91F7
.doors:
      dw DoorVectorToRidleyFromTankIn<areaName>
.item_plm:
      dw $EF7F       ; Item Value
      db $0E,$0B     ; Location in room (x,y)
      dw <variable>  ; PLM variable
      dw $0000       ; End
%UpdateRoom(RoomHeaderRidleyTankIn<areaName>,<roomIndex>,<areaIndex>)
%UpdateItem(RoomHeaderRidleyTankIn<areaName>)
endmacro

%SetupRidleyTank(Brinstar,   $01,$3C, $00A7)
%SetupRidleyTank(WreckedShip,$03,$15, $00A8)
%SetupRidleyTank(Maridia,    $04,$3C, $00A9)

;-------

macro SetupRidley(areaName,areaIndex,roomIndex,exitRoom)
RoomHeaderRidleyIn<areaName>:
      ; Room $B32E: Header
      db $3A, $02, $17, $10, $01, $02, $70, $A0, $00
      dw $B374, $E629 : db 01 : dw $B35A, $E5E6

      ; Room $B32E, state $B340: Header
      dl $C8EBFD
      db $09, $24, $04
      dw $87BC, $A626, $8781, $C101, $B378, $0000, $E950, $8E98, $BF32, $91F7

      ; Room $B32E, state $B35A: Header
      dl $C8EBFD
      db $09, $00, $03
      dw $87BC, $A626, $8781, $C101, $B378, $0000, $E950, $8E98, $BF32, $91F7
.doors:
      dw DoorVectorToRidleyTankIn<areaName>
DoorFromRidleyIn<areaName>:
      dw DoorVectorTo<exitRoom>
%UpdateRoom(RoomHeaderRidleyIn<areaName>,<roomIndex>,<areaIndex>)
endmacro

%SetupRidley(Brinstar,    $01,$3B, PreKraid)
%SetupRidley(WreckedShip, $03,$14, PrePhantoon)
%SetupRidley(Maridia,     $04,$3B, PreDraygon)