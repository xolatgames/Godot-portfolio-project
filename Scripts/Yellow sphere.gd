extends StaticBody3D

var activate = false

func _process(delta):
	var camera3d = get_viewport().get_camera_3d()
	var mouse_position = get_viewport().get_mouse_position()
	var from = camera3d.project_ray_origin(mouse_position)
	var to = from + camera3d.project_ray_normal(mouse_position) * 2
	var space_state = get_world_3d().direct_space_state
	var query = PhysicsRayQueryParameters3D.create(from, to)
	var object = space_state.intersect_ray(query)
	
	if activate:
		get_parent().look_at(camera3d.global_position)
	
	if object:
		if object.collider == self:
			$Label.show()
			
			if !activate:
				$AudioStreamPlayer3D.play()
				activate = true
			
			return
	
	$Label.hide()
