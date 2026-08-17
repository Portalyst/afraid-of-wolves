extends Node2D

var selected : Array = [1, 0, 0]

func move_arrows():
	if selected[0] == 1:
		$arrows/start.show()
	if selected[0] == 0:
		$arrows/start.hide()
	if selected[1] == 1:
		$arrows/settings.show()
	if selected[1] == 0:
		$arrows/settings.hide()
	if selected[2] == 1:
		$arrows/quit.show()
	if selected[2] == 0:
		$arrows/quit.hide()

func _on_start_mouse_entered() -> void:
	selected = [1, 0, 0]
	move_arrows()

func _on_settings_mouse_entered() -> void:
	selected = [0, 1, 0]
	move_arrows()

func _on_quit_mouse_entered() -> void:
	selected = [0, 0, 1]
	move_arrows()

func _on_start_pressed() -> void:
	$AnimationPlayer.play("start")

func _on_settings_pressed() -> void:
	pass # Replace with function body.

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_back_button_mouse_entered() -> void:
	$back.play("down")

func _on_back_button_mouse_exited() -> void:
	$back.play("up")

func _on_back_button_pressed() -> void:
	$AnimationPlayer.play("back")
