; Bank $84

ItemSound:
        LDA.l NoFanfare : BNE +
                JSR.w PlayFanfare
                INY
                RTS
        +
        JSR.w PlayClick
        INY
RTS

HandleRoomMusicPickup:
        LDA.l NoFanfare : BNE +
                LDA.w #$0168
                JSL.l PlayRoomMusic
        +
RTS

PlayFanfare:
        PHX
        LDX.w #$000E
        -
                STZ.w MusicQueue,X
                STZ.w MusicQueueTimers,X
                DEX
                DEX
        BPL -
        PLX
        LDA.w MusicQueueWrite : STA.w MusicQueueRead
        STZ.w MusicTimer : STZ.w MusicToPlay
        LDA.w #$0002
        JSL.l QueueMusicTrack
RTS

PlayClick:
	LDA.w #$0037
        JSL.l QueueSoundLibraryOne
RTS

; Replace vanilla item music vectors with our handler.
; Visible item PLMs
pushpc
org $84E0B3 : dw ItemSound : org $84E0D8 : dw ItemSound : org $84E0FD : dw ItemSound
org $84E122 : dw ItemSound : org $84E14F : dw ItemSound : org $84E17D : dw ItemSound
org $84E1AB : dw ItemSound : org $84E1D9 : dw ItemSound : org $84E207 : dw ItemSound
org $84E235 : dw ItemSound : org $84E263 : dw ItemSound : org $84E291 : dw ItemSound
org $84E2C3 : dw ItemSound : org $84E2F8 : dw ItemSound : org $84E32D : dw ItemSound
org $84E35A : dw ItemSound : org $84E388 : dw ItemSound : org $84E3B5 : dw ItemSound
org $84E3E3 : dw ItemSound : org $84E411 : dw ItemSound : org $84E43F : dw ItemSound
; Chozo item PLMs
org $84E46F : dw ItemSound : org $84E4A1 : dw ItemSound : org $84E4D3 : dw ItemSound
org $84E505 : dw ItemSound : org $84E53F : dw ItemSound : org $84E57A : dw ItemSound
org $84E5F0 : dw ItemSound : org $84E62B : dw ItemSound : org $84E66F : dw ItemSound
org $84E6AA : dw ItemSound : org $84E6E5 : dw ItemSound : org $84E720 : dw ItemSound
org $84E762 : dw ItemSound : org $84E7A4 : dw ItemSound : org $84E7DE : dw ItemSound
org $84E819 : dw ItemSound : org $84E853 : dw ItemSound : org $84E88E : dw ItemSound
org $84E8C9 : dw ItemSound : org $84E904 : dw ItemSound
; Hidden item PLMs
org $84E93A : dw ItemSound : org $84E972 : dw ItemSound : org $84E9AA : dw ItemSound
org $84E9E2 : dw ItemSound : org $84EA22 : dw ItemSound : org $84EA63 : dw ItemSound
org $84EAA4 : dw ItemSound : org $84EAE5 : dw ItemSound : org $84EB26 : dw ItemSound
org $84EB67 : dw ItemSound : org $84EBA8 : dw ItemSound : org $84EBE9 : dw ItemSound
org $84EC2A : dw ItemSound : org $84EC72 : dw ItemSound : org $84ECBA : dw ItemSound
org $84ECFA : dw ItemSound : org $84ED3B : dw ItemSound : org $84ED7B : dw ItemSound
org $84EDBC : dw ItemSound : org $84EDFD : dw ItemSound : org $84EE3E
pullpc
