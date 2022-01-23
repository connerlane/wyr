extends Node2D


export var run_speed = 30
export var momentum_dampening = 0.90
export var num_flashes_hurt = 8

signal health_hit

onready var body = get_node("Avatar")

var flash_timer = 9999
var max_power_charges = 5
var power_charges = 5


func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.handle_input()
	self.maybe_change_color(delta)

func handle_input():
	if Input.is_key_pressed(KEY_D) or Input.is_key_pressed(KEY_RIGHT):
		body.linear_velocity.x += run_speed
	if Input.is_key_pressed(KEY_A) or Input.is_key_pressed(KEY_LEFT):
		body.linear_velocity.x -= run_speed
	if Input.is_key_pressed(KEY_W) or Input.is_key_pressed(KEY_UP):
		body.linear_velocity.y -= run_speed
	if Input.is_key_pressed(KEY_S) or Input.is_key_pressed(KEY_DOWN):
		body.linear_velocity.y += run_speed
#	if body.linear_velocity.length() > max_run_speed:
#		body.linear_velocity *= (max_run_speed/ body.linear_velocity.length())
	body.linear_velocity *= momentum_dampening

func get_position():
	return body.global_position
	
func maybe_change_color(delta):
	if self.flash_timer < 2:
		self.flash_timer += delta
		var v = (cos(self.flash_timer * 12) * 0.5) + 0.5
		var a = self.flash_timer / 2.0
		$Avatar/Sprite.modulate.g = a + v
		$Avatar/Sprite.modulate.b = a + v
	else:
		$Avatar/Sprite.modulate.g = 1
		$Avatar/Sprite.modulate.b = 1

func _on_SquareAvatar_body_entered(body):
	if body.has_method("die"):
		emit_signal("health_hit")
		body.die()
		self.flash_timer = 0
