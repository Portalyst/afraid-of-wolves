extends Node

var player_on_floor : int = 1
var wolf_on_floor : int = 1

var windows : Array

func _ready() -> void:
	var window0 : Vector2 = $/root/level/Markers/WindowMarker.position
	var window1 : Vector2 = $/root/level/Markers/WindowMarker1.position
	var window2 : Vector2 = $/root/level/Markers/WindowMarker2.position
	var window3 : Vector2 = $/root/level/Markers/WindowMarker3.position
	var window4 : Vector2 = $/root/level/Markers/WindowMarker4.position
	var window5 : Vector2 = $/root/level/Markers/WindowMarker5.position
	var window6 : Vector2 = $/root/level/Markers/WindowMarker6.position
	var window7 : Vector2 = $/root/level/Markers/WindowMarker7.position
	var window8 : Vector2 = $/root/level/Markers/WindowMarker8.position
	var window9 : Vector2 = $/root/level/Markers/WindowMarker9.position
	windows = [window0, window1, window2, window3, window4, window5, window6, window7, window8, window9]
	
