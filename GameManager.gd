class_name GameManager extends Node

var elements_unlocked: Array[Monster.MonsterType] = []
var rounds: int = 0
var game_over: bool = false

func choose_starting_elements():
	while elements_unlocked.size() < 4:
		var new_element = randi() % Monster.MonsterType.size()
		if new_element in elements_unlocked:
			continue
		else:
			elements_unlocked.append(new_element)

# Called when the node enters the scene tree for the first time.
func _ready():
	choose_starting_elements()
	print(elements_unlocked)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
