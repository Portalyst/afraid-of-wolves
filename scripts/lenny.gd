extends "res://scripts/wolf_base.gd"

var running : bool = false
var direction

signal brake_window

func _ready() -> void:
	super._ready()
	set_meta("wolf", "lenny")
	spawn_tool.spawn_lenny.connect(start_spawn)

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	match state:
		State.RUN_AWAY:
			velocity = direction * speed
		State.IDLE:
			velocity.x = move_toward(velocity.x, 0, speed)
			velocity.y = move_toward(velocity.y, 0, speed)
	

func start_spawn():
	var volume = self.position.distance_to(target.position)
	volume = int(volume / 10)
	if volume >= 10:
		volume = 10
	$spawn_sound.attenuation = volume
	super.start_spawn()

func spawn():
	super.spawn()
	numb = randi_range(0, 9)
	position = windows[numb]
	if numb in [0, 5]:
		$AnimatedSprite2D.play("idle_right")
	if numb in [1, 2, 6, 7]:
		$AnimatedSprite2D.play("idle_up")
	if numb == 3:
		$AnimatedSprite2D.play("idle_left")
	if numb in [4, 8, 9]:
		$AnimatedSprite2D.play("idle_down")

func run_away():
	super.run_away()
	if numb in [0, 5]:
		direction = Vector2(-1, 0)
		$AnimatedSprite2D.play("left")
	if numb in [1, 2, 6, 7]:
		direction = Vector2(0, 1)
		$AnimatedSprite2D.play("down")
	if numb == 3:
		direction = Vector2(1, 0)
		$AnimatedSprite2D.play("right")
	if numb in [4, 8, 9]:
		direction = Vector2(0, -1)
		$AnimatedSprite2D.play("up")
	state = State.RUN_AWAY
	$Timer.start()

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.has_meta("leveler"):
		area.charge.connect(run_away)

func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.has_meta("leveler"):
		area.charge.disconnect(run_away)

func _on_timer_timeout() -> void:
	state = State.IDLE
	position = start_pos
	wolf_run_away.emit("lenny")
	#$SpawnTimer.start()

func _on_passive_timer_timeout() -> void:
	super._on_passive_timer_timeout()
	brake_window.emit()
