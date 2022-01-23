extends Camera2D


export var twist_mag = 1.7
export var twist_speed = 0.7

var clock = 0
var pulse_clock = 0
var spinning = false

var state = "default"
var pulse_mag = 0
var pulse_speed = 0
var anchor_x = 0
var anchor_y = 0
var screen_shake_strength = 0.0
var spinning_rotation = 0

onready var player = get_node("/root/Main").get_player_ref()

# Called when the node enters the scene tree for the first time.
func _ready():
	player.connect("health_hit", self, "_on_Player_health_hit")
	anchor_x = self.position.x
	anchor_y = self.position.y


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	clock += delta
	if self.spinning:
		self.spinning_rotation += 0.3
	self.rotation_degrees = (sin(clock * twist_speed) * twist_mag) + spinning_rotation
	self.handle_pulse(delta)
	self.handle_screen_shake(delta)
	
func handle_pulse(delta):
	self.pulse_clock += delta
	var z = 1 + (sin(pulse_clock * pulse_speed) * pulse_mag)
	self.zoom.x = z
	self.zoom.y = z
	self.pulse_mag *= 0.98
	self.pulse_speed *= 0.999

func handle_screen_shake(delta):
	if int(self.screen_shake_strength) > 0.001:
		self.position.x = self.anchor_x + ((randi() % int(2 *self.screen_shake_strength)) - self.screen_shake_strength)
		self.position.y = self.anchor_y + ((randi() % int(2 *self.screen_shake_strength)) - self.screen_shake_strength)
		self.screen_shake_strength *= 0.95

func pulse():
	self.pulse_clock = 0
	self.pulse_mag = 0.15
	self.pulse_speed = 6

func screen_shake(strength=10):
	self.screen_shake_strength += 12.0

func _on_Player_health_hit():
	self.pulse()
	self.screen_shake()
	
	


func _on_Main_player_changed():
	player.disconnect("health_hit", self, "_on_Player_health_hit")
	player = get_node("/root/Main").get_player_ref()
	player.connect("health_hit", self, "_on_Player_health_hit")
