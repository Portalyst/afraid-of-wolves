extends StaticBody2D

signal take_flash

func _ready() -> void:
	set_meta("flash", 1)
	var spawn := randi_range(0 , 2)
	self.position = global.flashs[spawn]

func pick_up(selected: Array):
	take_flash.emit()
	queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_meta("player"):
		body.use.connect(pick_up)

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.has_meta("player"):
		body.use.disconnect(pick_up)
