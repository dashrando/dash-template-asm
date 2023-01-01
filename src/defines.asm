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
!softreset = $7fffe6
!scroll_speed = $7fffe8

!DoorTransitions = $0002
!ChargeShots = $0014
!SpecialBeamAttacks = $0015
!SuperMissiles = $0016
!Missiles = $0017
!PowerBombs = $0018

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

