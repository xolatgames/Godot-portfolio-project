extends CanvasLayer


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE


func _on_quit_pressed() -> void:
	print("Thanks! ^_^")
	
	get_tree().quit()
