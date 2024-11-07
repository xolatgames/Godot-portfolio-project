class_name Smile extends StaticBody3D

const interact_distance: float = 2.0

var activate: bool = false


func _process(delta) -> void:
	var camera: Camera3D = get_viewport().get_camera_3d()
	var mouse_position: Vector2 = get_viewport().get_mouse_position()
	var from: Vector3 = camera.project_ray_origin(mouse_position)
	var to: Vector3 = from + camera.project_ray_normal(mouse_position) * interact_distance
	var space_state: PhysicsDirectSpaceState3D = get_world_3d().direct_space_state
	var query: PhysicsRayQueryParameters3D = PhysicsRayQueryParameters3D.create(from, to)
	var object: Dictionary = space_state.intersect_ray(query)
	
	if activate:
		get_parent().look_at(camera.global_position)
	
	if object:
		if object.collider == self:
			$Label.show()
			
			if !activate:
				$WOW.play()
				activate = true
			
			return
	
	$Label.hide()
