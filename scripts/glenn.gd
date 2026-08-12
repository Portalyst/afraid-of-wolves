extends "res://scripts/wolf_base.gd"

@export var computer : Node

signal in_vent

func _ready() -> void:
	super._ready()
	computer.block.connect(run_away)
	set_meta("wolf", "glenn")
	spawn_tool.spawn_glenn.connect(start_spawn)

func spawn():
	super.spawn()
	var vent := randi_range(0, 2)
	in_vent.emit(vent)
	global.wolves_can_spawn = false

func run_away():
	super.run_away()
	global.wolves_can_spawn = true
	#$SpawnTimer.start()
	#print("hui")

func _on_passive_timer_timeout() -> void:
	super._on_passive_timer_timeout()
	self.position = global.basement_pos
