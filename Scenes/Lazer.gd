extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed = 9

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
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


	self.linear_velocity.x += xunit*speed
	self.linear_velocity.y += yunit*speed

func die():
	self.queue_free()


func _on_Lazer_body_entered(body):
	if !body.has_method("die"):
		self.queue_free()
