class_name GameManager extends Node

var rounds: int = 0
var game_over: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_book_player_win():
	pass # Replace with function body.

func _on_book_player_lose():
	pass # Replace with the player being a looser. Boowomp :(


func _on_summon_button_pressed():
	var enemy: Monster = $"../Monsters/EnemyMonster"
	var ally: Monster = $"../Monsters/AllyMonster"

	print(enemy.defend(ally))
