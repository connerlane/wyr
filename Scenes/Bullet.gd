extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var piercing = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Bullet_body_entered(body):
	if body.has_method("die"):
		body.die()
		if !self.piercing:
			self.queue_free()
		


func _on_Timer_timeout():
	self.queue_free()
