extends StaticBody2D

@export var game_tool : Node

func _process(delta: float) -> void:
	$Arrow0.rotation_degrees = game_tool.game_time/2
	$Arrow1.rotation_degrees = game_tool.game_time*6
	#print($Arrow0.rotation_degrees," " ,game_tool.game_time)
