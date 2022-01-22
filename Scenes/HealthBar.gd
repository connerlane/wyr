extends Node2D

signal health_empty
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var bar_pixel_size = 300
var health = 20.0
onready var max_health = self.health

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _process(delta):
	$ColorRect.rect_size.y = bar_pixel_size * (health / max_health )

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Player_health_hit():
	if health == 0:
		return
	health -= 1
	health = max(0, health)
	if health == 0:
		emit_signal("health_empty")
