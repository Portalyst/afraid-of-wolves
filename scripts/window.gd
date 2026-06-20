extends StaticBody2D

@export var type : int = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play("window"+str(type))

func brake():
	$AnimatedSprite2D.play("windowbroken"+str(type))
	$CollisionShape2D.queue_free()
	print("broken")


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_meta("wolf"):
		body.brake_window.connect(brake)
		print("connected")
