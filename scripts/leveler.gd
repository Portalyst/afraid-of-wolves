extends Area2D

@export var inverted : bool = false
var active : bool = false
var stuck : bool = false

signal charge
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_meta("leveler", 1)
	if inverted == true:
		$leveler.hide()
	else:
		$leveler0.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func use(selected: Array):
	if active == false:
		$LightTimer.start()
		$LightEndTimer.start()
		$leveler.play("down")
		$leveler0.play("down")
		active = true
		charge.emit()
	if stuck == true and active == true and selected[0] == 1:
		anim_up()
		stuck = false

func _on_body_entered(body: Node2D) -> void:
	if body.has_meta("player"):
		body.use.connect(use)

func _on_body_exited(body: Node2D) -> void:
	if body.has_meta("player"):
		body.use.disconnect(use)

func _on_light_timer_timeout() -> void:
	$charge.visible = !$charge.visible
	$light.visible = !$light.visible

func _on_light_end_timer_timeout() -> void:
	$LightTimer.stop()
	$charge.hide()
	$light.hide()
	var i := randi_range(0, 4)
	if i == 0:
		stuck = true
	else:
		anim_up()

func anim_up() -> void:
	if inverted == false:
		if stuck == true:
			$leveler.play("add_frame")
			await $leveler.animation_finished
		$leveler.play("up0")
		await $leveler.animation_finished
		$leveler.play("up1")
		await $leveler.animation_finished
		active = false
	else:
		if stuck == true:
			$leveler0.play("add_frame")
			await $leveler0.animation_finished
		$leveler0.play("up0")
		await $leveler0.animation_finished
		$leveler0.play("up1")
		await $leveler0.animation_finished
		active = false
