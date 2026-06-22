extends StaticBody2D

@export var type : int = 0

func _ready() -> void:
	$AnimatedSprite2D.play("window"+str(type))

func brake():
	$AnimatedSprite2D.play("windowbroken"+str(type))
	#$CollisionShape2D.queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_meta("wolf"):
		body.brake_window.connect(brake)

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.has_meta("wolf"):
		body.brake_window.disconnect(brake)
