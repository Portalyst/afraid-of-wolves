extends "res://scripts/wolf_base.gd"

var active : bool = false

signal brake_window

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	if active == true:
		if $ChainTimer.is_stopped():
			$ChainTimer.start(randi_range(1, 3))
		var volume = self.position.distance_to(target.position)
		volume = int(volume / 10)
		if volume >= 30:
			volume = 30
		$AudioStreamPlayer2D.attenuation = volume
		print(volume)

func spawn():
	super.spawn()
	numb = randi_range(0, 4)
	position = global.windows[numb]
	active = true

func run_away():
	active = false
	$PassiveTimer.stop()
	$SpawnTimer.start()

func _on_chain_timer_timeout() -> void:
	$AudioStreamPlayer2D.play()

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
