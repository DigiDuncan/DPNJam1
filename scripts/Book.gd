class_name Book extends Node2D

var elements_unlocked: Array[Monster.MonsterType] = []
var icon_nodes: Array[CanvasItem] = []
var primary_icon_nodes: Array[CanvasItem] = []
var secondary_icon_nodes: Array[CanvasItem] = []
var primary_element = null
var secondary_element = null

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
		icon_nodes[element_idx].set_visible(element in elements_unlocked)
		primary_icon_nodes[element_idx].set_visible(element == primary_element)
		secondary_icon_nodes[element_idx].set_visible(element == secondary_element)

func show_or_hide_book():
	set_visible(not visible)

# Called when the node enters the scene tree for the first time.
func _ready():
	for element in Monster.MonsterType.values():
		# Cache icon nodes
		var node = get_node("BookIcons/" + Monster.MonsterType.find_key(element)) as TextureRect
		icon_nodes.append(node)
		node.gui_input.connect(_on_element_select.bind(element))
		
		node = get_node("PrimaryIcon/" + Monster.MonsterType.find_key(element)) as TextureRect
		primary_icon_nodes.append(node)
		
		node = get_node("SecondaryIcon/" + Monster.MonsterType.find_key(element)) as TextureRect
		secondary_icon_nodes.append(node)
		
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
			primary_element = element
			show_available()
			return
	if event is InputEventMouseButton and event.pressed and primary_element != null and secondary_element == null:
			secondary_element = element
			print(primary_element)
			print(secondary_element)
			$SummonButton.show()
			show_available()
			return


func _on_summon_button_pressed():
	$SummonButton.hide()
