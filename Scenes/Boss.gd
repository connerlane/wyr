extends "res://Scenes/Enemy.gd"
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(PackedScene) var lazer_scene
var attacks = ["dash", "shoot", "pulse"]
var attack_counter = 0
var atk = ""
export var pulse_magnitude = 12
var health = 60.0
signal boss_dead

func _ready():
	speed = 50
	random_spread = 0
	is_boss = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $AttackChargeTimer.is_stopped():
		self.move_towards_player()
	else:
		self.linear_velocity.x = 0
		self.linear_velocity.y = 0
	maybe_change_color()
	update_sprite()
	self.handle_pulse()
	if $DashTimer.is_stopped():
		self.speed = 50
	else:
		self.speed = 280
	$Node2D/Health.rect_scale.x = self.health / 60.0
		
	
func handle_pulse():
	if $PulseTimer.is_stopped():
		$Pulse.visible = false
		return
	var progress = 1 - ( $PulseTimer.time_left / $PulseTimer.wait_time)
	var mag = sin(progress * PI) * pulse_magnitude
	$Pulse.visible = true
	$Pulse.scale.x = mag
	$Pulse.scale.y = mag
	$Pulse/Area2D/CollisionShape2D.shape.radius = mag * 1.8
	
func update_sprite():
	pass

func die():
	health -= 1
	if health == 0:
		emit_signal("boss_dead")
		self.queue_free()

func begin_attack():
	$AttackChargeTimer.start()
	self.atk = self.attacks[attack_counter % self.attacks.size()]
	if atk == "shoot":
		$AnimatedSprite.animation = "open_eyes"
	if atk == "pulse":
		$AnimatedSprite.animation = "shy"
	if atk == "dash":
		$AnimatedSprite.animation = "triumph"
		

func _on_BetweenAttacksTimer_timeout():
	attack_counter += 1
	self.begin_attack()

func maybe_change_color():
	if $AttackChargeTimer.is_stopped():
		$AnimatedSprite.modulate.g = 1
		$AnimatedSprite.modulate.b = 1
		return
	var progress = 1 - ($AttackChargeTimer.time_left / $AttackChargeTimer.wait_time)
	
	var v = (cos(progress * 50) * 0.3) + 0.7
	$AnimatedSprite.modulate.g = v
	$AnimatedSprite.modulate.b = v

func shoot():
	var l = lazer_scene.instance()
	var r = lazer_scene.instance()
	get_node("/root/Main").add_child(l)
	get_node("/root/Main").add_child(r)
	l.global_position = $LeftEye.global_position
	r.global_position = $RightEye.global_position

func dash():
	$DashTimer.start()

func _on_AttackChargeTimer_timeout():
	if atk == "shoot":
		self.shoot()
	if atk == "pulse":
		$PulseTimer.start()
	if atk == "dash":
		self.dash()
	else:
		$AnimatedSprite.animation = "joy"
		$BetweenAttacksTimer.start()
		
func _on_DashTimer_timeout():
	$AnimatedSprite.animation = "joy"
	$BetweenAttacksTimer.start()
	
func _on_Area2D_body_entered(body):
	if !$PulseTimer.is_stopped():
		if body.get_parent().has_method("get_hit"):
			body.get_parent().get_hit()
	

func is_boss():
	return true
