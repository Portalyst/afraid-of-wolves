extends AnimatedSprite2D

var variant : int = randi_range(1, 32)
var power : int = randi_range(15, 20)
var speed : float = randf_range(0.2, 0.4)

func _ready() -> void:
	self.play(str(variant))
	flip_h = randi_range(0, 1)

func _process(delta: float) -> void:
	if power > 0:
		if self.rotation < deg_to_rad(power):
			self.rotate(deg_to_rad(speed))
		else:
			power = -power
	if power < 0:
		if self.rotation > deg_to_rad(power):
			self.rotate(deg_to_rad(-speed))
		else:
			power = -power
