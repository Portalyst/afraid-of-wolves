extends Node

var player_on_floor : int = 1
var wolf_on_floor : int = 1

var basement_pos : Vector2

var player_can_walk : bool = true
var player_can_flash : bool = true

var wolves_can_spawn : bool = true
var wolf_breach : bool = false

var windows : Array
var flashs : Array
var computers : Array

func _ready() -> void:
	if $/root/level/Markers/WindowMarker:
		basement_pos = $/root/level/Markers/basement_marker.position
		var window0 : Vector2 = $/root/level/Markers/WindowMarker.position
		var window1 : Vector2 = $/root/level/Markers/WindowMarker1.position
		var window2 : Vector2 = $/root/level/Markers/WindowMarker2.position
		var window3 : Vector2 = $/root/level/Markers/WindowMarker3.position
		var window4 : Vector2 = $/root/level/Markers/WindowMarker4.position
		var window5 : Vector2 = $/root/level/Markers/WindowMarker5.position #floor two window number 1
		var window6 : Vector2 = $/root/level/Markers/WindowMarker6.position
		var window7 : Vector2 = $/root/level/Markers/WindowMarker7.position
		var window8 : Vector2 = $/root/level/Markers/WindowMarker8.position
		var window9 : Vector2 = $/root/level/Markers/WindowMarker9.position
		windows = [window0, window1, window2, window3, window4, window5, window6, window7, window8, window9]
		var flash0 : Vector2 = $/root/level/Markers/flash_marker.position
		var flash1 : Vector2 = $/root/level/Markers/flash_marker2.position
		var flash2 : Vector2 = $/root/level/Markers/flash_marker3.position
		flashs = [flash0, flash1, flash2]
		var computer0 : Vector2 = $/root/level/Markers/computer_marker.position
		var computer1 : Vector2 = $/root/level/Markers/computer_marker2.position
		var computer2 : Vector2 = $/root/level/Markers/computer_marker3.position
		computers = [computer0, computer1, computer2]
