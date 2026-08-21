extends Node2D

var wolf : String = global.wolf_who_kill
var skipable : bool = false

func _ready() -> void:
	$Black.show()
	$screamer.show()
	$AnimationPlayer.play("game_over")
	$wolf_hint.play(wolf)
	$who.play(wolf)
	$screamer.play(wolf)
	$Timer.start(1.5)
	await $Timer.timeout
	$screamer.stop()
	$screamer.hide()
	$AnimationFade.play("fade_out")
	#await $AnimationPlayer.animation_finished
	skipable = true
	$Timer2.start(10)

func back_to_menu():
	if skipable == true:
		$AnimationFade.play("fade_in")
		await $AnimationFade.animation_finished
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _on_next_button_pressed() -> void:
	back_to_menu()

func _on_timer_2_timeout() -> void:
	back_to_menu()
