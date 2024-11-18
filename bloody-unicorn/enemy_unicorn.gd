extends CharacterBody2D

var speed = 100
#i made her get faster until she reaches you
var pursuit_speed = 1

@export var player: Node2D
@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	nav_agent.target_position = player.global_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pursuit_speed += 0.3
	var next_path_pos := nav_agent.get_next_path_position()
	#the missile knows where it is at all times
	#it knows this because it knows where it isn't
	var dir := global_position.direction_to(next_path_pos)
	velocity = dir * (speed + pursuit_speed)
	move_and_slide()
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.pause()

func _on_timer_timeout() -> void:
	nav_agent.target_position = player.global_position
