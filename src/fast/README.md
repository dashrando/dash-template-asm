# Fast Mode Patches
These patches are used to speed up gameplay in Map Randomizer. I am using `bip` to determine if the IPS files can be safely applied to a dash ROM.

## The following patches _cannot_ be blindly patched into a dash ROM:
- `fast_doors.ips` - maybe fixed by adjusting use of free space in $80 and $82
- `fast_pause_menu.ips` - maybe fixed by adjusting use of free space in $80
- `fast_reload.ips` - maybe fixed by adjusting use of free space in $80 and $82

## The following can be patched into a dash ROM:
- `elevator_speed.ips`
- `fast_big_boy_cutscene.ips`
- `fast_mother_brain_cutscene.ips`
- `fast_saves.ips`
