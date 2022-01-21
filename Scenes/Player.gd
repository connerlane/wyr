extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.handle_input()
	
func handle_input():
	var run_speed = 15
	if Input.is_key_pressed(KEY_D):
		self.linear_velocity.x += run_speed
	if Input.is_key_pressed(KEY_A):
		self.linear_velocity.x -= run_speed
	if Input.is_key_pressed(KEY_W):
		self.linear_velocity.y -= run_speed
	if Input.is_key_pressed(KEY_S):
		self.linear_velocity.y += run_speed
	self.linear_velocity *= 0.9

#func _input(event):
#	if event is InputEventKey:
#		if event.scancode == KEY_W:
#		get_tree().quit()
