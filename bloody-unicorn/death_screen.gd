extends CanvasLayer

func show_message():
	$Timer.start()
	$Message.show()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Message.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	$Message.hide()
	get_tree().change_scene_to_file("res://Scenes/title_screen.tscn")
