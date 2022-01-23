extends "res://Scenes/Player.gd"

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(PackedScene) var bullet
export var bullet_fire_speed = 400


# Called when the node enters the scene tree for the first time.
func _ready():
	self.max_power_charges = 15
	self.power_charges = 15


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _input(event):
	if event is InputEventMouseButton:
		if event.pressed and self.power_charges > 0:
			$PowerRechargeTimer.start()
			self.power_charges -= 1
			var mouse_coords = get_global_mouse_position()
			var diff = mouse_coords - $Avatar.global_position
			diff /= diff.length()
			var b = bullet.instance()
			b.global_position = $Avatar.global_position
			b.linear_velocity = diff * self.bullet_fire_speed
			get_node("/root/Main").add_child(b)
			$BulletSound.play()
			
	if event is InputEventMouse:
			var mouse_coords = get_global_mouse_position()
			var diff = mouse_coords - $Avatar.global_position
			diff /= diff.length()
			var angle = Vector2(diff.x, diff.y).angle()
			$Avatar/Cannon.rotation = angle + (PI / 2)
		
		


func _on_PowerRechargeTimer_timeout():
	self.power_charges += 1
	if self.power_charges >= self.max_power_charges:
		$PowerRechargeTimer.stop()
