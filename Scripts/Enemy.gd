extends Area3D

var speed = 5
var seeing_distance = 30

var speed_delta : float

@onready var agent = $NavigationAgent3D

func _process(delta):
	if global_position.distance_to(Global.player.global_position) < seeing_distance:
		agent.target_position = Global.player.global_position


func _physics_process(delta):
	if agent.is_navigation_finished():
		return
	
	speed_delta = speed * delta
	
	look_at(agent.get_next_path_position())
	agent.velocity = global_position.direction_to(agent.get_next_path_position()) * speed_delta


func _on_navigation_agent_3d_velocity_computed(safe_velocity):
	global_position = global_position.move_toward(global_position + safe_velocity, speed_delta)


func _on_body_entered(body):
	if body.name == "Player":
		Global.lose()
