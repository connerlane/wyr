extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var clock = 0
var started = false

# Called when the node enters the scene tree for the first time.
func _ready():
	self.rect_scale.x = 0
	self.rect_scale.y = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !started:
		return
	clock += delta * 2.5
	var s = 0
	if clock < 1:
		s = pow(clock, 2)
	else:
		s = sin(5*clock - 5) * 0.8 * pow(0.4, clock) + 1
	self.rect_scale.x = s
	self.rect_scale.y = s


func _on_Timer_timeout():
	started = true
	
func display_bad_colors():
	self.self_modulate.r = 1
	self.self_modulate.g = 0
	self.self_modulate.b = 0
	
func display_neutral_colors():
	self.self_modulate.r = 0.96
	self.self_modulate.g = 0.588
	self.self_modulate.b = 0.055

func display_good_colors():
	self.self_modulate.r = 0
	self.self_modulate.g = 0.9
	self.self_modulate.b = 0
