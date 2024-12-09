extends CharacterBody2D

@export var speed = 200
var screen_size
var can_move
var last_input

@onready var all_interactions = []
@onready var interact_label = $InteractionComponents/InteractLabel

signal hit
signal rock_destroy
signal unicorn_activate
signal win
signal wall

#get the player ready in the window and hide them until the game starts
func _ready():
	last_input = "down"
	screen_size = get_viewport_rect().size 
	can_move = true
	#hide()

#set up movements
func _process(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * speed
	if can_move == true:
		move_and_slide()

	if velocity.length() > 0:
		velocity = velocity.normalized()
		if $GrassTimer.time_left <= 0:
			$Grass.play()
			$GrassTimer.start(0.25) #i think smaller timer is better
	else:
		$AnimatedSprite2D.pause()
		$Grass.stop()
	
	if Input.is_action_pressed("move_up"):
		$AnimatedSprite2D.play("up")
		last_input = "up"
	if Input.is_action_pressed("move_down"):
		$AnimatedSprite2D.play("down")
		last_input = "down"
	if Input.is_action_pressed("move_left"):
		if last_input == "up":
			$AnimatedSprite2D.play("up")
		else:
			$AnimatedSprite2D.play("down")
	if Input.is_action_pressed("move_right"):
		if last_input == "up":
			$AnimatedSprite2D.play("up")
		else:
			$AnimatedSprite2D.play("down")
		
	
	position += velocity * delta
	#position = position.clamp(Vector2.ZERO, screen_size)
	
	#if velocity.x != 0:
		#$AnimatedSprite2D.animation = "down"
		#$AnimatedSprite2D.flip_v = false
		# See the note below about the following boolean assignment.
		#$AnimatedSprite2D.flip_h = velocity.x < 0
	#elif velocity.y != 0:
		#$AnimatedSprite2D.animation = "up"
		#$AnimatedSprite2D.flip_v = velocity.y > 0
	
	if Input.is_action_just_pressed("interact"):
		exectute_interactions()

#Starts the player
func start(pos):
	position = pos
	show()
	can_move = true
	$CollisionShape2D.disabled = false


func _on_interaction_area_area_entered(area: Area2D) -> void:
	all_interactions.insert(0, area)
	update_interactions()


func _on_interaction_area_area_exited(area: Area2D) -> void:
	all_interactions.erase(area)
	update_interactions()

func update_interactions():
	if all_interactions:
		interact_label.text = "[Z]"
	else:
		interact_label.text = ""
	
func exectute_interactions():
	if all_interactions:
		var current_interaction = all_interactions[0]
		match current_interaction.interact_type:
			"rock_destroy" : rock_destroy.emit()
			"unicorn_activate" : unicorn_activate.emit()
			"win" : win.emit()
			"wall" : wall.emit()


func _on_hitbox_body_entered(body: Node2D) -> void:
	hide()
	hit.emit()
	can_move = false
	$Hitbox/CollisionShape2D.set_deferred("disabled", true)
