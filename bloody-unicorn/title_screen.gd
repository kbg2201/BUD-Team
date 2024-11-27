extends Control
var show_light

func _ready():
	show_light = true
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


func _on_light_timer_timeout() -> void:
	var rand = randi_range(0, 5)
	if rand == 1:
		$AnimationPlayer.play("flicker")
		$Flicker.play()
	if show_light == true:
		$AnimationPlayer.play("flicker")
		$Flicker.play()
		$Hum.play()
		show_light = false


func _on_hum_finished() -> void:
	$Hum.play()
