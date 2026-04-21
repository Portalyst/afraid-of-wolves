extends CharacterBody2D

var speed : int = 60

signal use

func _ready() -> void:
	set_meta("player", 1)

func _physics_process(delta: float) -> void:
	var direction := Vector2(Input.get_axis("left", "right"), Input.get_axis("up", "down"))
	var anim_dir := ""
	speed = 60
	
	if Input.is_action_just_pressed("use"):
		use.emit()
	
	if Input.is_action_pressed("run"):
		speed = 80

	if Input.is_action_pressed("down"):
		anim_dir = "d"
	if Input.is_action_pressed("up"):
		anim_dir = "u"
	if Input.is_action_pressed("left"):
		anim_dir = "l"
	if Input.is_action_pressed("right"):
		anim_dir = "r"
	
	if direction:
		velocity = direction * speed
		if speed <= 60:
			$AnimatedSprite2D.play("run_"+anim_dir)
		if speed > 60:
			$AnimatedSprite2D.play("fastrun_"+anim_dir)
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.y = move_toward(velocity.y, 0, speed)
		$AnimatedSprite2D.play("idle")
	move_and_slide()
