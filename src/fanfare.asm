; Bank $84

pushpc
org $848BDD ; Vanilla item fanfare entry point
ItemSound:
        LDA.l NoFanfare : BNE +
                JSR.w PlayFanfare
                INY
                RTS
        +
        JSR.w PlayClick
        INY
RTS
pullpc

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

