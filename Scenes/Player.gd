extends Node2D

export(PackedScene) var texas_avatar

export var run_speed = 40
export var max_run_speed = 260
export var momentum_dampening = 0.94


onready var body = get_node("SquareAvatar")

func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.handle_input()

func handle_input():
	if Input.is_key_pressed(KEY_D) or Input.is_key_pressed(KEY_RIGHT):
		body.linear_velocity.x += run_speed
	if Input.is_key_pressed(KEY_A) or Input.is_key_pressed(KEY_LEFT):
		body.linear_velocity.x -= run_speed
	if Input.is_key_pressed(KEY_W) or Input.is_key_pressed(KEY_UP):
		body.linear_velocity.y -= run_speed
	if Input.is_key_pressed(KEY_S) or Input.is_key_pressed(KEY_DOWN):
		body.linear_velocity.y += run_speed
	if body.linear_velocity.length() > max_run_speed:
		body.linear_velocity *= (max_run_speed/ body.linear_velocity.length())
	body.linear_velocity *= momentum_dampening



func _on_TexasTimer_timeout():
	body = texas_avatar.instance()
	add_child(body)
	body.position = $SquareAvatar.position
	body.angular_velocity = $SquareAvatar.angular_velocity
	
	remove_child($SquareAvatar)
	
