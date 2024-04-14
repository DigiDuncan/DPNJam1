class_name Book extends Node2D

@onready var gm = $"../GameManager"

func show_available():
	for element in Monster.MonsterType.values():
		var icon_node = get_node("BookIcons/" + Monster.MonsterType.find_key(element))
		if element in gm.elements_unlocked:
			icon_node.set_visible(true)
		else:
			icon_node.set_visible(false)

func show_or_hide_book():
	if self.visible:
		self.set_visible(false)
	else:
		self.set_visible(true)

# Called when the node enters the scene tree for the first time.
func _ready():
	show_available()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_book_button_pressed():
	show_or_hide_book()
