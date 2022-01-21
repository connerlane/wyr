extends RigidBody2D


export var run_speed = 40
export var max_run_speed = 260
export var momentum_dampening = 0.94


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.handle_input()

func handle_input():
	if Input.is_key_pressed(KEY_D) or Input.is_key_pressed(KEY_RIGHT):
		self.linear_velocity.x += run_speed
	if Input.is_key_pressed(KEY_A) or Input.is_key_pressed(KEY_LEFT):
		self.linear_velocity.x -= run_speed
	if Input.is_key_pressed(KEY_W) or Input.is_key_pressed(KEY_UP):
		self.linear_velocity.y -= run_speed
	if Input.is_key_pressed(KEY_S) or Input.is_key_pressed(KEY_DOWN):
		self.linear_velocity.y += run_speed
	if self.linear_velocity.length() > max_run_speed:
		self.linear_velocity *= (max_run_speed/ self.linear_velocity.length())
	self.linear_velocity *= momentum_dampening

