extends CanvasLayer

signal resumed

func show_pause_menu():
	$Dimmer.show()
	$CanvasLayer.show()
	$Message.show()
	$ResumeButton.show()
	$QuitButton.show()

func resume():
	$Dimmer.hide()
	$Message.hide()
	$CanvasLayer.hide()
	$ResumeButton.hide()
	$QuitButton.hide()
	resumed.emit()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Dimmer.hide()
	$Message.hide()
	$CanvasLayer.hide()
	$ResumeButton.hide()
	$QuitButton.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_resume_button_pressed() -> void:
	resume()
