extends CharacterBody2D

var speed = 100
var numb : int
var aggresive : bool = false

signal bite

var stairs_up_position : Vector2 = Vector2(80, -120)
var stairs_down_position : Vector2 = Vector2(815, -90)

@export var target : Node

func _ready() -> void:
	set_meta("wolf", 1)
	spawn()
	$NavigationAgent2D.target_position = target.position

func _physics_process(delta: float) -> void:
	$NavigationAgent2D.target_position = target.position
	if global.wolf_on_floor != global.player_on_floor:
		if global.wolf_on_floor == 1:
			$NavigationAgent2D.target_position = stairs_up_position
		if global.wolf_on_floor == 2:
			$NavigationAgent2D.target_position = stairs_down_position
	if aggresive == true:
		if !$NavigationAgent2D.is_target_reached():
			var nav_direction = to_local($NavigationAgent2D.get_next_path_position()).normalized()
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
	
func _on_spawn_timer_timeout() -> void:
	spawn()

func _on_passive_timer_timeout() -> void:
	aggresive = true

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_meta("player") and aggresive == true:
		bite.emit()
