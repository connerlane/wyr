extends Camera2D


export var twist_mag = 2
export var twist_speed = 1

var clock = 0

var state = "default"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	clock += delta
	self.rotation_degrees = sin(clock * twist_speed) * twist_mag
