class_name Enemy extends Area3D

const seeing_distance: float = 30
const speed: float = 5

var speed_delta : float

@onready var agent: NavigationAgent3D


func _ready() -> void:
	agent = get_node("NavigationAgent3D")


func _process(delta) -> void:
	if global_position.distance_to(Global.player.global_position) < seeing_distance:
		agent.target_position = Global.player.global_position


func _physics_process(delta) -> void:
	if agent.is_navigation_finished():
		return
	
	speed_delta = speed * delta
	
	look_at(agent.get_next_path_position())
	agent.velocity = global_position.direction_to(agent.get_next_path_position()) * speed_delta


func _on_navigation_agent_3d_velocity_computed(safe_velocity) -> void:
	global_position = global_position.move_toward(global_position + safe_velocity, speed_delta)


func _on_body_entered(body) -> void:
	if body.is_in_group("player"):
		Global.lose()
