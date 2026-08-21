extends StaticBody2D

@export var glenn : Node

signal block

var buttons : Array = [1, 0, 0]
var closed_vents : Array = [0, 0, 0]

var glenn_in_vent : int = -1

func _ready() -> void:
	set_meta("computer", 1)
	var computer0 : Vector2 = $/root/level/Markers/computer_marker.position
	var computer1 : Vector2 = $/root/level/Markers/computer_marker2.position
	var computer2 : Vector2 = $/root/level/Markers/computer_marker3.position
	var computers = [computer0, computer1, computer2]
	var spawn := randi_range(0, 2)
	self.position = computers[spawn]
	$AnimatedSprite2D.play(str(spawn))
	glenn.in_vent.connect(glenn_spawn)
	$CanvasLayer.hide()

func _process(delta: float) -> void:
	$CanvasLayer/vent1/Close.visible = closed_vents[0]
	$CanvasLayer/vent1/Open.visible = !closed_vents[0]
	$CanvasLayer/vent2/Close.visible = closed_vents[1]
	$CanvasLayer/vent2/Open.visible = !closed_vents[1]
	$CanvasLayer/vent3/Close.visible = closed_vents[2]
	$CanvasLayer/vent3/Open.visible = !closed_vents[2]

func use(selected: Array):
	global.player_can_walk = false
	$CanvasLayer.show()

func glenn_spawn(vent: int):
	glenn_in_vent = vent
	closed_vents = [0, 0, 0]

func _on_close_button_mouse_entered() -> void:
	$CanvasLayer/close_button.play("down")

func _on_close_button_mouse_exited() -> void:
	$CanvasLayer/close_button.play("up")

func _on_scan_button_mouse_entered() -> void:
	$CanvasLayer/scan_button.play("down")

func _on_scan_button_mouse_exited() -> void:
	$CanvasLayer/scan_button.play("up")

func _on_vent_button_1_mouse_entered() -> void:
	if buttons[0] == 0:
		$CanvasLayer/vent1.play("down")

func _on_vent_button_1_mouse_exited() -> void:
	$CanvasLayer/vent1.play("up")

func _on_vent_button_2_mouse_entered() -> void:
	if buttons[1] == 0:
		$CanvasLayer/vent2.play("down")

func _on_vent_button_2_mouse_exited() -> void:
	$CanvasLayer/vent2.play("up")

func _on_vent_button_3_mouse_entered() -> void:
	if buttons[2] == 0:
		$CanvasLayer/vent3.play("down")

func _on_vent_button_3_mouse_exited() -> void:
	$CanvasLayer/vent3.play("up")

func _on_quit_pressed() -> void:
	$CanvasLayer.hide()
	global.player_can_walk = true

func _on_vent_button_1_pressed() -> void:
	buttons = [0, 0, 0]
	buttons[0] = 1
	if buttons == closed_vents:
		$CanvasLayer/close_anim.play("closed")
	else:
		$CanvasLayer/close_anim.play("open")
	$CanvasLayer/vent1/Select.show()
	$CanvasLayer/vent2/Select.hide()
	$CanvasLayer/vent3/Select.hide()
	$CanvasLayer/vent1.play("up")

func _on_vent_button_2_pressed() -> void:
	buttons = [0, 0, 0]
	buttons[1] = 1
	if buttons == closed_vents:
		$CanvasLayer/close_anim.play("closed")
	else:
		$CanvasLayer/close_anim.play("open")
	$CanvasLayer/vent1/Select.hide()
	$CanvasLayer/vent2/Select.show()
	$CanvasLayer/vent3/Select.hide()
	$CanvasLayer/vent2.play("up")

func _on_vent_button_3_pressed() -> void:
	buttons = [0, 0, 0]
	buttons[2] = 1
	if buttons == closed_vents:
		$CanvasLayer/close_anim.play("closed")
	else:
		$CanvasLayer/close_anim.play("open")
	$CanvasLayer/vent1/Select.hide()
	$CanvasLayer/vent2/Select.hide()
	$CanvasLayer/vent3/Select.show()
	$CanvasLayer/vent3.play("up")

func _on_scan_button_pressed() -> void:
	if $scan_timer.is_stopped():
		$CanvasLayer/vent1/Attention.hide()
		$CanvasLayer/vent2/Attention.hide()
		$CanvasLayer/vent3/Attention.hide()
		$CanvasLayer/vent1/scan.show()
		$CanvasLayer/vent2/scan.show()
		$CanvasLayer/vent3/scan.show()
		$CanvasLayer/vent1/scan.play("run")
		$CanvasLayer/vent2/scan.play("run")
		$CanvasLayer/vent3/scan.play("run")
		$scan_timer.start()

func _on_close_button_pressed() -> void:
	$CanvasLayer/close_anim.play("close")
	await $CanvasLayer/close_anim.animation_finished
	closed_vents = buttons
	if glenn_in_vent == closed_vents.find(1):
		block.emit()
		glenn_in_vent = -1

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_meta("player"):
		body.use.connect(use)
		global.player_can_flash = false

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.has_meta("player"):
		body.use.disconnect(use)
		global.player_can_flash = true

func _on_scan_timer_timeout() -> void:
	$CanvasLayer/vent1/scan.hide()
	$CanvasLayer/vent2/scan.hide()
	$CanvasLayer/vent3/scan.hide()
	if glenn_in_vent != -1:
		if glenn_in_vent == 0:
			$CanvasLayer/vent1/Attention.show()
		if glenn_in_vent == 1:
			$CanvasLayer/vent2/Attention.show()
		if glenn_in_vent == 2:
			$CanvasLayer/vent3/Attention.show()
