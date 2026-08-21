extends Node

@export var lenny : Node
@export var marcus : Node
@export var glenn : Node

signal spawn_lenny
signal spawn_marcus
signal spawn_glenn

var wolves_spawned : Array= []


func _ready() -> void:
	$start_delay.start(randi_range(12, 20))
	lenny.wolf_run_away.connect(wolves_run_away)
	marcus.wolf_run_away.connect(wolves_run_away)
	glenn.wolf_run_away.connect(wolves_run_away)

func wolves_run_away(wolf: String):
	wolves_spawned.erase(wolf)
	if wolves_spawned == []:
		$start_delay.start(randi_range(8, 12))

func _on_start_delay_timeout() -> void:
	var spawn_list : Array = ["lenny", "marcus", "glenn"]
	#var spawn_list : Array = ["marcus"]
	var amount_wolves := randi_range(1, 3)
	print(amount_wolves)
	for i in amount_wolves:
		$spawn_delay.start(randi_range(0, 3))
		await $spawn_delay.timeout
		var spawn_hand = spawn_list.pick_random()
		spawn_list.erase(spawn_hand)
		wolves_spawned.append(spawn_hand)
		if spawn_hand == "lenny":
			spawn_lenny.emit()
			print("lenny spawn")
		if spawn_hand == "marcus":
			spawn_marcus.emit()
			print("marcus spawn")
		if spawn_hand == "glenn":
			spawn_glenn.emit()
			print("glenn spawn")
