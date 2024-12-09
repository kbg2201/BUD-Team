extends Node2D

var is_paused = false
var can_talk = true
var key_screen = false
var has_key = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$KeyHUD.hide()
	$Death_Screen.hide()
	$KeyScreen.hide()
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
	
	if key_screen == true and Input.is_action_just_pressed("ui_accept"):
		$KeyScreen.hide()
		$KeyHUD.show()
		has_key = true
		$Wall.set_label("")
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
	$KeyScreen.show()
	key_screen = true


func _unicorn_activate() -> void:
	$EnemyUnicorn.start_timer()
	#not sure if this does what I want
	$LucyVoice.start_talking()
	$SucyVoice.start_talking()


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


func _wall() -> void:
	if has_key == true:
		$Wall.queue_free()
		$Wall2.queue_free()
		$KeyHUD.hide()
