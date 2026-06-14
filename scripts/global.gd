extends Node



var windows : Array

func _ready() -> void:
	var window0 : Vector2 = $/root/level/WindowMarker.position
	var window1 : Vector2 = $/root/level/WindowMarker1.position
	var window2 : Vector2 = $/root/level/WindowMarker2.position
	var window3 : Vector2 = $/root/level/WindowMarker3.position
	var window4 : Vector2 = $/root/level/WindowMarker4.position
	windows = [window0, window1, window2, window3, window4]
	print(windows)
