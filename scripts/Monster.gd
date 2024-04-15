@tool
class_name Monster extends Sprite2D

enum MonsterType {POISON, FIRE, WATER, ICE, LIGHTNING, DARK, LIGHT, WIND, ROCK, NATURE}

const WIN_TABLE = preload("res://wintable.tres")

signal do_battle

@export var primary_type: MonsterType:
	set(value):
		primary_type = value
		self.change_sprite()
@export var secondary_type: MonsterType:
	set(value):
		secondary_type = value
		self.change_sprite()

func change_sprite():
	if not is_inside_tree():
		return
	self.frame = (primary_type * 10) + secondary_type

# Called when the node enters the scene tree for the first time.
func _ready():
	primary_type = primary_type
	secondary_type = secondary_type
	random_enemy()

func random_enemy():
	primary_type = MonsterType.values()[randi() % MonsterType.size()]
	secondary_type = MonsterType.values()[randi() % MonsterType.size()]
	
func compare_elements(defender: MonsterType, attacker: MonsterType):
	var result = WIN_TABLE.table[defender][attacker]
	print(MonsterType.find_key(defender), " vs ", MonsterType.find_key(attacker), ": ", WIN_TABLE.Result.find_key(result))
	return result
	
func defend(attacker: Monster):
	var result = (compare_elements(primary_type, attacker.primary_type) +
	compare_elements(primary_type, attacker.secondary_type) +
	compare_elements(secondary_type, attacker.primary_type) +
	compare_elements(secondary_type, attacker.secondary_type)) / 8.0
	print("Preadjusted Likelyhood: ", result)
	return result

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_button_pressed():
	random_enemy()

func _on_summon_button_pressed():
	if not visible:
		set_visible(true)
		$"../../AnimationPlayer".play("AllyGrow")
	var book: Book = $"../../Book"  # CRINGE
	primary_type = book.primary_element
	secondary_type = book.secondary_element
	book.primary_element = null
	book.secondary_element = null
	book.show_available()
	do_battle.emit()
