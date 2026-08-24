extends Node

@export var wolf_tool : Node
@export var lenny : Node
@export var marcus : Node
@export var glenn : Node

func _on_timer_timeout() -> void:
	wolf_tool.queue_free()
	lenny.queue_free()
	marcus.queue_free()
	glenn.queue_free()
	get_tree().change_scene_to_file("res://scenes/victory_menu.tscn")
