extends Sprite2D

enum MonsterType {POISON, FIRE, WATER, ICE, LIGHTNING, DARK, LIGHT, WIND, ROCK, NATURE}

@export var primary_type: MonsterType
@export var secondary_type: MonsterType

func change_sprite():
	frame = (primary_type * 10) + secondary_type

# Called when the node enters the scene tree for the first time.
func _ready():
	self.change_sprite()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.change_sprite()
