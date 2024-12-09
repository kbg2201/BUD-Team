extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Label.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func set_label(str):
	$Label.text = str


func _on_interact_area_body_entered(body: Node2D) -> void:
	$Label.show()


func _on_interact_area_body_exited(body: Node2D) -> void:
	$Label.hide()


func _on_interact_area_area_entered(area: Area2D) -> void:
	$Label.show()


func _on_interact_area_area_exited(area: Area2D) -> void:
	$Label.hide()
