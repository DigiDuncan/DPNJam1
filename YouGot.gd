extends Node2D

var icon_nodes: Array[CanvasItem] = []

# Called when the node enters the scene tree for the first time.
func _ready():
	for element in Monster.MonsterType.values():
		# Cache icon nodes
		var node = get_node("GetIcon/" + Monster.MonsterType.find_key(element)) as TextureRect
		icon_nodes.append(node)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
