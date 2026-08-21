extends Node2D

var selected : Array = [1, 0, 0]

func _ready() -> void:
	if global.death_wish_unlocked == false:
		$DeathWish.hide()

func _process(delta: float) -> void:
	$arrows/story_mode.hide()
	$arrows/easy.hide()
	$arrows/normal.hide()
	$arrows/hard.hide()
	$arrows/death_wish.hide()
	match global.mode:
		global.DIFFICULT.story:
			$arrows/story_mode.visible = true
		global.DIFFICULT.easy:
			$arrows/easy.visible = true
		global.DIFFICULT.normal:
			$arrows/normal.visible = true
		global.DIFFICULT.hard:
			$arrows/hard.visible = true
		global.DIFFICULT.death_wish:
			$arrows/death_wish.visible = true

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

func _on_difficulty_button_mouse_entered() -> void:
	$difficulty.play("down")

func _on_difficulty_button_mouse_exited() -> void:
	$difficulty.play("up")

func _on_difficulty_button_pressed() -> void:
	$AnimationPlayer.play("difficulty")

func _on_back_button_2_mouse_entered() -> void:
	$back2.play("down")

func _on_back_button_2_mouse_exited() -> void:
	$back2.play("up")

func _on_back_button_2_pressed() -> void:
	$AnimationPlayer.play("back2")

func _on_map_0_button_mouse_entered() -> void:
	$Map0.position.y += 1

func _on_map_0_button_mouse_exited() -> void:
	$Map0.position.y -= 1

func _on_map_0_button_pressed() -> void:
	$AnimationPlayer.play("map_selected")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file("res://scenes/level.tscn")

func _on_map_1_button_mouse_entered() -> void:
	$Map1.position.y += 1
	$MapLock1.position.y += 1
	$MapShadow1.position.y += 1

func _on_map_1_button_mouse_exited() -> void:
	$Map1.position.y -= 1
	$MapLock1.position.y -= 1
	$MapShadow1.position.y -= 1

func _on_map_1_button_pressed() -> void:
	$AnimationMapLock1.play("shake")

func _on_map_2_button_mouse_entered() -> void:
	$Map2.position.y += 1
	$MapLock2.position.y += 1
	$MapShadow2.position.y += 1

func _on_map_2_button_mouse_exited() -> void:
	$Map2.position.y -= 1
	$MapLock2.position.y -= 1
	$MapShadow2.position.y -= 1

func _on_map_2_button_pressed() -> void:
	$AnimationMapLock2.play("shake")

func _on_map_3_button_mouse_entered() -> void:
	$Map3.position.y += 1
	$MapLock3.position.y += 1
	$MapShadow3.position.y += 1

func _on_map_3_button_mouse_exited() -> void:
	$Map3.position.y -= 1
	$MapLock3.position.y -= 1
	$MapShadow3.position.y -= 1

func _on_map_3_button_pressed() -> void:
	$AnimationMapLock3.play("shake")

func _on_map_4_button_mouse_entered() -> void:
	$Map4.position.y += 1
	$MapLock4.position.y += 1
	$MapShadow4.position.y += 1

func _on_map_4_button_mouse_exited() -> void:
	$Map4.position.y -= 1
	$MapLock4.position.y -= 1
	$MapShadow4.position.y -= 1

func _on_map_4_button_pressed() -> void:
	$AnimationMapLock4.play("shake")

func _on_story_mode_button_pressed() -> void:
	#global.mode = global.DIFFICULT.story
	pass

func _on_easy_button_pressed() -> void:
	global.mode = global.DIFFICULT.easy

func _on_normal_button_pressed() -> void:
	global.mode = global.DIFFICULT.normal

func _on_hard_button_pressed() -> void:
	global.mode = global.DIFFICULT.hard

func _on_death_wish_button_pressed() -> void:
	if global.death_wish_unlocked == true:
		global.mode = global.DIFFICULT.death_wish

func _on_selection_0_button_mouse_entered() -> void:
	if $selection0.animation != "selected":
		$selection0.play("entered")

func _on_selection_0_button_mouse_exited() -> void:
	if $selection0.animation != "selected":
		$selection0.play("exited")

func _on_selection_0_button_pressed() -> void:
	global.thunderstorm = !global.thunderstorm
	if $selection0.animation == "entered":
		$selection0.play("selected")
		return
	if $selection0.animation == "selected":
		$selection0.play("exited")
		return

func _on_selection_1_button_mouse_entered() -> void:
	if $selection1.animation != "selected":
		$selection1.play("entered")

func _on_selection_1_button_mouse_exited() -> void:
	if $selection1.animation != "selected":
		$selection1.play("exited")

func _on_selection_1_button_pressed() -> void:
	global.faulty_levers = !global.faulty_levers
	if $selection1.animation == "entered":
		$selection1.play("selected")
		return
	if $selection1.animation == "selected":
		$selection1.play("exited")
		return

func _on_selection_2_button_mouse_entered() -> void:
	if $selection2.animation != "selected":
		$selection2.play("entered")

func _on_selection_2_button_mouse_exited() -> void:
	if $selection2.animation != "selected":
		$selection2.play("exited")

func _on_selection_2_button_pressed() -> void:
	global.computer_modifier = !global.computer_modifier
	if $selection2.animation == "entered":
		$selection2.play("selected")
		return
	if $selection2.animation == "selected":
		$selection2.play("exited")
		return

func _on_selection_3_button_mouse_entered() -> void:
	if $selection3.animation != "selected":
		$selection3.play("entered")

func _on_selection_3_button_mouse_exited() -> void:
	if $selection3.animation != "selected":
		$selection3.play("exited")

func _on_selection_3_button_pressed() -> void:
	global.sounds_modifier = !global.sounds_modifier
	if $selection3.animation == "entered":
		$selection3.play("selected")
		return
	if $selection3.animation == "selected":
		$selection3.play("exited")
		return

func _on_selection_4_button_mouse_entered() -> void:
	if $selection4.animation != "selected":
		$selection4.play("entered")

func _on_selection_4_button_mouse_exited() -> void:
	if $selection4.animation != "selected":
		$selection4.play("exited")

func _on_selection_4_button_pressed() -> void:
	global.lights_off = !global.lights_off
	if $selection4.animation == "entered":
		$selection4.play("selected")
		return
	if $selection4.animation == "selected":
		$selection4.play("exited")
		return
