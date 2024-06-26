class_name GameManager extends Node

# TODO: This class uses $/get_node kinda egregiously,
# but to be fair, that's party because it should have been
# the parent object. Also because I need to learn signals better.

var rounds: int = 1
var game_over: bool = false
var lives: int = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func lose():
	$"../Popups/YouLost".set_visible(true)
	$"../Sounds/Lose".play()
	$"../Book".set_visible(false)
	var time_in_seconds = 3
	await get_tree().create_timer(time_in_seconds).timeout
	get_tree().change_scene_to_file("res://menu.tscn")
	
func win():
	$"../Popups/YouWon".set_visible(true)
	$"../Sounds/Win".play()
	$"../Book".set_visible(false)
	var time_in_seconds = 3
	await get_tree().create_timer(time_in_seconds).timeout
	get_tree().change_scene_to_file("res://menu.tscn")
	
func show_element_modal(element: Monster.MonsterType):
	var popup = $"../Popups/YouGot"
	for element_idx in Monster.MonsterType.size():
		var show = Monster.MonsterType.values()[element_idx]
		popup.icon_nodes[element_idx].set_visible(show == element)
	popup.set_visible(true)
	var time_in_seconds = 3
	$"../Sounds/ElementGet".play()
	await get_tree().create_timer(time_in_seconds).timeout
	popup.set_visible(false)
	
func battle_win(enemy: Monster):
	var book: Book = $"../Book"
	if len(book.elements_unlocked) == 10:
		win()
	if enemy.primary_type not in book.elements_unlocked:
		book.elements_unlocked.append(enemy.primary_type)
		book.show_available()
		show_element_modal(enemy.primary_type)
	elif enemy.secondary_type not in book.elements_unlocked:
		book.elements_unlocked.append(enemy.secondary_type)
		book.show_available()
		show_element_modal(enemy.secondary_type)
	enemy.random_enemy()
	var time_in_seconds = 1
	await get_tree().create_timer(time_in_seconds).timeout
	$"../WinLabel".set_visible(false)
	book.set_visible(true)
	$"../Sounds/Book".play()

func _on_ally_monster_do_battle():
	var book: Book = $"../Book"
	rounds += 1
	var anim = $"../AnimationPlayer"
	anim.play("EnemyCharge")
	
	var enemy: Monster = $"../Monsters/EnemyMonster"
	var ally: Monster = $"../Monsters/AllyMonster"
	
	var likelyhood = ally.defend(enemy) * 1.2
	
	$"../WinLabel".text = "Chance To Win:\n%2d%%" % (likelyhood * 100)
	$"../WinLabel".set_visible(true)
	book.set_visible(false)

func _on_animation_player_animation_finished(anim_name):
	$"../RoundLabel".text = "ROUND %s" % rounds
	
	var enemy: Monster = $"../Monsters/EnemyMonster"
	var ally: Monster = $"../Monsters/AllyMonster"

	var likelyhood = ally.defend(enemy) * 1.2
	var roll = randf()
	var win = roll <= likelyhood

	print("Likelyhood: ", likelyhood, " Roll: ", roll, " Win: ", win)
	
	$"../WinLabel".set_visible(false)
	
	ally.set_visible(false)
	enemy.position = Vector2(636, 275)

	if anim_name == "EnemyCharge":
		if not win:
			lose()
		else:
			battle_win(enemy)
