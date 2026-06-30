extends "res://scripts/wolf_base.gd"

var running : bool = false
var direction

signal brake_window

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	match state:
		State.RUN_AWAY:
			velocity = direction * speed
		State.IDLE:
			velocity.x = move_toward(velocity.x, 0, speed)
			velocity.y = move_toward(velocity.y, 0, speed)
	

func spawn():
	super.spawn()
	numb = randi_range(0, 9)
	position = global.windows[numb]
	if numb in [0, 5]:
		$AnimatedSprite2D.play("right")
	if numb in [1, 2, 6, 7]:
		$AnimatedSprite2D.play("up")
	if numb == 3:
		$AnimatedSprite2D.play("left")
	if numb in [4, 8, 9]:
		$AnimatedSprite2D.play("down")

func run_away():
	$PassiveTimer.stop()
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
	$SpawnTimer.start()

func _on_passive_timer_timeout() -> void:
	super._on_passive_timer_timeout()
	brake_window.emit()
