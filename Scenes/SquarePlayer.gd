extends "res://Scenes/Player.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func handle_trail():
	$Line2D.add_point($Avatar.position)
	while $Line2D.points.size() > 30:
		$Line2D.remove_point(0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.handle_trail()
	pass
