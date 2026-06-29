extends StaticBody2D

@export_enum("0", "1") var type : String

var locked : bool = false
var opened : bool = false

func _ready() -> void:
	$CollisionShape2D.queue_free()
	$AnimatedSprite2D.play("close_down_"+type)

func _on_down_trigger_body_entered(body: Node2D) -> void:
	if body.has_meta("player"):
		$AnimatedSprite2D.play("open_up_"+type)
		$up_trigger.monitoring = false

func _on_down_trigger_body_exited(body: Node2D) -> void:
	if body.has_meta("player"):
		$AnimatedSprite2D.play("close_up_"+type)
		await $AnimatedSprite2D.animation_finished
		$up_trigger.monitoring = true

func _on_up_trigger_body_entered(body: Node2D) -> void:
	if body.has_meta("player"):
		$AnimatedSprite2D.play("open_down_"+type)
		$down_trigger.monitoring = false

func _on_up_trigger_body_exited(body: Node2D) -> void:
	if body.has_meta("player"):
		$AnimatedSprite2D.play("close_down_"+type)
		await $AnimatedSprite2D.animation_finished
		$down_trigger.monitoring = true
