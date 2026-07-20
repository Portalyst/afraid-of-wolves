extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$shadows.show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_trigger_up_body_entered(body: Node2D) -> void:
	if body.has_meta("player"):
		body.position += Vector2(736, 0)
		$shadows/mainshadow.modulate.a8 = 0
	if body.has_meta("wolf"):
		body.position += Vector2(736, 0)

func _on_trigger_down_body_entered(body: Node2D) -> void:
	if body.has_meta("player") or body.has_meta("wolf"):
		body.position -= Vector2(736, 0)

func _on_on_floor_1_body_entered(body: Node2D) -> void:
	if body.has_meta("player"):
		global.player_on_floor = 1
	if body.has_meta("wolf"):
		global.wolf_on_floor = 1

func _on_on_floor_2_body_entered(body: Node2D) -> void:
	if body.has_meta("player"):
		global.player_on_floor = 2
	if body.has_meta("wolf"):
		global.wolf_on_floor = 2
