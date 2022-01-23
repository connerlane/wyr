extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var clock = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	clock += delta * 2.5
	var s = 0
	if clock < 1:
		s = pow(clock, 2)
	else:
		s = sin(5*clock - 5) * 0.8 * pow(0.4, clock) + 1
	self.rect_scale.x = s
	self.rect_scale.y = s

func display_bad_colors():
	$Label.modulate.r = 1
	$Label.modulate.g = 0
	$Label.modulate.b = 0
	
func display_neutral_colors():
	$Label.modulate.r = 0.96
	$Label.modulate.g = 0.588
	$Label.modulate.b = 0.055

func display_good_colors():
	$Label.modulate.r = 0
	$Label.modulate.g = 0.9
	$Label.modulate.b = 0
