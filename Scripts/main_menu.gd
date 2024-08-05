extends CanvasLayer

func _on_start_pressed():
	get_tree().change_scene_to_file("res://platformer.tscn")


func _on_dont_start_pressed():
	get_tree().quit()


func _on_meta_clicked(meta):
	OS.shell_open(meta)
