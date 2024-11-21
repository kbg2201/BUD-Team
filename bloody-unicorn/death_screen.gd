extends CanvasLayer

var fade_duration = 1

func show_message():
	$Text_Timer.start()
	$Message.show()
	$AnimationPlayer.play("fade_in")

func show_transition():
	$Transition_Timer.start()
	$Transition.show()
	$AnimationPlayer.play("fade_out")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Message.hide()
	$Transition.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_transition_timer_timeout() -> void:
	$Message.hide()
	$Transition.hide()
	get_tree().change_scene_to_file("res://Scenes/title_screen.tscn")


func _on_text_timer_timeout() -> void:
	show_transition()
