extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$PlayerSprite.play("player_walk")
	$UnicornSprite.play("UnicornWalk")
	$AnimationPlayer.play("new_animation")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	$Timer.start()


func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://Scenes/title_screen.tscn")
