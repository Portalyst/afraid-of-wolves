extends StaticBody2D

var locked : bool = false
var opened : bool = false

func _ready() -> void:
	$CollisionShape2D.queue_free()

	

func _on_down_trigger_body_entered(body: Node2D) -> void:
	if body.has_meta("player"):
		$AnimatedSprite2D.play("open_up")
		$up_trigger.monitoring = false

func _on_down_trigger_body_exited(body: Node2D) -> void:
	if body.has_meta("player"):
		$AnimatedSprite2D.play("close_up")
		await $AnimatedSprite2D.animation_finished
		$up_trigger.monitoring = true

func _on_up_trigger_body_entered(body: Node2D) -> void:
	if body.has_meta("player"):
		$AnimatedSprite2D.play("open_down")
		$down_trigger.monitoring = false

func _on_up_trigger_body_exited(body: Node2D) -> void:
	if body.has_meta("player"):
		$AnimatedSprite2D.play("close_down")
		await $AnimatedSprite2D.animation_finished
		$down_trigger.monitoring = true
