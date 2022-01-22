extends "res://Scenes/Player.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var pulse_magnitude = 6


# Called when the node enters the scene tree for the first time.
func _ready():
	self.max_power_charges = 1
	self.power_charges = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.handle_pulse()
	
func handle_pulse():
	if $PulseTimer.is_stopped():
		$Avatar/Pulse.visible = false
		return
	var progress = 1 - ( $PulseTimer.time_left / $PulseTimer.wait_time)
	var mag = sin(progress * PI) * pulse_magnitude
	$Avatar/Pulse.visible = true
	$Avatar/Pulse.scale.x = mag
	$Avatar/Pulse.scale.y = mag
	$Avatar/Pulse/Area2D/CollisionShape2D.shape.radius = mag * 3
	
	
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


func _on_Area2D_body_entered(body):
	if body.has_method("die"):
		if !$PulseTimer.is_stopped():
			body.die()
