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
	
func show_element_modal(element: Monster.MonsterType):
	var popup = $"../Popups/YouGot"
	for element_idx in Monster.MonsterType.size():
		var show = Monster.MonsterType.values()[element_idx]
		popup.icon_nodes[element_idx].set_visible(show == element)
	popup.set_visible(true)
	var time_in_seconds = 3
	await get_tree().create_timer(time_in_seconds).timeout
	popup.set_visible(false)
	
func battle_win(enemy: Monster):
	var book: Book = $"../Book"
	if enemy.primary_type not in book.elements_unlocked:
		book.elements_unlocked.append(enemy.primary_type)
		book.show_available()
		show_element_modal(enemy.primary_type)
	elif enemy.secondary_type not in book.elements_unlocked:
		book.elements_unlocked.append(enemy.secondary_type)
		book.show_available()
		show_element_modal(enemy.secondary_type)
	enemy.random_enemy()

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
		battle_win(enemy)
