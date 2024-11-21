extends Control

func _ready():
	$VBoxContainer/StartButton.hide()
	$VBoxContainer/QuitButton.hide()
	$AnimationTimer.start()
	$AnimationPlayer.play("fade_in")

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
	


func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_animation_timer_timeout() -> void:
	$VBoxContainer/StartButton.show()
	$VBoxContainer/QuitButton.show()
	$VBoxContainer/Panel/AnimationRect.hide()
	#pass # Replace with function body.
