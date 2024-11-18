extends CharacterBody2D

var speed = 300
@export var player: Node2D
@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	nav_agent.target_position = player.global_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var next_path_pos := nav_agent.get_next_path_position()
	var dir := global_position.direction_to(next_path_pos)
	velocity = dir * speed
	move_and_slide()

func _on_timer_timeout() -> void:
	nav_agent.target_position = player.global_position
