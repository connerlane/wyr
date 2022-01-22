extends RigidBody2D
export(NodePath) var player_ref
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var player=get_node(player_ref)
	
	var player_x = player.global_position.x
	var player_y = player.global_position.y
	var self_y = self.global_position.y
	var self_x = self.global_position.x
	
	var xdif = self_x-player_x
	var ydif = self_y-player_y
	

	var xunit = (xdif)/sqrt(pow(xdif,2)+pow(ydif,2))
	var yunit = (ydif)/sqrt(pow(xdif,2)+pow(ydif,2))

	print(xunit,yunit)
