extends CharacterBody2D


var speed = 100

var numb : int
var running : bool = false
var direction

signal brake_window

func _ready() -> void:
	set_meta("wolf", 1)
	spawn()
	$PassiveTimer.start()

func _physics_process(delta: float) -> void:
	if running == true:
		velocity = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.y = move_toward(velocity.y, 0, speed)
	move_and_slide()

func spawn():
	numb = randi_range(0, 4)
	position = global.windows[numb]

func run_away():
	$PassiveTimer.stop()
	print($PassiveTimer.time_left)
	if numb == 0:
		direction = Vector2(-1, 0)
	if numb == 1 or numb == 2:
		direction = Vector2(0, 1)
	if numb == 3:
		direction = Vector2(1, 0)
	if numb == 4:
		direction = Vector2(0, -1)
	running = true
	$Timer.start()

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.has_meta("leveler"):
		area.charge.connect(run_away)

func _on_timer_timeout() -> void:
	running = false
	$SpawnTimer.start()

func _on_spawn_timer_timeout() -> void:
	spawn()

func _on_passive_timer_timeout() -> void:
	brake_window.emit()
	print("brake")
