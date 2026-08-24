extends Node2D

func _ready() -> void:
	$fade.show()
	$fade_player.play("fade_out")
	match global.mode:
		global.DIFFICULT.easy:
			if global.diff_mods == 0:
				$rank.play("c")
			if global.diff_mods == 1:
				$rank.play("b")
			if global.diff_mods == 2:
				$rank.play("a")
			if global.diff_mods in [3, 4, 5]:
				$rank.play("s")
			$difficulty_sprite.play("easy")
		global.DIFFICULT.normal:
			if global.diff_mods == 0:
				$rank.play("b")
			if global.diff_mods == 1:
				$rank.play("a")
			if global.diff_mods in [2, 3]:
				$rank.play("s")
			if global.diff_mods in [4, 5]:
				$rank.play("sp")
			$difficulty_sprite.play("normal")
		global.DIFFICULT.hard:
			if global.diff_mods == 0:
				$rank.play("a")
			if global.diff_mods in [1, 2]:
				$rank.play("s")
			if global.diff_mods == 3:
				$rank.play("sp")
			if global.diff_mods in [4, 5]:
				$rank.play("spp")
			$difficulty_sprite.play("hard")
		global.DIFFICULT.death_wish:
			if global.diff_mods in [0, 1]:
				$rank.play("s")
			if global.diff_mods == 2:
				$rank.play("sp")
			if global.diff_mods in [3, 4]:
				$rank.play("spp")
			if global.diff_mods == 5:
				$rank.play("p")
			$difficulty_sprite.play("death_wish")
	$amount_of_modifiers.play(str(global.diff_mods))
	global.maps[global.current_map] = $rank.animation

func _on_next_button_pressed() -> void:
	$fade_player.play("fade_in")
	await $fade_player.animation_finished
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	
	
