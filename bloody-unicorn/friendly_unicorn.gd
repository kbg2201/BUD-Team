extends CharacterBody2D

func _ready():
	$Label.text = ""

func set_label(str : String):
	$Label.text = str

func start_timer():
	$Timer.start()

func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://Scenes/title_screen.tscn")
