extends "res://scripts/wolf_base.gd"

@export var computer : Node

signal in_vent

func _ready() -> void:
	super._ready()
	computer.block.connect(run_away)
	computer.scanning.connect(scanning)
	set_meta("wolf", "glenn")
	spawn_tool.spawn_glenn.connect(spawn)

func scanning(state: bool):
	$PassiveTimer.paused = state

func spawn(stat: int):
	super.spawn(stat)
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
	self.position = basement_pos
