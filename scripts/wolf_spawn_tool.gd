extends Node

@export var lenny : Node
@export var marcus : Node
@export var glenn : Node

@export var game_tool : Node

signal spawn_lenny
signal spawn_marcus
signal spawn_glenn

#var wolves_spawned : Array= []
var wolves : Array = ["Lenny", "Marcus", "Glenn"]

var glenn_and_marcus : bool = false

var lenny_aggresive : int = 2
var marcus_aggresive : int = 2
var glenn_aggresive : int = 2

var lenny_path : int = 0
var marcus_path : int = 0
var glenn_path : int = 0

func _ready() -> void:
	$start_delay.start(60)
	$spawn_delay.start(5)
	lenny.wolf_run_away.connect(wolves_run_away)
	marcus.wolf_run_away.connect(wolves_run_away)
	glenn.wolf_run_away.connect(wolves_run_away)
	lenny.breach.connect(breach)
	marcus.breach.connect(breach)
	glenn.breach.connect(breach)

func _process(delta: float) -> void:
	$CanvasLayer/Label.text = "lp: "+str(lenny_path)+" mp: "+str(marcus_path)+" gp: "+str(glenn_path)

func breach():
	game_tool.queue_free()

func wolves_run_away(wolf: String):
	if wolf == "lenny":
		lenny_path = 0
		var chance = randi_range(0, 1)
		if chance == 0:
			lenny_aggresive += 1
	if wolf == "marcus":
		marcus_path = 0
		var chance = randi_range(0, 1)
		if chance == 0:
			marcus_aggresive += 1
	if wolf == "glenn":
		glenn_path = 0
		var chance = randi_range(0, 3)
		if chance == 0:
			glenn_aggresive += 1
	global.wolves_can_spawn = true
	#wolves_spawned.erase(wolf)
	#if wolves_spawned == []:
		#$start_delay.start(randi_range(8, 12))

func _on_start_delay_timeout() -> void:
	glenn_and_marcus = true
	#var spawn_list : Array = ["lenny", "marcus", "glenn"]
	##var spawn_list : Array = ["marcus"]
	#var amount_wolves := randi_range(1, 3)
	#print(amount_wolves)
	#for i in amount_wolves:
		#$spawn_delay.start(randi_range(0, 3))
		#await $spawn_delay.timeout
		#var spawn_hand = spawn_list.pick_random()
		#spawn_list.erase(spawn_hand)
		#wolves_spawned.append(spawn_hand)
		#if spawn_hand == "lenny":
			#spawn_lenny.emit()
			#print("lenny spawn")
		#if spawn_hand == "marcus":
			#spawn_marcus.emit()
			#print("marcus spawn")
		#if spawn_hand == "glenn":
			#spawn_glenn.emit()
			#print("glenn spawn")

func _on_spawn_delay_timeout() -> void:
	if global.wolves_can_spawn == true:
		for i in wolves:
			if i == "Lenny":
				var chance := randi_range(0, 19)
				if chance <= lenny_aggresive:
					lenny_path += 1
					if lenny_path == 1:
						$lenny_howl.play()
					if lenny_path == 2:
						$drone.play()
					if lenny_path == 3:
						spawn_lenny.emit(lenny_aggresive)
			if glenn_and_marcus == true:
				if i == "Marcus":
					var chance := randi_range(0, 19)
					if chance <= marcus_aggresive:
						marcus_path += 1
						if marcus_path == 1:
							$marcus_howl.play()
						if marcus_path == 2:
							$drone.play()
						if marcus_path == 3:
							spawn_marcus.emit(marcus_aggresive)
				if i == "Glenn":
					var chance := randi_range(0, 19)
					if chance <= glenn_aggresive:
						glenn_path += 1
						if glenn_path == 1:
							$glenn_howl.play()
						if glenn_path == 2:
							$drone.play()
						if glenn_path == 3:
							spawn_glenn.emit(glenn_aggresive)
