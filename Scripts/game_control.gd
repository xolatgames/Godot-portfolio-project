class_name Game extends Node3D


func _ready() -> void:
	if !Global.has_node("Music"):
		var music: AudioStreamPlayer = AudioStreamPlayer.new()
		music.process_mode = Node.PROCESS_MODE_ALWAYS
		music.name = "Music"
		music.stream = load("res://Music/Derp Loopable.wav")
		music.volume_db = -10
		music.bus = "Music"
		Global.add_child(music)
		
		await get_tree().process_frame
		
		music.play()
	
	Global.player = get_node("Player")
	get_node("Player").global_position = Global.respawn_position


func _process(delta) -> void:
	$CanvasLayer/AnimationPlayer.animation_finished
	
	if Input.is_action_just_pressed("quit_game"):
		get_tree().quit()
