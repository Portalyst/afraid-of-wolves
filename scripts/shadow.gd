extends Area2D

enum State {START, HIDE, SHOW}
var state := State.START

func _process(delta: float) -> void:
	match state:
		State.START:
			pass
		State.HIDE:
			if self.modulate.a8 != 0:
				self.modulate.a8 -= 20
		State.SHOW:
			if self.modulate.a8 != 240:
				self.modulate.a8 += 20

func _on_body_entered(body: Node2D) -> void:
	if body.has_meta("player"):
		state = State.HIDE

func _on_body_exited(body: Node2D) -> void:
	if body.has_meta("player"):
		state = State.SHOW
