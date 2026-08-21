extends "res://scripts/wolf_base.gd"

var active : bool = false

signal brake_window

func _ready() -> void:
	super._ready()
	$AnimatedSprite2D.hide()
	set_meta("wolf", "marcus")
	spawn_tool.spawn_marcus.connect(start_spawn)

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	if active == true:
		if $ChainTimer.is_stopped():
			$ChainTimer.start(randi_range(1, 3))
		var volume = self.position.distance_to(target.position)
		volume = int(volume / 10)
		if volume >= 10:
			volume = 10
		$sounds.attenuation = volume

func spawn():
	super.spawn()
	numb = randi_range(0, 4)
	position = windows[numb]
	active = true

func run_away():
	super.run_away()
	$sounds.stop()
	active = false
	position = start_pos

func _on_chain_timer_timeout() -> void:
	$sounds.play()

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.has_meta("leveler"):
		area.charge.connect(run_away)

func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.has_meta("leveler"):
		area.charge.disconnect(run_away)

func _on_passive_timer_timeout() -> void:
	super._on_passive_timer_timeout()
	brake_window.emit()
	active = false
	$AnimatedSprite2D.show()
