extends SceneTree

# Run with: godot --headless --path idle-fishing --script tests/sound_toggle_test.gd
func _initialize() -> void:
	call_deferred("run_test")

func run_test() -> void:
	var game = load("res://scenes/Game.tscn").instantiate()
	root.add_child(game)
	await physics_frame
	await physics_frame
	var audio = root.get_node("AudioPlayer")
	var sound = game.get_node("TextureButton")
	if audio.stream_paused:
		push_error("music started paused")
		quit(1)
		return
	sound.button_pressed = true
	await process_frame
	if not audio.stream_paused:
		push_error("sound-off did not pause music")
		quit(1)
		return
	sound.button_pressed = false
	await process_frame
	if audio.stream_paused:
		push_error("sound-on did not resume music")
		quit(1)
		return
	game.queue_free()
	await process_frame
	print("sound toggle: pass")
	quit(0)
