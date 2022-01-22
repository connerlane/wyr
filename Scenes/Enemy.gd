extends RigidBody2D

export var speed = 100

func _ready():
#	player_ref = "/root/Main/SquarePlayer"
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.angular_velocity = 5
	var player= get_node("/root/Main").get_player_ref()
	
	var player_x = player.get_position().x
	var player_y = player.get_position().y
	var self_y = self.global_position.y
	var self_x = self.global_position.x

	var xdif = self_x-player_x
	var ydif = self_y-player_y


	var xunit = (xdif)/sqrt(pow(xdif,2)+pow(ydif,2))
	var yunit = (ydif)/sqrt(pow(xdif,2)+pow(ydif,2))
	xunit *= -1
	yunit *= -1

	var adjusted_speed = self.speed
	var thresh_dist = 100
	var extra_speed = 50
	if (player.get_position() - self.global_position).length() < thresh_dist:
		adjusted_speed += extra_speed
	self.linear_velocity.x = xunit*adjusted_speed
	self.linear_velocity.y = yunit*adjusted_speed

#	self.rotation_degrees = 0
#	var rotation_speed = 180.0
#	set_rotd( () + delta * rotation_speed)
#	print(self.rotation_degrees)

func die():
	self.queue_free()
