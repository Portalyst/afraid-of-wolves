extends Area2D

enum State {START, HIDE, SHOW}
var state := State.START

var wolf
var objects : Array = []

func _process(delta: float) -> void:
	match state:
		State.START:
			pass
		State.HIDE:
			if self.modulate.a8 != 0:
				self.modulate.a8 -= 20
				for i in objects:
					if i:
						i.modulate.a8 += 21.25
						if i.modulate.a8 == 252:
							i.modulate.a8 = 255
						
		State.SHOW:
			if self.modulate.a8 != 240:
				self.modulate.a8 += 20
				for i in objects:
					if i:
						i.modulate.a8 -= 21.25

func _on_body_entered(body: Node2D) -> void:
	if body.has_meta("player"):
		state = State.HIDE
	if body.has_meta("flash") or body.has_meta("computer"):
		if body not in objects:
			objects.append(body)
			body.modulate.a8 = 0  
		#wolf = body
		#wolf.modulate.a8 = self.modulate.a8 - 240
		#wolf.modulate.a8 = wolf.modulate.a8*-1

func _on_body_exited(body: Node2D) -> void:
	if body.has_meta("player"):
		state = State.SHOW
	if body.has_meta("flash") or body.has_meta("computer"):
		var obj_to_delete = objects.find(body)
		if obj_to_delete != -1:
			objects[obj_to_delete] = null
			
		#wolf = null
