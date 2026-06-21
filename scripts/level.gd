extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_trigger_up_body_entered(body: Node2D) -> void:
	body.position += Vector2(736, 0)

func _on_trigger_down_body_entered(body: Node2D) -> void:
	body.position -= Vector2(736, 0)
