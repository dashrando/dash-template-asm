;------------------------------------------------------------------------------
; Room Tables
;------------------------------------------------------------------------------
; Column-major room tables organized first by vanilla area index then room index.
; Each vanilla area has three fields: sub_areas (byte), room_flags (byte), and
; room_patches (word.) 
;------------------------------------------------------------------------------

if !RECALL == 1
   !WS_Reserve_Patch = Room_WreckedShipReserve_Patch_02
   !Plasma_Patch = Room_Plasma_Patch_01
   !Pants_Room_Patch = Room_PreShaktool_Patch_01
   !Shaktool_Patch = Room_Shaktool_Patch_01
else
   !WS_Reserve_Patch = NoPatch
   !Plasma_Patch = NoPatch
   !Pants_Room_Patch = NoPatch
   !Shaktool_Patch = NoPatch
endif

if !AREA == 1
   !Aqueduct_Patch = Room_Aqueduct_Patch_01
   !CrabTunnel_Patch = Room_CrabTunnel_Patch_01
   !EastTunnel_Patch = Room_EastTunnel_Patch_01
   !GreenHills_Patch = Room_GreenHills_Patch_01
   !RedElevator_Patch = Room_RedBrinstarElevator_Patch_01
   !SingleChamber_Patch = Room_SingleChamber_Patch_02
   !WS_Exit_Patch = Room_WreckedShipBackExit_Patch_01
else
   !Aqueduct_Patch = NoPatch
   !CrabTunnel_Patch = NoPatch
   !EastTunnel_Patch = NoPatch
   !GreenHills_Patch = NoPatch
   !RedElevator_Patch = NoPatch
   !SingleChamber_Patch = NoPatch
   !WS_Exit_Patch = NoPatch
endif

; Creates column-major table named <area>Rooms:
%AreaRoomTable(Crateria, $33)
%AreaRoomTable(Brinstar, $37)
%AreaRoomTable(Norfair, $4C)
%AreaRoomTable(WreckedShip, $11)
%AreaRoomTable(Maridia, $37)
%AreaRoomTable(Tourian, $12)

;------------------------------------------------------------------------------
; room_flags: - - q - - - - -
; q = Enable Pressure Valve
;------------------------------------------------------------------------------

; Crateria
;          Area      index  sub_areas      room_flags  room_patches
%RoomEntry(Crateria, $00,  !Area_Crateria,      $00,  NoPatch) ; Landing Site
%RoomEntry(Crateria, $01,  !Area_Crateria,      $00,  NoPatch) ; Gauntlet Front
%RoomEntry(Crateria, $02,  !Area_Crateria,      $00,  NoPatch) ; Parlor
%RoomEntry(Crateria, $03,  !Area_Crateria,      $00,  NoPatch) ; Landing Site PBs
%RoomEntry(Crateria, $04,  !Area_Crateria,      $00,  NoPatch) ; Parlor Save
%RoomEntry(Crateria, $05,  !Area_WreckedShip,   $20,  NoPatch) ; Wrecked Ship Front
%RoomEntry(Crateria, $06,  !Area_WreckedShip,   $20,  NoPatch) ; Pre-Bowling Pancake Room
%RoomEntry(Crateria, $07,  !Area_Crateria,      $00,  NoPatch) ; Right Side Junction
%RoomEntry(Crateria, $08,  !Area_EastMaridia,   $00,  NoPatch) ; Maridia Elevator Top
%RoomEntry(Crateria, $09,  !Area_WreckedShip,   $20,  !WS_Exit_Patch) ; Wrecked Ship Back Exit
%RoomEntry(Crateria, $0A,  !Area_WreckedShip,   $00,  NoPatch) ; Wrecked Ship Back Tunnel
%RoomEntry(Crateria, $0B,  !Area_WreckedShip,   $20,  NoPatch) ; Wrecked Ship Back Maze
%RoomEntry(Crateria, $0C,  !Area_EastMaridia,   $00,  NoPatch) ; East Maridia Back Corner
%RoomEntry(Crateria, $0D,  !Area_Crateria,      $20,  NoPatch) ; Tunnel Right of Ship
%RoomEntry(Crateria, $0E,  !Area_Crateria,      $20,  Room_Moat_Patch_01) ; Moat
%RoomEntry(Crateria, $0F,  !Area_RedBrinstar,   $00,  NoPatch) ; Red Brinstar Elevator
%RoomEntry(Crateria, $10,  !Area_Crateria,      $00,  NoPatch) ; Gauntlet E-Tank
%RoomEntry(Crateria, $11,  !Area_WreckedShip,   $00,  NoPatch) ; Lonely Crab
%RoomEntry(Crateria, $12,  !Area_Crateria,      $00,  NoPatch) ; Climb
%RoomEntry(Crateria, $13,  !Area_Crateria,      $00,  NoPatch) ; Old Tourian
%RoomEntry(Crateria, $14,  !Area_Crateria,      $00,  NoPatch) ; Blue Brinstar Elevator
%RoomEntry(Crateria, $15,  !Area_Crateria,      $00,  NoPatch) ; Bomb Torizo
%RoomEntry(Crateria, $16,  !Area_Crateria,      $00,  NoPatch) ; Bomb Torizo Hallway
%RoomEntry(Crateria, $17,  !Area_Crateria,      $00,  NoPatch) ; Crateria Map Hallway
%RoomEntry(Crateria, $18,  !Area_Crateria,      $00,  NoPatch) ; Terminator
%RoomEntry(Crateria, $19,  !Area_GreenBrinstar, $00,  NoPatch) ; Green Brinstar Elevator Top
%RoomEntry(Crateria, $1A,  !Area_Crateria,      $00,  NoPatch) ; Mushroom Room
%RoomEntry(Crateria, $1B,  !Area_Crateria,      $00,  NoPatch) ; Crateria Map
%RoomEntry(Crateria, $1C,  !Area_Crateria,      $00,  NoPatch) ; Gauntlet Missiles
%RoomEntry(Crateria, $1D,  !Area_Crateria,      $00,  NoPatch) ; Climb Supers
%RoomEntry(Crateria, $1E,  !Area_Crateria,      $00,  NoPatch) ; 230 Missiles Tunnel
%RoomEntry(Crateria, $1F,  !Area_Crateria,      $00,  NoPatch) ; 230 Missiles
%RoomEntry(Crateria, $30,  !Area_Tourian,       $00,  NoPatch) ; Tourian Hallway
%RoomEntry(Crateria, $33,  !Area_Tourian,       $20,  NoPatch) ; Tourian Elevator Top

; Brinstar
;          Area      index  sub_areas      room_flags  room_patches
%RoomEntry(Brinstar, $00,  !Area_GreenBrinstar, $00,  NoPatch) ; Green Shaft
%RoomEntry(Brinstar, $01,  !Area_GreenBrinstar, $00,  NoPatch) ; Big Pink Supers
%RoomEntry(Brinstar, $02,  !Area_GreenBrinstar, $00,  NoPatch) ; Map Hallway
%RoomEntry(Brinstar, $03,  !Area_GreenBrinstar, $00,  Room_Early_Supers_Patch_01) ; Early Supers
%RoomEntry(Brinstar, $04,  !Area_GreenBrinstar, $00,  NoPatch) ; Green Brinstar Reserve
%RoomEntry(Brinstar, $05,  !Area_GreenBrinstar, $00,  NoPatch) ; Green Brinstar Map
%RoomEntry(Brinstar, $06,  !Area_GreenBrinstar, $00,  NoPatch) ; Green Brinstar Pre Refill
%RoomEntry(Brinstar, $07,  !Area_GreenBrinstar, $00,  NoPatch) ; Green Brinstar Refill
%RoomEntry(Brinstar, $08,  !Area_GreenBrinstar, $00,  Room_Dachora_Patch_01) ; Dachora
%RoomEntry(Brinstar, $09,  !Area_GreenBrinstar, $00,  Room_BigPink_Patch_01) ; Big Pink
%RoomEntry(Brinstar, $0A,  !Area_GreenBrinstar, $00,  NoPatch) ; Pre Spore Spawn
%RoomEntry(Brinstar, $0B,  !Area_GreenBrinstar, $00,  NoPatch) ; Spore Spawn
%RoomEntry(Brinstar, $0C,  !Area_GreenBrinstar, $00,  Room_MissionImpossible_Patch_01) ; Mission Impossible
%RoomEntry(Brinstar, $0D,  !Area_GreenBrinstar, $00,  !GreenHills_Patch) ; Green Hills
%RoomEntry(Brinstar, $0E,  !Area_Crateria,      $00,  NoPatch) ; Morph Ball Room
%RoomEntry(Brinstar, $0F,  !Area_Crateria,      $00,  NoPatch) ; Construction Zone
%RoomEntry(Brinstar, $10,  !Area_Crateria,      $00,  NoPatch) ; Ceiling E-Tank
%RoomEntry(Brinstar, $11,  !Area_GreenBrinstar, $00,  NoPatch) ; Falling Bridge
%RoomEntry(Brinstar, $12,  !Area_GreenBrinstar, $00,  NoPatch) ; Etecoons Frog Room
%RoomEntry(Brinstar, $13,  !Area_GreenBrinstar, $00,  NoPatch) ; Etecoons E-Tank
%RoomEntry(Brinstar, $14,  !Area_GreenBrinstar, $00,  NoPatch) ; Etecoons Supers
%RoomEntry(Brinstar, $15,  !Area_GreenBrinstar, $00,  NoPatch) ; Dachora Refill
%RoomEntry(Brinstar, $16,  !Area_GreenBrinstar, $00,  NoPatch) ; Big Pink Supers Hallway
%RoomEntry(Brinstar, $17,  !Area_GreenBrinstar, $20,  Room_Waterway_Patch_01) ; Waterway
%RoomEntry(Brinstar, $18,  !Area_Crateria,      $20,  NoPatch) ; Blue Brinstar Missiles
%RoomEntry(Brinstar, $19,  !Area_GreenBrinstar, $20,  NoPatch) ; Big Pink Wave Gate
%RoomEntry(Brinstar, $1A,  !Area_GreenBrinstar, $20,  NoPatch) ; Big Pink E-tank
%RoomEntry(Brinstar, $1B,  !Area_GreenBrinstar, $00,  NoPatch) ; Big Pink Save
%RoomEntry(Brinstar, $1C,  !Area_Crateria,      $20,  NoPatch) ; Blue Brinstar Spike Bridge
%RoomEntry(Brinstar, $1D,  !Area_Crateria,      $00,  NoPatch) ; Billy Mays
%RoomEntry(Brinstar, $1E,  !Area_GreenBrinstar, $00,  NoPatch) ; Green Shaft Save
%RoomEntry(Brinstar, $1F,  !Area_GreenBrinstar, $00,  NoPatch) ; Etecoons Save
%RoomEntry(Brinstar, $20,  !Area_RedBrinstar,   $00,  Room_RedTower_Patch_01) ; Red Tower
%RoomEntry(Brinstar, $21,  !Area_RedBrinstar,   $00,  NoPatch) ; Pre X-Ray
%RoomEntry(Brinstar, $22,  !Area_RedBrinstar,   $00,  NoPatch) ; X-Ray
%RoomEntry(Brinstar, $23,  !Area_RedBrinstar,   $00,  NoPatch) ; Red Tower Spike Hallway
%RoomEntry(Brinstar, $24,  !Area_RedBrinstar,   $00,  !RedElevator_Patch) ; Red Tower Upper Right
%RoomEntry(Brinstar, $25,  !Area_RedBrinstar,   $00,  NoPatch) ; Red Tower PBs Upper
%RoomEntry(Brinstar, $26,  !Area_RedBrinstar,   $00,  NoPatch) ; Red Tower PBs Lower
%RoomEntry(Brinstar, $27,  !Area_RedBrinstar,   $20,  NoPatch) ; Red Brinstar Bottom Left
%RoomEntry(Brinstar, $28,  !Area_RedBrinstar,   $20,  Room_PreSpazer_Patch_01) ; Red Brinstar Bottom Right
%RoomEntry(Brinstar, $29,  !Area_RedBrinstar,   $20,  NoPatch) ; Spazer
%RoomEntry(Brinstar, $2A,  !Area_Kraid,         $00,  NoPatch) ; Kraid Entry
%RoomEntry(Brinstar, $2B,  !Area_Kraid,         $00,  NoPatch) ; Kraid E-Tank
%RoomEntry(Brinstar, $2C,  !Area_Kraid,         $00,  Room_KraidMissiles_Patch_01) ; Kraid Missiles
%RoomEntry(Brinstar, $2D,  !Area_Kraid,         $00,  NoPatch) ; Kraid Hallway
%RoomEntry(Brinstar, $2E,  !Area_Kraid,         $00,  NoPatch) ; Pre Kraid
%RoomEntry(Brinstar, $2F,  !Area_Kraid,         $00,  NoPatch) ; Kraid
%RoomEntry(Brinstar, $31,  !Area_RedBrinstar,   $00,  NoPatch) ; Red Tower Refill
%RoomEntry(Brinstar, $32,  !Area_Kraid,         $00,  NoPatch) ; Kraid Refill
%RoomEntry(Brinstar, $34,  !Area_UpperNorfair,  $00,  NoPatch) ; Upper Norfair Elevator
%RoomEntry(Brinstar, $35,  !Area_Kraid,         $00,  NoPatch) ; Varia Suit
%RoomEntry(Brinstar, $36,  !Area_Kraid,         $00,  NoPatch) ; Kraid Save
%RoomEntry(Brinstar, $37,  !Area_RedBrinstar,   $00,  NoPatch) ; Red Tower Save

; Norfair
;          Area      index  sub_areas      room_flags  room_patches
%RoomEntry(Norfair, $00,  !Area_UpperNorfair,  $00,  NoPatch) ; Ice Moving Platforms
%RoomEntry(Norfair, $01,  !Area_UpperNorfair,  $00,  NoPatch) ; Cathedral
%RoomEntry(Norfair, $02,  !Area_UpperNorfair,  $00,  Room_FirstHeated_Patch_01) ; Cathedral Entrance
%RoomEntry(Norfair, $03,  !Area_UpperNorfair,  $00,  NoPatch) ; Business Center
%RoomEntry(Norfair, $04,  !Area_UpperNorfair,  $00,  NoPatch) ; Ice Shutter
%RoomEntry(Norfair, $05,  !Area_UpperNorfair,  $00,  NoPatch) ; Ice Forgotten Highway
%RoomEntry(Norfair, $06,  !Area_UpperNorfair,  $00,  NoPatch) ; Ice Beam
%RoomEntry(Norfair, $07,  !Area_UpperNorfair,  $00,  NoPatch) ; Ice Faces
%RoomEntry(Norfair, $08,  !Area_UpperNorfair,  $00,  NoPatch) ; Crumble Shaft
%RoomEntry(Norfair, $09,  !Area_UpperNorfair,  $00,  NoPatch) ; West Speedway
%RoomEntry(Norfair, $0A,  !Area_Crocomire,     $00,  NoPatch) ; Croc
%RoomEntry(Norfair, $0B,  !Area_UpperNorfair,  $00,  NoPatch) ; Hi Jump
%RoomEntry(Norfair, $0C,  !Area_UpperNorfair,  $00,  NoPatch) ; Croc Escape
%RoomEntry(Norfair, $0D,  !Area_UpperNorfair,  $00,  Room_PreHiJump_Patch_01) ; Hi Jump E-Tank
%RoomEntry(Norfair, $0E,  !Area_Crocomire,     $00,  NoPatch) ; Grapple Lobby
%RoomEntry(Norfair, $0F,  !Area_Crocomire,     $00,  NoPatch) ; Grapple Save
%RoomEntry(Norfair, $10,  !Area_Crocomire,     $00,  NoPatch) ; Grapple PBs
%RoomEntry(Norfair, $11,  !Area_Crocomire,     $00,  NoPatch) ; Grapple Shaft
%RoomEntry(Norfair, $12,  !Area_Crocomire,     $00,  NoPatch) ; Grapple Missiles
%RoomEntry(Norfair, $13,  !Area_Crocomire,     $20,  NoPatch) ; Grapple Escape Right
%RoomEntry(Norfair, $14,  !Area_Crocomire,     $00,  NoPatch) ; Grapple Big Room
%RoomEntry(Norfair, $15,  !Area_Crocomire,     $00,  NoPatch) ; Grapple Escape Middle
%RoomEntry(Norfair, $16,  !Area_Crocomire,     $20,  NoPatch) ; Grapple Escape Left
%RoomEntry(Norfair, $17,  !Area_Crocomire,     $00,  NoPatch) ; Grapple Beam
%RoomEntry(Norfair, $18,  !Area_UpperNorfair,  $00,  NoPatch) ; Norfair Reserve
%RoomEntry(Norfair, $19,  !Area_UpperNorfair,  $00,  NoPatch) ; Pre Reserve
%RoomEntry(Norfair, $1A,  !Area_UpperNorfair,  $00,  NoPatch) ; Bubble Mountain
%RoomEntry(Norfair, $1B,  !Area_UpperNorfair,  $00,  NoPatch) ; Speed Speedway
%RoomEntry(Norfair, $1C,  !Area_UpperNorfair,  $00,  NoPatch) ; Speed Booster
%RoomEntry(Norfair, $1D,  !Area_UpperNorfair,  $00,  !SingleChamber_Patch) ; Wave Hallway
%RoomEntry(Norfair, $1E,  !Area_UpperNorfair,  $00,  NoPatch) ; Wave Missiles
%RoomEntry(Norfair, $1F,  !Area_UpperNorfair,  $00,  NoPatch) ; Wave Beam
%RoomEntry(Norfair, $20,  !Area_UpperNorfair,  $00,  NoPatch) ; East Spike Lava Room
%RoomEntry(Norfair, $21,  !Area_UpperNorfair,  $00,  NoPatch) ; East of East Spike Lava Room
%RoomEntry(Norfair, $22,  !Area_UpperNorfair,  $00,  NoPatch) ; Pre Lava Dive
%RoomEntry(Norfair, $23,  !Area_UpperNorfair,  $00,  NoPatch) ; Lava Guy Hallway
%RoomEntry(Norfair, $24,  !Area_UpperNorfair,  $00,  NoPatch) ; Purple Shaft
%RoomEntry(Norfair, $25,  !Area_LowerNorfair,  $00,  NoPatch) ; Lava Dive
%RoomEntry(Norfair, $26,  !Area_LowerNorfair,  $00,  NoPatch) ; LN Elevator Top
%RoomEntry(Norfair, $27,  !Area_UpperNorfair,  $00,  NoPatch) ; Bubble Mountain Junction
%RoomEntry(Norfair, $28,  !Area_UpperNorfair,  $00,  NoPatch) ; Rising Tide
%RoomEntry(Norfair, $29,  !Area_UpperNorfair,  $00,  NoPatch) ; Upper Norfair Bottom Junction
%RoomEntry(Norfair, $2A,  !Area_UpperNorfair,  $00,  NoPatch) ; Grapple Lava Spike Room
%RoomEntry(Norfair, $2B,  !Area_UpperNorfair,  $00,  NoPatch) ; Upper Norfair Refill
%RoomEntry(Norfair, $2C,  !Area_UpperNorfair,  $00,  NoPatch) ; Purple Shaft Farm
%RoomEntry(Norfair, $2D,  !Area_UpperNorfair,  $00,  NoPatch) ; Speed Alcove
%RoomEntry(Norfair, $2E,  !Area_UpperNorfair,  $00,  NoPatch) ; Upper Norfair Map
%RoomEntry(Norfair, $2F,  !Area_UpperNorfair,  $00,  NoPatch) ; Bubble Mountain Save
%RoomEntry(Norfair, $30,  !Area_UpperNorfair,  $00,  NoPatch) ; Frog Speedway
%RoomEntry(Norfair, $31,  !Area_UpperNorfair,  $00,  NoPatch) ; Upper Norfair Pirate Shaft
%RoomEntry(Norfair, $32,  !Area_UpperNorfair,  $00,  NoPatch) ; Tunnel Save
%RoomEntry(Norfair, $33,  !Area_UpperNorfair,  $00,  NoPatch) ; Croc Save
%RoomEntry(Norfair, $34,  !Area_LowerNorfair,  $00,  NoPatch) ; LN Elevator Save
%RoomEntry(Norfair, $35,  !Area_LowerNorfair,  $00,  NoPatch) ; Acid Statue
%RoomEntry(Norfair, $36,  !Area_LowerNorfair,  $00,  NoPatch) ; LN Elevator Bottom
%RoomEntry(Norfair, $37,  !Area_LowerNorfair,  $00,  NoPatch) ; Gold Torizo
%RoomEntry(Norfair, $38,  !Area_LowerNorfair,  $00,  NoPatch) ; Gold Torizo Gate
%RoomEntry(Norfair, $39,  !Area_LowerNorfair,  $00,  NoPatch) ; Gold Torizo Refill
%RoomEntry(Norfair, $3A,  !Area_LowerNorfair,  $00,  NoPatch) ; Ridley
%RoomEntry(Norfair, $3B,  !Area_LowerNorfair,  $00,  NoPatch) ; Pre Ridley
%RoomEntry(Norfair, $3C,  !Area_LowerNorfair,  $00,  NoPatch) ; Pirate Shaft
%RoomEntry(Norfair, $3E,  !Area_LowerNorfair,  $00,  NoPatch) ; Mickey Mouse
%RoomEntry(Norfair, $3F,  !Area_LowerNorfair,  $00,  NoPatch) ; Pillars
%RoomEntry(Norfair, $40,  !Area_LowerNorfair,  $00,  NoPatch) ; Plowerhouse
%RoomEntry(Norfair, $41,  !Area_LowerNorfair,  $00,  NoPatch) ; Worst Room
%RoomEntry(Norfair, $42,  !Area_LowerNorfair,  $00,  NoPatch) ; Ampitheater
%RoomEntry(Norfair, $43,  !Area_LowerNorfair,  $00,  NoPatch) ; Hotarubi Missiles
%RoomEntry(Norfair, $44,  !Area_LowerNorfair,  $00,  NoPatch) ; Escape PBs
%RoomEntry(Norfair, $45,  !Area_LowerNorfair,  $00,  NoPatch) ; Kihunter Shaft
%RoomEntry(Norfair, $46,  !Area_LowerNorfair,  $00,  NoPatch) ; Wasteland
%RoomEntry(Norfair, $47,  !Area_LowerNorfair,  $00,  NoPatch) ; Metal Pirates
%RoomEntry(Norfair, $48,  !Area_LowerNorfair,  $00,  NoPatch) ; Three Musketeers
%RoomEntry(Norfair, $49,  !Area_LowerNorfair,  $00,  NoPatch) ; Ridley E-Tank
%RoomEntry(Norfair, $4A,  !Area_LowerNorfair,  $00,  NoPatch) ; Screw Attack
%RoomEntry(Norfair, $4B,  !Area_LowerNorfair,  $00,  NoPatch) ; Firefleas
%RoomEntry(Norfair, $4C,  !Area_LowerNorfair,  $00,  NoPatch) ; Ridley Save

; Wrecked Ship
;          Area       index     sub_areas      room_flags  room_patches
%RoomEntry(WreckedShip, $00,  !Area_WreckedShip,  $00,  !WS_Reserve_Patch) ; Wrecked Ship Reserve
%RoomEntry(WreckedShip, $01,  !Area_WreckedShip,  $00,  NoPatch) ; Front Conveyor Belt
%RoomEntry(WreckedShip, $02,  !Area_WreckedShip,  $00,  NoPatch) ; Attic
%RoomEntry(WreckedShip, $03,  !Area_WreckedShip,  $00,  NoPatch) ; Attic Missiles
%RoomEntry(WreckedShip, $04,  !Area_WreckedShip,  $20,  NoPatch) ; Wrecked Ship Main
%RoomEntry(WreckedShip, $05,  !Area_WreckedShip,  $20,  NoPatch) ; Spiky Room
%RoomEntry(WreckedShip, $06,  !Area_WreckedShip,  $20,  NoPatch) ; Back Hall
%RoomEntry(WreckedShip, $07,  !Area_WreckedShip,  $20,  NoPatch) ; Wrecked Ship E-Tank
%RoomEntry(WreckedShip, $08,  !Area_WreckedShip,  $00,  NoPatch) ; Wrecked Ship Bottom
%RoomEntry(WreckedShip, $09,  !Area_WreckedShip,  $00,  NoPatch) ; Wrecked Ship Map
%RoomEntry(WreckedShip, $0A,  !Area_WreckedShip,  $00,  NoPatch) ; Wrecked Ship Phantoon
%RoomEntry(WreckedShip, $0B,  !Area_WreckedShip,  $20,  NoPatch) ; Sponge Bath
%RoomEntry(WreckedShip, $0C,  !Area_WreckedShip,  $00,  NoPatch) ; Wrecked Ship Left Supers
%RoomEntry(WreckedShip, $0D,  !Area_WreckedShip,  $00,  NoPatch) ; Wrecked Ship Right Supers
%RoomEntry(WreckedShip, $0E,  !Area_WreckedShip,  $00,  NoPatch) ; Gravity Suit
%RoomEntry(WreckedShip, $0F,  !Area_WreckedShip,  $00,  NoPatch) ; Wrecked Ship Save

; Maridia
;          Area    index     sub_areas      room_flags  room_patches
%RoomEntry(Maridia, $00,  !Area_RedBrinstar,  $20,  NoPatch) ; Tube Save
%RoomEntry(Maridia, $01,  !Area_RedBrinstar,  $20,  NoPatch) ; Glass Tube
%RoomEntry(Maridia, $02,  !Area_RedBrinstar,  $20,  NoPatch) ; Red Brinstar Tunnel Left
%RoomEntry(Maridia, $03,  !Area_RedBrinstar,  $20,  !EastTunnel_Patch) ; Red Brinstar Tunnel Right
%RoomEntry(Maridia, $04,  !Area_WestMaridia,  $20,  NoPatch) ; Main Street
%RoomEntry(Maridia, $05,  !Area_WestMaridia,  $20,  NoPatch) ; Fish Tank
%RoomEntry(Maridia, $06,  !Area_WestMaridia,  $20,  NoPatch) ; Mama Turtle
%RoomEntry(Maridia, $07,  !Area_WestMaridia,  $20,  !CrabTunnel_Patch) ; Crab Tunnel
%RoomEntry(Maridia, $08,  !Area_WestMaridia,  $20,  NoPatch) ; Everest
%RoomEntry(Maridia, $09,  !Area_WestMaridia,  $20,  NoPatch) ; Lonely Fish
%RoomEntry(Maridia, $0A,  !Area_WestMaridia,  $20,  NoPatch) ; Watering Hole
%RoomEntry(Maridia, $0B,  !Area_WestMaridia,  $20,  NoPatch) ; Bug Room
%RoomEntry(Maridia, $0C,  !Area_WestMaridia,  $20,  NoPatch) ; Crab Shaft
%RoomEntry(Maridia, $0D,  !Area_WestMaridia,  $20,  NoPatch) ; Beach
%RoomEntry(Maridia, $0E,  !Area_WestMaridia,  $20,  NoPatch) ; Broken Tube
%RoomEntry(Maridia, $0F,  !Area_EastMaridia,  $20,  NoPatch) ; Crab Room
%RoomEntry(Maridia, $10,  !Area_EastMaridia,  $00,  NoPatch) ; Plasma Tunnel
%RoomEntry(Maridia, $11,  !Area_EastMaridia,  $01,  !Plasma_Patch) ; Plasma Beam
%RoomEntry(Maridia, $12,  !Area_EastMaridia,  $20,  NoPatch) ; Thread Needle
%RoomEntry(Maridia, $13,  !Area_EastMaridia,  $20,  NoPatch) ; Maridia Elevator Bottom
%RoomEntry(Maridia, $14,  !Area_EastMaridia,  $20,  NoPatch) ; Plasma Spark
%RoomEntry(Maridia, $15,  !Area_EastMaridia,  $20,  NoPatch) ; Plasma Shaft
%RoomEntry(Maridia, $16,  !Area_WestMaridia,  $20,  NoPatch) ; Maridia Map
%RoomEntry(Maridia, $17,  !Area_EastMaridia,  $20,  NoPatch) ; Maridia Elevator Save
%RoomEntry(Maridia, $18,  !Area_EastMaridia,  $20,  NoPatch) ; Big Tube
%RoomEntry(Maridia, $19,  !Area_EastMaridia,  $20,  NoPatch) ; Bug Sand Hole
%RoomEntry(Maridia, $1A,  !Area_EastMaridia,  $20,  NoPatch) ; Sand Hall West
%RoomEntry(Maridia, $1B,  !Area_EastMaridia,  $20,  NoPatch) ; Big Tube Bottom
%RoomEntry(Maridia, $1C,  !Area_EastMaridia,  $20,  NoPatch) ; Sand Hall East
%RoomEntry(Maridia, $1D,  !Area_EastMaridia,  $00,  NoPatch) ; Left Sand Pit
%RoomEntry(Maridia, $1E,  !Area_EastMaridia,  $00,  NoPatch) ; Right Sand Pit
%RoomEntry(Maridia, $1F,  !Area_EastMaridia,  $00,  NoPatch) ; Aqueduct Quicksand Left
%RoomEntry(Maridia, $20,  !Area_EastMaridia,  $00,  NoPatch) ; Aqueduct Quicksand Right
%RoomEntry(Maridia, $21,  !Area_EastMaridia,  $00,  !Aqueduct_Patch) ; Aqueduct
%RoomEntry(Maridia, $22,  !Area_EastMaridia,  $20,  NoPatch) ; Butterfly
%RoomEntry(Maridia, $23,  !Area_EastMaridia,  $00,  Room_PreBotwoon_Patch_01) ; Pre Botwoon
%RoomEntry(Maridia, $24,  !Area_EastMaridia,  $20,  !Pants_Room_Patch) ; Pants Room 1
%RoomEntry(Maridia, $25,  !Area_EastMaridia,  $20,  !Pants_Room_Patch) ; Pants Room 2
%RoomEntry(Maridia, $26,  !Area_EastMaridia,  $20,  NoPatch) ; Spring Ball
%RoomEntry(Maridia, $27,  !Area_EastMaridia,  $00,  NoPatch) ; Aqueduct East Landing
%RoomEntry(Maridia, $28,  !Area_EastMaridia,  $00,  NoPatch) ; Coliseum
%RoomEntry(Maridia, $29,  !Area_EastMaridia,  $00,  NoPatch) ; Aqueduct Save
%RoomEntry(Maridia, $2A,  !Area_EastMaridia,  $00,  NoPatch) ; Precious
%RoomEntry(Maridia, $2B,  !Area_EastMaridia,  $00,  NoPatch) ; Botwoon E-Tank
%RoomEntry(Maridia, $2C,  !Area_EastMaridia,  $00,  NoPatch) ; Coliseum Save
%RoomEntry(Maridia, $2D,  !Area_EastMaridia,  $00,  NoPatch) ; Halfie Shaft Missile Refill
%RoomEntry(Maridia, $2E,  !Area_EastMaridia,  $20,  NoPatch) ; Bug Quicksand
%RoomEntry(Maridia, $2F,  !Area_EastMaridia,  $00,  NoPatch) ; Botwoon E-Tank Quicksand
%RoomEntry(Maridia, $30,  !Area_EastMaridia,  $20,  !Shaktool_Patch) ; Shaktool
%RoomEntry(Maridia, $31,  !Area_EastMaridia,  $00,  NoPatch) ; Halfie Shaft
%RoomEntry(Maridia, $32,  !Area_EastMaridia,  $00,  NoPatch) ; Botwoon
%RoomEntry(Maridia, $33,  !Area_EastMaridia,  $00,  NoPatch) ; Space Jump
%RoomEntry(Maridia, $34,  !Area_EastMaridia,  $00,  NoPatch) ; Coliseum Save
%RoomEntry(Maridia, $35,  !Area_EastMaridia,  $00,  NoPatch) ; Cactus Alley West
%RoomEntry(Maridia, $36,  !Area_EastMaridia,  $00,  NoPatch) ; Cactus Alley East
%RoomEntry(Maridia, $37,  !Area_EastMaridia,  $00,  NoPatch) ; Draygon

; Tourian
;          Area    index     sub_areas room_flags  room_patches
%RoomEntry(Tourian, $00,  !Area_Tourian, $00,  NoPatch) ; Tourian Elevator Bottom
%RoomEntry(Tourian, $01,  !Area_Tourian, $00,  NoPatch) ; Metroids 1
%RoomEntry(Tourian, $02,  !Area_Tourian, $00,  NoPatch) ; Metroids 2
%RoomEntry(Tourian, $03,  !Area_Tourian, $00,  NoPatch) ; Metroids 3
%RoomEntry(Tourian, $04,  !Area_Tourian, $00,  NoPatch) ; Metroids 4
%RoomEntry(Tourian, $05,  !Area_Tourian, $00,  NoPatch) ; Hoppers 1
%RoomEntry(Tourian, $06,  !Area_Tourian, $00,  NoPatch) ; Hoppers 2
%RoomEntry(Tourian, $07,  !Area_Tourian, $00,  NoPatch) ; The Baby
%RoomEntry(Tourian, $08,  !Area_Tourian, $00,  NoPatch) ; The Baby 2
%RoomEntry(Tourian, $09,  !Area_Tourian, $00,  NoPatch) ; Tourian Refill
%RoomEntry(Tourian, $0A,  !Area_Tourian, $00,  NoPatch) ; Mother Brain
%RoomEntry(Tourian, $0B,  !Area_Tourian, $00,  NoPatch) ; Sand Hall
%RoomEntry(Tourian, $0C,  !Area_Tourian, $00,  NoPatch) ; Mother Brain Shaft
%RoomEntry(Tourian, $0D,  !Area_Tourian, $00,  NoPatch) ; Mother Brain Save
%RoomEntry(Tourian, $0E,  !Area_Tourian, $00,  NoPatch) ; Escape 1
%RoomEntry(Tourian, $0F,  !Area_Tourian, $00,  NoPatch) ; Escape 2
%RoomEntry(Tourian, $10,  !Area_Tourian, $00,  NoPatch) ; Escape 3
%RoomEntry(Tourian, $11,  !Area_Tourian, $00,  NoPatch) ; Escape 4
%RoomEntry(Tourian, $12,  !Area_Tourian, $00,  NoPatch) ; Tourian Elevator Save

CustomPLMTable:
;   room, plm,   yyxx,  args
dw $0000, $0000, $0000, $0000
