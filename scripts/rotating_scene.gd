extends Node2D

func _ready() -> void:
	#$marcus.play("down")
	#$lenny.play("down")
	#$glenn.play("down")
	$Timer.start()

func _on_timer_timeout() -> void:
	print($marcus.animation == "down")
	if $marcus.animation == "down":
		print("gui")
		$marcus.play("right")
		$lenny.play("right")
		$glenn.play("right")
		$Timer.start()
		return
	if $marcus.animation == "right":
		$marcus.play("up")
		$lenny.play("up")
		$glenn.play("up")
		$Timer.start()
		return
	if $marcus.animation == "up":
		$marcus.play("left")
		$lenny.play("left")
		$glenn.play("left")
		$Timer.start()
		return
	if $marcus.animation == "left":
		$marcus.play("down")
		$lenny.play("down")
		$glenn.play("down")
		$Timer.start()
		return
