; TODO: ALL addresses should be labels instead of defines. Value defines should first be
; scoped to their module and then placed here only if used in multiple modules.

; Defines for the script and credits data
!speed = $f770
!set = $9a17
!delay = $9a0d
!draw = $0000
!end = $f6fe, $99fe
!blank = $1fc0
!row = $0040

!last_saveslot = $7fffe0
!timer_backup1 = $7fffe2
!timer_backup2 = $7fffe4


; RTA Timer (timer 1 is frames, and timer 2 is number of times frames rolled over)
!timer1 = $05b8
!timer2 = $05ba

; Temp variables (define here to make sure they're not reused, make sure they're 2 bytes apart)
; These variables are cleared to 0x00 on hard and soft reset
!door_timer_tmp = $7fff00
!door_adjust_tmp = $7fff02
!add_time_tmp = $7fff04
!region_timer_tmp = $7fff06
!region_tmp = $7fff08

; Index values associated with each zone
!Area_Crateria = #$00       ; includes Blue Brinstar
!Area_GreenBrinstar = #$01  ; Brinstar
!Area_UpperNorfair = #$02   ; Norfair
!Area_WreckedShip = #$03
!Area_EastMaridia = #$04    ; Maridia
!Area_Tourian = #$05
!Area_Ceres = #$06
!Area_Debug = #$07
!Area_RedBrinstar = #$08
!Area_Kraid = #$09
!Area_WestMaridia = #$0A
!Area_LowerNorfair = #$0B
!Area_Crocomire = #$0C

; Special Block
!bts = $08 ;Maximum 0F
!bts2 = $09 ;Maximum 0F
