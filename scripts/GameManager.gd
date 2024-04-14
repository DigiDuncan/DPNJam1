class_name GameManager extends Node

var rounds: int = 0
var game_over: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_summon_button_pressed():
	var enemy: Monster = $"../Monsters/EnemyMonster"
	var ally: Monster = $"../Monsters/AllyMonster"

	var likelyhood = enemy.defend(ally)
	var roll = randf()
	var win = roll <= likelyhood

	print("Likelyhood: ", likelyhood, " Roll: ", roll, " Win: ", win)
	
	$"../WinLabel".text = "Chance To Win:\n%2d%%" % (likelyhood * 100)
