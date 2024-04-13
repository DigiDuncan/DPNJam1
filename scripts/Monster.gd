@tool
class_name Monster extends Sprite2D

enum MonsterType {POISON, FIRE, WATER, ICE, LIGHTNING, DARK, LIGHT, WIND, ROCK, NATURE}

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
	self.change_sprite()
	

func random_enemy():
	primary_type = MonsterType.values()[randi() % MonsterType.size()]
	secondary_type = MonsterType.values()[randi() % MonsterType.size()]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_button_pressed():
	random_enemy()
