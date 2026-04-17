extends CharacterBody2D


var speed = 40.0


func _physics_process(delta: float) -> void:
	var direction := Vector2(Input.get_axis("ui_left", "ui_right"), Input.get_axis("ui_up", "ui_down"))
	var anim_is_playing : bool = false
	if Input.is_action_pressed("ui_down") and anim_is_playing == false:
		#direction = Vector2(0, 1)
		$AnimatedSprite2D.play("run_d")
		anim_is_playing = true
	if Input.is_action_pressed("ui_up") and anim_is_playing == false:
		#direction = Vector2(0, -1)
		$AnimatedSprite2D.play("run_u")
		anim_is_playing = true
	if Input.is_action_pressed("ui_left") and anim_is_playing == false:
		#direction = Vector2(-1, 0)
		anim_is_playing = true
		$AnimatedSprite2D.play("run_l")
	if Input.is_action_pressed("ui_right") and anim_is_playing == false:
		#direction = Vector2(1, 0)
		$AnimatedSprite2D.play("run_r")
		anim_is_playing = true
	if direction:
		velocity = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.y = move_toward(velocity.y, 0, speed)
		$AnimatedSprite2D.play("idle")
		anim_is_playing = false
	move_and_slide()
