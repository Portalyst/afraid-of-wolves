extends Area2D

enum State {IDLE, HIDE, SHOW}

var state := State.IDLE

func _process(delta: float) -> void:
	match state:
		State.IDLE:
			pass
		State.HIDE:
			while self.modulate.a != 0:
				self.modulate.a -= 1
			state = State.IDLE
		State.SHOW:
			while self.modulate.a != 233:
				self.modulate.a += 1
			state = State.IDLE

func _on_body_entered(body: Node2D) -> void:
	if body.has_meta("player"):
		state = State.HIDE

func _on_body_exited(body: Node2D) -> void:
	if body.has_meta("player"):
		state = State.SHOW
