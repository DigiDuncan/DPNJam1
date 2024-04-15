extends Sprite2D

const FPS = 15
const FRAMES = 5
var local_time: float = 0.0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	local_time += delta
	var framenum = int(local_time * FPS) % FRAMES
	frame = framenum
