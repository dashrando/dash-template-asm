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
HDMAChannels = $7E0085               ; HDMA channels to enable. Updated and written to $420C during NMI.
BG1XScroll = $7E00B1                 ; BG1 X scroll ($210D). Updated during NMI
BG1YScroll = $7E00B3                 ; BG1 Y scroll ($210E). Updated during NMI
BG2XScroll = $7E00B5                 ; BG2 X scroll ($210F). Updated during NMI
BG2YScroll = $7E00B7                 ; BG2 Y scroll ($2110). Updated during NMI
BG3XScroll = $7E00B9                 ; BG3 X scroll ($2111). Updated during NMI
BG3YScroll = $7E00BB                 ; BG3 Y scroll ($2112). Updated during NMI
BG4XScroll = $7E00BD                 ; BG4 X scroll ($2113). Updated during NMI
BG4YScroll = $7E00BF                 ; BG4 Y scroll ($2114). Updated during NMI
VRAMWriteTable = $7E00D0             ; See disassembly for entry format. $1FF bytes.
VRAMTableSP = $7E0330                ; VRAM transfer table stack pointer.
SubAreaIndex = $7E0336               ;
RoomFlags = $7E0338                  ; Used to flag gravity suit physics on room entry, unpause,
                                     ; and relevant item pickups.
MessageBoxFlag = $7E033A             ; $00 = No message box | $01 = Message box on screen
HUDDrawFlag = $7E033C                ; Flags whether HUD item counts need to be updated.
HUDHDMAPtr = $7E033E                 ; Pointer to HUD HDMA command run when vanilla writes to $420C
NMIAux = $7E0362                     ; Long address to routine run at the end of next NMI. 4 bytes reserved.
PowerBombStatus = $7E0592            ; $4000 = pending | $8000 = exploding/cf
NMIRequestFlag = $7E05B4             ;
NMICounter = $7E05B8                 ;
DoorTransitionVRAMFlag = $7E05BC     ;
MusicQueue = $7E0619                 ; Word-length music queue entries. $0F bytes
MusicQueueTimers = $7E0629           ; Word-length queue timers. $0F bytes
MusicQueueWrite = $7E0639            ; Index of next available position to write. Word length
MusicQueueRead = $7E063B             ; Read position when processing queue. Word length
MusicToPlay = $7E063D                ; Music entry processed when timer hits 0.
MusicTimer = $7E063F                 ;
ScreenFadeDelay = $7E0723            ;
ScreenFadeCounter = $7E0725          ;
AreaMapFlag = $7E0789                ;
DoorDirection = $7E0791              ;
RoomPointer = $7E079B                ;
RoomIndex = $7E079D                  ;
AreaIndex = $7E079F                  ;
FileSelectCursor = $7E0952           ;
SaveSlotPresence = $7E0954           ;
GameState = $7E0998                  ;
DoorTransitionPtr = $7E099C          ;
HUDItemIndex = $7E09D2               ;
DoubleJumpFlag = $7E0A14             ; Zeroed when Samus lands. Unused(?) debug value.
PreviousBeams = $7E0A1A              ; Word-length bitfield. Beams equipped with charge upgrades ORed in.
SamusPose = $7E0A1C                  ;
DamageFlashCounter = $7E0A48         ; Samus hurt flash counter
SamusPaletteFlags = $7E0A4A          ; Super special Samus palette flags.
SamusSubDamage = $7E0A4C             ; Only affected by SamusPeriodicDamage.
PeriodicDamage = $7E0A4E             ; Periodic damage to Samus (32-bits)
SamusKnockbackDirection  =  $7E0A52  ; Knockback direction
HyperBeamFlag = $7E0A76              ;
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
EnemyIndex = $7E0E54                 ;
EnemyData = $7E0F78                  ; $7FF bytes. See enemy ram in disassembly.
InvincibilityTimer = $7E18A8         ;
KnockbackTimer = $7E18AA             ;
LiquidYPos = $7E1962                 ; Base Y position for FX, high bit set disables FX.
FXYPos = $7E1978                     ; Base Y position for FX, high bit set disables FX.
CopyClearCursor = $7E19B5            ; File copy/clear menu selection
CopyClearSource = $7E19B7            ; File copy source slot / file clear slot
CopyDestination = $7E19B9            ; File copy destination slot
PLMIds = $7E1C37                     ;

;------------------------------------------------------------------------------
; Unmirrored WRAM
;------------------------------------------------------------------------------
EnemyRam = $7E8000                   ; $07FF bytes.
PaletteBuffer = $7EC000              ; Transfered to CGRAM during vertical blank
PaletteBufferAux = $7EC200           ; Auxiliary buffer, used as backup when the first is changed.
RightHUDOne = $7EC63A                ; Tile map buffers for where the mini-map was. $0E bytes
RightHUDTwo = $7EC67A                ; per row.
RightHUDThree = $7EC6BA              ;
ItemPLMBuffer = $7EF4A0              ; $1F bytes.

;------------------------------------------------------------------------------
; Bank $7F
;------------------------------------------------------------------------------
base $7FFF00                         ;
BootTest: skip 4                     ; Used to determine cold boot vs soft reset
BootTestInverse: skip 4              ;
ColdBootFlag: skip 2                 ;
CreditsScrollSpeed: skip 2           ;
HUDHDMAWRAM: skip $56                ;
warnpc $800000
base off

pullpc
