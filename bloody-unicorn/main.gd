extends Node

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
	pass


func _on_player_hit() -> void:
	$Death_Screen.show()
	$Death_Screen.show_message()
	$LucyVoice.can_talk = false
	#pass # Replace with function body.


func _on_lucy_voice_scrape_play() -> void:
	$LucyVoice/knifescrape.play() # Replace with function body.
