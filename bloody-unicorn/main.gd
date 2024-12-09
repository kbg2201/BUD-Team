extends Node2D

var is_paused = false
var can_talk = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Death_Screen.hide()
	$LucyVoice.start_talking()
	$SucyVoice.start_talking()


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
	can_talk = false
	$Player/DeathNoise.play()
	#pass # Replace with function body.


func _on_lucy_voice_scrape_play() -> void:
	if can_talk:
		$EnemyUnicorn/knifescrape.play()


func _on_lucy_voice_scrape_stop() -> void:
	$EnemyUnicorn/knifescrape.stop()


func _on_pause_menu_resumed() -> void:
	is_paused = false
	can_talk = true
	$LucyVoice.can_talk = true
	$Player.can_move = true


func _rock_destroy() -> void:
	$Rock.queue_free()


func _unicorn_activate() -> void:
	$EnemyUnicorn.start_timer()


func _on_player_win() -> void:
	$FriendlyUnicorn/knifescrape.stop()
	$SucyVoice/SucyVoice.hide()
	$FriendlyUnicorn.set_label("Oh good! You found me.")
	$FriendlyUnicorn.start_timer()


func _on_sucy_voice_scrape_play() -> void:
	if can_talk:
		$FriendlyUnicorn/knifescrape.play()


func _on_sucy_voice_scrape_stop() -> void:
		$FriendlyUnicorn/knifescrape.stop()
