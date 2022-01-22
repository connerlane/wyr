extends "res://Scenes/Player.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	self.max_power_charges = 1
	self.power_charges = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.handle_pulse()
	
func handle_pulse():
	pass
	
	
func _on_SquareAvatar_body_entered(body):
	if body.has_method("die"):
		if !$PulseTimer.is_stopped():
			body.die()
		else:
			emit_signal("health_hit")
			body.die()
			self.flash_timer = 0

func _input(event):
	if event is InputEventMouseButton:
		if event.pressed and self.power_charges > 0:
			$PowerRechargeTimer.start()
			$PulseTimer.start()
			self.power_charges -= 1

func _on_PowerRechargeTimer_timeout():
	self.power_charges += 1
	if self.power_charges >= self.max_power_charges:
		$PowerRechargeTimer.stop()
