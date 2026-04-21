extends Area2D

@export var inverted : bool = false
var active : bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if inverted == true:
		$leveler.hide()
	else:
		$leveler0.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func use():
	if active == false:
		$LightTimer.start()
		$LightEndTimer.start()
		$leveler.play("down")
		$leveler0.play("down")
		active = true

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
	if i == 1:
		pass
	else:
		if inverted == false:
			$leveler.play("up0")
			await $leveler.animation_finished
			$leveler.play("up1")
			await $leveler.animation_finished
			active = false
		else:
			$leveler0.play("up0")
			await $leveler0.animation_finished
			$leveler0.play("up1")
			await $leveler0.animation_finished
			active = false
