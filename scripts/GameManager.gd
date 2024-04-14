class_name GameManager extends Node

var rounds: int = 0
var game_over: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func lose():
	$"../Popups/YouLost".set_visible(true)
	var time_in_seconds = 3
	await get_tree().create_timer(time_in_seconds).timeout
	get_tree().quit()

func _on_summon_button_pressed():
	var enemy: Monster = $"../Monsters/EnemyMonster"
	var ally: Monster = $"../Monsters/AllyMonster"

	var likelyhood = enemy.defend(ally)
	var roll = randf()
	var win = roll <= likelyhood

	print("Likelyhood: ", likelyhood, " Roll: ", roll, " Win: ", win)
	
	$"../WinLabel".text = "Chance To Win:\n%2d%%" % (likelyhood * 100)
	
	if not win:
		lose()
	else:
		# battle_win()
		pass
