extends StaticBody2D

@export var glenn : Node

signal block

var buttons : Array = [1, 0, 0]

var glenn_in_vent : int

func _ready() -> void:
	set_meta("computer", 1)
	var spawn := randi_range(0, 2)
	self.position = global.computers[spawn]
	$AnimatedSprite2D.play(str(spawn))
	glenn.in_vent.connect(glenn_spawn)

func glenn_spawn(vent: int):
	glenn_in_vent = vent

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
	$CanvasLayer/vent1/Select.show()
	$CanvasLayer/vent2/Select.hide()
	$CanvasLayer/vent3/Select.hide()
	$CanvasLayer/vent1.play("up")

func _on_vent_button_2_pressed() -> void:
	buttons = [0, 0, 0]
	buttons[1] = 1
	$CanvasLayer/vent1/Select.hide()
	$CanvasLayer/vent2/Select.show()
	$CanvasLayer/vent3/Select.hide()
	$CanvasLayer/vent2.play("up")

func _on_vent_button_3_pressed() -> void:
	buttons = [0, 0, 0]
	buttons[2] = 1
	$CanvasLayer/vent1/Select.hide()
	$CanvasLayer/vent2/Select.hide()
	$CanvasLayer/vent3/Select.show()
	$CanvasLayer/vent3.play("up")
