extends Node

var player: RigidBody3D
var respawn_position: Vector3 = Vector3.ZERO


func _process(delta) -> void:
	if Input.is_action_just_pressed("fullscreen"):
		if !DisplayServer.window_get_mode(0) == DisplayServer.WINDOW_MODE_FULLSCREEN:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_size(Vector2(1152, 648), 0)


func lose() -> void:
	get_tree().current_scene.get_node("LoseSound").play()
	get_tree().paused = true
	
	var canvas_animation: AnimationPlayer = get_tree().current_scene.get_node("CanvasLayer/AnimationPlayer")
	
	canvas_animation.play("fade_in")
	
	await canvas_animation.animation_finished
	
	get_tree().paused = false
	get_tree().reload_current_scene()


func win() -> void:
	get_node("Music").queue_free()
	get_tree().paused = true
	
	var canvas_animation: AnimationPlayer = get_tree().current_scene.get_node("CanvasLayer/AnimationPlayer")
	
	canvas_animation.play("fade_in")
	await canvas_animation.animation_finished
	get_tree().change_scene_to_file("res://Scenes/finish.tscn")
	
	get_tree().paused = false
