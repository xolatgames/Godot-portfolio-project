extends RigidBody3D

var mouse_sensitivity = 0.8
var mouse_look_x_limit = 89

var walk_speed = 150
var run_speed = 200
var jump_force = 500

var jumps_amount = 0

var deep_of_abyss = -50

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _input(event):
	if event is InputEventMouseMotion:
		apply_torque(Vector3(0, - event.relative.x * mouse_sensitivity * 50, 0))
		
		$Camera3D.rotation_degrees.x -= event.relative.y * mouse_sensitivity
		$Camera3D.rotation_degrees.x = clamp($Camera3D.rotation_degrees.x, -mouse_look_x_limit, mouse_look_x_limit)


func _process(delta):
	movement()
	changing_animation()
	
	if linear_velocity.y < -5:
		play_footstep_sound()
	
	if transform.origin.y < deep_of_abyss or Input.is_action_just_pressed("restart"):
		Global.lose()


func _on_grounded_body_entered(body):
	jumps_amount = 3


func _on_jumping_timeout():
	jump()


func movement():
	var speed = walk_speed
	
	if Input.is_action_pressed("run"):
		speed = run_speed
	
	if Input.is_action_pressed("move_left"):
		apply_central_force( - transform.basis.x * speed)
	
	if Input.is_action_pressed("move_right"):
		apply_central_force(transform.basis.x * speed)
	
	if Input.is_action_pressed("move_forward"):
		apply_central_force( - transform.basis.z * speed)
	
	if Input.is_action_pressed("move_backward"):
		apply_central_force(transform.basis.z * speed)
	
	if Input.is_action_just_pressed("jump"):
		if jumps_amount > 0:
			jump()
		else:
			$Jumping.start()


func changing_animation():
	if linear_velocity.y > 0.5:
		$AnimationPlayer.play("jumping")
		return
	
	if linear_velocity.y < -0.5:
		$AnimationPlayer.play("falling")
		return
	
	if linear_velocity.x > 0.5 or linear_velocity.x < -0.5\
or linear_velocity.z > 0.5 or linear_velocity.z < -0.5:
		$AnimationPlayer.play("walking")
	else:
		$AnimationPlayer.play("idle")


func play_footstep_sound():
	var platforms = $Grounded.get_overlapping_bodies()
	
	for i in platforms:
		if i.is_in_group("bricks"):
			$"bricks footstep".play()
			break
		
		if i.is_in_group("wood"):
			$"wood footstep".play()
			break
		
		if i.is_in_group("grass"):
			$"grass footstep".play()
			break


func jump():
	if jumps_amount > 0:
		apply_central_force(Vector3(0, jump_force * 10, 0))
		
		jumps_amount -= 1
