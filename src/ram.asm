;------------------------------------------------------------------------------
; RAM Assignments & Labels
;------------------------------------------------------------------------------
; See PJ Boy's dissassembly for further documentation of these addresses.
;------------------------------------------------------------------------------
pushpc
org 0

;------------------------------------------------------------------------------
; Bank $7E
;------------------------------------------------------------------------------
; $7E0000-$7E1FFF is mirrored up to bank $BF
;------------------------------------------------------------------------------

;------------------------------------------------------------------------------
; Mirrored WRAM
;------------------------------------------------------------------------------
; $7E0000 - $7E1FFF. Not mirrored in bank $7F or banks >= $C0
;------------------------------------------------------------------------------
MultiplierOne = $7E0026              ; 16-bit DP scratch space. Used by vanilla for multiplier
MultiplierTwo = $7E0028              ; 16-bit DP scratch space. Used by vanilla for multiplier
MultiplyResult = $7E002A             ; 32-bit DP scratch space. Used by vanilla for result.
SubAreaIndex = $7E0336               ;
RoomFlags = $7E0338                  ; Used to flag gravity suit physics on room entry, unpause,
                                     ; and relevant item pickups.
MessageBoxFlag = $7E033A             ; $00 = No message box | $01 = Message box on screen
NMICounter = $7E05B8                 ;
MusicQueue = $7E0619                 ; Word-length music queue entries. $0F bytes
MusicQueueTimers = $7E0629           ; Word-length queue timers. $0F bytes
MusicQueueWrite = $7E0639            ; Index of next available position to write. Word length
MusicQueueRead = $7E063B             ; Read position when processing queue. Word length
MusicToPlay = $7E063D                ; Music entry processed when timer hits 0.
MusicTimer = $7E063F                 ;
ScreenFadeDelay = $7E0723            ;
ScreenFadeCounter = $7E0725          ;
AreaMapFlag = $7E0789                ;
RoomPointer = $7E079B                ;
RoomIndex = $7E079D                  ;
AreaIndex = $7E079F                  ;
FileSelectCursor = $7E0952           ;
SaveSlotPresence = $7E0954           ;
GameState = $7E0998                  ;
DoorTransitionPtr = $7E099C          ;
HUDItemIndex = $7E09D2               ;
DoubleJumpFlag = $7E0A14             ; Zeroed when Samus lands. Unused(?) debug value.
PreviousBeams = $7E0A1A              ;
SamusPose = $7E0A1C                  ;
DamageFlashCounter = $7E0A48         ; Samus hurt flash counter
SamusPaletteFlags = $7E0A4A          ; Super special Samus palette flags.
SamusSubDamage = $7E0A4C             ; Only affected by SamusPeriodicDamage.
PeriodicDamage = $7E0A4E             ; Periodic damage to Samus (32-bits)
SamusKnockbackDirection  =  $7E0A52  ; Knockback direction
TimeFrozenFlag = $7E0A78             ;
DoorAdjustFlag = $7E0AA4             ; Set when doors being adjusted before scrolling (for timing.)
SamusAnimationFrame = $7E0A96        ;
LiquidPhysicsType = $7E0AD2          ; $00 = Air | $01 = Water | $02 = Lava/Acid
SamusXPos = $7E0AF6                  ; Samus X position
SamusXSubPos = $7E0AF8               ; Samus X subposition
SamusYPos = $7E0AFA                  ; Samus Y position
SamusYSubPos = $7E0AFC               ; Samus Y subposition
SamusXRadius = $7E0AFE               ; Samus X radius
SamusYRadius = $7E0B00               ; Samus Y radius
RTASeconds = $7E0B08                 ; RTA timer in seconds. Written during pre-credits stats prep.
SpeedStepCounter = $7E0B3E           ; Animation counter for speed booster
SpeedCounter = $7E0B3F               ;
ProjectileType = $7E0C18             ; 10 bytes.
ProjectileDamage = $7E0C2C           ; 10 bytes.
BombCounter = $7E0CD2                ;
ProjectileIndex = $7E0DDE            ;
BoundaryPosition = $7E0E32           ;
InvincibilityTimer = $7E18A8         ;
KnockbackTimer = $7E18AA             ;
CopyClearCursor = $7E19B5            ; File copy/clear menu selection
CopyClearSource = $7E19B7            ; File copy source slot / file clear slot
CopyDestination = $7E19B9            ; File copy destination slot
PLMIds = $7E1C37                     ;

;------------------------------------------------------------------------------
; Unmirrored WRAM
;------------------------------------------------------------------------------
EnemyRam = $7E8000                   ; $07FF bytes.
ItemPLMBuffer = $7EF4A0              ; $1F bytes.

;------------------------------------------------------------------------------
; Bank $7F
;------------------------------------------------------------------------------
base $7FFD00                         ;
BootTest: skip 4                     ; Used to determine cold boot vs soft reset
BootTestInverse: skip 4              ;
ColdBootFlag: skip 2                 ;
base off

pullpc
