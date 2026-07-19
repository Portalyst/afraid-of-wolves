extends StaticBody2D

@export_enum("0", "1") var type : String

var locked : bool = true

func _ready() -> void:
	set_meta("door", 1)
	$AnimatedSprite2D.play("close_down_"+type)
	if type == "1":
		$AnimationPlayer.queue_free()
		$CollisionShape2D.queue_free()
		$Lock.queue_free()
		$down_trigger.monitoring = true
		$up_trigger.monitoring = true
		locked = false

func unlock(selected : Array):
	if selected[0] == 1 and locked == true:
		$AnimationPlayer.play("unlock")
		locked = false
		$down_trigger.monitoring = true
		$up_trigger.monitoring = true
		$CollisionShape2D.queue_free()

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

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_meta("player"):
		body.use.connect(unlock)

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.has_meta("player"):
		body.use.disconnect(unlock)
