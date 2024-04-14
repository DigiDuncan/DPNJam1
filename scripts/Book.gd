class_name Book extends Node2D

var elements_unlocked: Array[Monster.MonsterType] = []
var icon_nodes: Array[CanvasItem] = []
var primary_element = null
var secondary_element = null

signal player_win

func choose_starting_elements():
	while elements_unlocked.size() < 4:
		var new_element = randi() % Monster.MonsterType.size()
		if new_element in elements_unlocked:
			continue
		else:
			elements_unlocked.append(new_element)

func show_available():
	for element_idx in Monster.MonsterType.size():
		var element = Monster.MonsterType.values()[element_idx]
		if element in elements_unlocked:
			icon_nodes[element_idx].set_visible(true)
		else:
			icon_nodes[element_idx].set_visible(false)

func show_or_hide_book():
	set_visible(not visible)
	

func on_select_element(element: Monster.MonsterType):
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	for element in Monster.MonsterType.values():
		var node = get_node("BookIcons/" + Monster.MonsterType.find_key(element)) as TextureRect
		icon_nodes.append(node)
		node.gui_input.connect(_on_element_select.bind(element))
		
	choose_starting_elements()
	print(elements_unlocked)
	show_available()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_book_button_pressed():
	show_or_hide_book()


func _on_element_select(event, element: Monster.MonsterType):
	if event is InputEventMouseButton and event.pressed and primary_element == null:
			primary_element = Monster.MonsterType.find_key(element)
			return
	if event is InputEventMouseButton and event.pressed and primary_element != null and secondary_element == null:
			secondary_element = Monster.MonsterType.find_key(element)
			print(primary_element)
			print(secondary_element)
			return
