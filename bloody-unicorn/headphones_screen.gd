extends Control

var count = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("fade_in")
	$AnimationTimer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene_to_file("res://Scenes/title_screen.tscn")

func _on_animation_timer_timeout() -> void:
	if count == 1:
		$AnimationTimer.stop()
		$AnimationRect.hide()
		$HoldTimer.start()
		count += 1
	else:
		get_tree().change_scene_to_file("res://Scenes/title_screen.tscn")


func _on_hold_timer_timeout() -> void:
	$HoldTimer.stop()
	$AnimationRect.show()
	$AnimationPlayer.play("fade_out")
	$AnimationTimer.start()
