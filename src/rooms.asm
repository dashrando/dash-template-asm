;------------------------------------------------------------------------------
; Custom Rooms
;------------------------------------------------------------------------------

macro SetupVariaSuit(areaName,areaIndex,roomIndex,variable)
RoomHeaderVariaSuitIn<areaName>:
      %CopyBytes($8FA6E2,$8FA709)
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
      %CopyBytes($8FA59F,$8FA5E5)
.doors:
      dw DoorVectorTeleportTo<exitRoom>,DoorVectorToVariaSuitIn<areaName>
%UpdateRoom(RoomHeaderKraidIn<areaName>,<roomIndex>,<areaIndex>)
endmacro

%SetupKraid(Norfair,     $02,$4D, PreRidley)
%SetupKraid(WreckedShip, $03,$10, PrePhantoon)
%SetupKraid(Maridia,     $04,$38, PreDraygon)

;-------

macro SetupPhantoon(areaName,areaIndex,roomIndex,exitRoom)
RoomHeaderPhantoonIn<areaName>:
      %CopyBytes($8FCD13,$8FCD59)
.doors:
      dw DoorVectorTeleportTo<exitRoom>
%UpdateRoom(RoomHeaderPhantoonIn<areaName>,<roomIndex>,<areaIndex>)
endmacro

%SetupPhantoon(Brinstar, $01,$38, PreKraid)
%SetupPhantoon(Norfair,  $02,$4F, PreRidley)
%SetupPhantoon(Maridia,  $04,$3A, PreDraygon)

;-------

macro SetupSpaceJump(areaName,areaIndex,roomIndex,variable)
RoomHeaderSpaceJumpIn<areaName>:
      %CopyBytes($8FD9AA,$8FD9D1)
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

%SetupSpaceJump(Brinstar,    $01,$13, $00A4)
%SetupSpaceJump(Norfair,     $02,$51, $00A5)
%SetupSpaceJump(WreckedShip, $03,$13, $00A6)

;-------

macro SetupDraygon(areaName,areaIndex,roomIndex,exitRoom)
RoomHeaderDraygonIn<areaName>:
      %CopyBytes($8FDA60,$8FDAA6)
.doors:
      dw DoorVectorTeleportTo<exitRoom>,DoorVectorToSpaceJumpIn<areaName>
%UpdateRoom(RoomHeaderDraygonIn<areaName>,<roomIndex>,<areaIndex>)
endmacro

%SetupDraygon(Brinstar,    $01,$39, PreKraid)
%SetupDraygon(Norfair,     $02,$50, PreRidley)
%SetupDraygon(WreckedShip, $03,$12, PrePhantoon)

;-------

macro SetupRidleyTank(areaName,areaIndex,roomIndex,variable)
RoomHeaderRidleyTankIn<areaName>:
      %CopyBytes($8FB698,$8FB6BF)
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
      %CopyBytes($8FB32E,$8FB374)
.doors:
      dw DoorVectorToRidleyTankIn<areaName>,DoorVectorTeleportTo<exitRoom>
%UpdateRoom(RoomHeaderRidleyIn<areaName>,<roomIndex>,<areaIndex>)
endmacro

%SetupRidley(Brinstar,    $01,$3B, PreKraid)
%SetupRidley(WreckedShip, $03,$14, PrePhantoon)
%SetupRidley(Maridia,     $04,$3B, PreDraygon)