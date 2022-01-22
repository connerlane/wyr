extends "res://Scenes/Player.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var pulsing = false

# Called when the node enters the scene tree for the first time.
func _ready():
	self.max_power_charges = 1
	self.power_charges = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event is InputEventMouseButton:
		if event.pressed and self.power_charges > 0:
			$PowerRechargeTimer.start()
			self.power_charges -= 1
			self.pulsing = true

func _on_PowerRechargeTimer_timeout():
	self.power_charges += 1
	if self.power_charges >= self.max_power_charges:
		$PowerRechargeTimer.stop()
