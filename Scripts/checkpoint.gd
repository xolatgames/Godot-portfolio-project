class_name CheckPoint extends Area3D


func _on_body_entered(body) -> void:
	if body.is_in_group("player"):
		Global.respawn_position = global_position
