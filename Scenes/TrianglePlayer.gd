extends "res://Scenes/Player.gd"

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var dash_strength = 1600

var dashing = false


# Called when the node enters the scene tree for the first time.
func _ready():
	self.max_power_charges = 3
	self.power_charges = 3

func handle_trail():
	if !self.dashing:
		$Line2D.remove_point(0)
		return
	$Line2D.add_point($Avatar.position)
	while $Line2D.points.size() > 30:
		$Line2D.remove_point(0)
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta):
	self.handle_trail()


func _input(event):
	if event is InputEventMouseButton:
		if event.pressed and self.power_charges > 0:
			$PowerRechargeTimer.start()
			self.power_charges -= 1
			$DashTimer.start()
			self.dashing = true
			var mouse_coords = get_global_mouse_position()
			var diff = mouse_coords - $Avatar.global_position
			diff /= diff.length()
			$Avatar.linear_velocity += diff * self.dash_strength
			$DashSound.play()


func _on_DashTimer_timeout():
	self.dashing = false
	
func _on_SquareAvatar_body_entered(body):
	if body.has_method("die"):
		if self.dashing:
			body.die()
		else:
			emit_signal("health_hit")
			body.die()
			self.flash_timer = 0


func _on_PowerRechargeTimer_timeout():
	self.power_charges += 1
	if self.power_charges >= self.max_power_charges:
		$PowerRechargeTimer.stop()

func is_player():
	return true


func _on_BossArea_body_entered(body):
	if body.has_method("die"):
		if !$DashTimer.is_stopped():
			body.die()
			if body.has_method("is_boss"):
				for i in range(0,3):
					body.die()
		else:
			self.get_hit()
			
