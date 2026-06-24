extends CharacterBody2D


var speed = 100

var numb : int
var running : bool = false
var direction

var aggresive : bool = false

signal brake_window
signal bite

@export var target : Node

func _ready() -> void:
	set_meta("wolf", 1)
	spawn()
	$NavigationAgent2D.target_position = target.position

func _physics_process(delta: float) -> void:
	$NavigationAgent2D.target_position = target.position
	if running == true:
		velocity = direction * speed
	if running == false and aggresive == false:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.y = move_toward(velocity.y, 0, speed)
	if aggresive == true:
		if !$NavigationAgent2D.is_target_reached():
			var nav_direction = to_local($NavigationAgent2D.get_next_path_position()).normalized()
			print(nav_direction)
			if nav_direction.x < 0:
				$AnimatedSprite2D.play("left")
			if nav_direction.x > 0:
				$AnimatedSprite2D.play("right")
			if nav_direction.x < nav_direction.y:
				$AnimatedSprite2D.play("down")
			velocity = nav_direction * speed * 1.5
	move_and_slide()

func spawn():
	$PassiveTimer.start()
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
	running = true
	$Timer.start()
	#spawn()

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.has_meta("leveler"):
		area.charge.connect(run_away)

func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.has_meta("leveler"):
		area.charge.disconnect(run_away)

func _on_timer_timeout() -> void:
	running = false
	$SpawnTimer.start()

func _on_spawn_timer_timeout() -> void:
	spawn()

func _on_passive_timer_timeout() -> void:
	brake_window.emit()
	aggresive = true

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_meta("player") and aggresive == true:
		bite.emit()
