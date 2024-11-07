extends CanvasLayer


func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/platformer.tscn")


func _on_dont_start_pressed() -> void:
	get_tree().quit()


func _on_meta_clicked(meta) -> void:
	OS.shell_open(meta)
