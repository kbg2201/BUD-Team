extends Area2D

@export var speed = 300
var screen_size
var can_move

signal hit

#get the player ready in the window and hide them until the game starts
func _ready():
	screen_size = get_viewport_rect().size 
	can_move = true
	#hide()

#set up movements
func _process(delta):
	var velocity = Vector2.ZERO
	if can_move == true:
		if Input.is_action_pressed("move_right"):
			velocity.x += 10
			$AnimatedSprite2D.animation = "down"
		if Input.is_action_pressed("move_left"):
			velocity.x -= 10
			$AnimatedSprite2D.animation = "down"
		if Input.is_action_pressed("move_down"):
			velocity.y += 10
			$AnimatedSprite2D.animation = "down"
		if Input.is_action_pressed("move_up"):
			velocity.y -= 10
			$AnimatedSprite2D.animation = "up"

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		if $GrassTimer.time_left <= 0:
			$Grass.play()
			$GrassTimer.start(0.25) #i think smaller timer is better
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.pause()
		$Grass.stop()
		
	
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

func _on_body_entered(body):
	hide()
	hit.emit()
	can_move = false
	$CollisionShape2D.set_deferred("disabled", true)

#Starts the player
func start(pos):
	position = pos
	show()
	can_move = true
	$CollisionShape2D.disabled = false
