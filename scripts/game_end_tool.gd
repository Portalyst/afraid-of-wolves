extends Node

@export var wolf_tool : Node
@export var lenny : Node
@export var marcus : Node
@export var glenn : Node

@export var game_time : int

func _ready() -> void:
	lenny.breach.connect(breach)
	marcus.breach.connect(breach)
	glenn.breach.connect(breach)

func _process(delta: float) -> void:
	game_time = 360-$Timer.time_left
	print(global.wolf_on_floor)

func breach():
	$Timer.stop()

func _on_timer_timeout() -> void:
	wolf_tool.queue_free()
	lenny.queue_free()
	marcus.queue_free()
	glenn.queue_free()
	get_tree().change_scene_to_file("res://scenes/victory_menu.tscn")
