extends Node

func _ready():
	AudioPlayer.play_music_level()

func _on_sound_toggled(muted: bool) -> void:
	AudioPlayer.stream_paused = muted
