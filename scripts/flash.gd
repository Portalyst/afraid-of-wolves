extends StaticBody2D

signal take_flash

func _ready() -> void:
	set_meta("flash", 1)
	var flash0 : Vector2 = $/root/level/Markers/flash_marker.position
	var flash1 : Vector2 = $/root/level/Markers/flash_marker2.position
	var flash2 : Vector2 = $/root/level/Markers/flash_marker3.position
	var flashs = [flash0, flash1, flash2]
	var spawn := randi_range(0 , 2)
	self.position = flashs[spawn]

func pick_up(selected: Array):
	take_flash.emit()
	queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_meta("player"):
		body.use.connect(pick_up)
		global.player_can_flash = false

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.has_meta("player"):
		body.use.disconnect(pick_up)
		global.player_can_flash = true
