extends "res://scripts/wolf_base.gd"

@export var computer : Node

signal in_vent

func _ready() -> void:
	super._ready()
	computer.block.connect(run_away)

func spawn():
	super.spawn()
	var vent := randi_range(0, 2)
	in_vent.emit(vent)

func run_away():
	$PassiveTimer.stop()
	$SpawnTimer.start()
