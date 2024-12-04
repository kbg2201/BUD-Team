extends Node

var is_paused = false
var can_talk = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Death_Screen.hide()
	#set background size (this is bad and sucks)
	$TextureRect.size = Vector2i(
		get_window().get_size_with_decorations().x,
		get_window().get_size_with_decorations().y
	)
	$LucyVoice.start_talking()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		if not is_paused:
			$PauseMenu.show_pause_menu()
			$LucyVoice.can_talk = false
			$Player.can_move = false
			can_talk = false
			is_paused = true
		elif is_paused:
			$PauseMenu.resume()
	pass


func _on_player_hit() -> void:
	$Death_Screen.show()
	$Death_Screen.show_message()
	$LucyVoice.can_talk = false
	$Player/DeathNoise.play()
	#pass # Replace with function body.


func _on_lucy_voice_scrape_play() -> void:
	if can_talk:
		$EnemyUnicorn/knifescrape.play() # Replace with function body.


func _on_lucy_voice_scrape_stop() -> void:
	$EnemyUnicorn/knifescrape.stop()


func _on_pause_menu_resumed() -> void:
	is_paused = false
	can_talk = true
	$LucyVoice.can_talk = true
	$Player.can_move = true
	pass # Replace with function body.
