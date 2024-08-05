extends Marker3D

func _process(delta):
	global_position = get_parent().get_node("Player").global_position
