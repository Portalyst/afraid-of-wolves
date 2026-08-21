extends CharacterBody2D

enum State {IDLE, RUN_AWAY, AGGRESIVE}

var state := State.IDLE

var start_pos : Vector2

var speed = 100
var numb : int
var aggresive : bool = false

signal bite(String)
signal wolf_run_away(String)

var stairs_up_position : Vector2 = Vector2(80, -120)
var stairs_down_position : Vector2 = Vector2(815, -90)

@export var Name : String
@export var target : Node
@export var spawn_tool : Node

@onready var basement_pos = $/root/level/Markers/basement_marker.position
@onready var window0 : Vector2 = $/root/level/Markers/WindowMarker.position
@onready var window1 : Vector2 = $/root/level/Markers/WindowMarker1.position
@onready var window2 : Vector2 = $/root/level/Markers/WindowMarker2.position
@onready var window3 : Vector2 = $/root/level/Markers/WindowMarker3.position
@onready var window4 : Vector2 = $/root/level/Markers/WindowMarker4.position
@onready var window5 : Vector2 = $/root/level/Markers/WindowMarker5.position #floor two window number 1
@onready var window6 : Vector2 = $/root/level/Markers/WindowMarker6.position
@onready var window7 : Vector2 = $/root/level/Markers/WindowMarker7.position
@onready var window8 : Vector2 = $/root/level/Markers/WindowMarker8.position
@onready var window9 : Vector2 = $/root/level/Markers/WindowMarker9.position
@onready var windows = [window0, window1, window2, window3, window4, window5, window6, window7, window8, window9]

func _ready() -> void:
	set_meta("wolf", Name)
	start_pos = position
	$NavigationAgent2D.target_position = target.position
	

func _physics_process(delta: float) -> void:
	if global.wolf_breach == true and state != State.AGGRESIVE:
		self.queue_free()
	match state:
		State.AGGRESIVE:
			modulate.a8 = 255
			$NavigationAgent2D.target_position = target.position
			if global.wolf_on_floor != global.player_on_floor:
				if global.wolf_on_floor == 1:
					$NavigationAgent2D.target_position = stairs_up_position
				if global.wolf_on_floor == 2:
					$NavigationAgent2D.target_position = stairs_down_position
			if !$NavigationAgent2D.is_target_reached():
				var nav_direction = to_local($NavigationAgent2D.get_next_path_position()).normalized()
				var anim_direction = target.position - self.position
				if abs(anim_direction.x) > abs(anim_direction.y):
					if anim_direction.x > 0:
						$AnimatedSprite2D.play("right")
					if anim_direction.x < 0:
						$AnimatedSprite2D.play("left")
				if abs(anim_direction.x) < abs(anim_direction.y):
					if anim_direction.y < 0:
						$AnimatedSprite2D.play("up")
					if anim_direction.y > 0:
						$AnimatedSprite2D.play("down")
				velocity = nav_direction * speed * 1.5
	move_and_slide()

func start_spawn():
	var delay := randi_range(1, 5)
	var number_sign = [-1, 1].pick_random()
	$SpawnTimer.wait_time += delay*number_sign
	$SpawnTimer.start()
	$spawn_sound.play()

func spawn():
	$sounds.play()
	$PassiveTimer.start()

func run_away():
	$run_away_sound.play()
	$PassiveTimer.stop()
	wolf_run_away.emit(Name)

func _on_spawn_timer_timeout() -> void:
	if global.wolves_can_spawn == true:
		spawn()
	else:
		start_spawn()

func _on_passive_timer_timeout() -> void:
	state = State.AGGRESIVE
	global.wolf_breach = true

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_meta("player") and state == State.AGGRESIVE:
		bite.emit(Name)
