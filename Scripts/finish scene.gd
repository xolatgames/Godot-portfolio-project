extends CanvasLayer

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE


func _on_quit_pressed():
	print("Thanks! ^_^")
	
	get_tree().quit()
