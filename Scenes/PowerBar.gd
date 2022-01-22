extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var bar_pixel_size = 300
onready var player = get_node("/root/Main").get_player_ref()
# Called when the node enters the scene tree for the first time.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$ColorRect.rect_size.y = bar_pixel_size * (player.power_charges * 1.0 / player.max_power_charges )


func _on_Main_player_changed():
	player = get_node("/root/Main").get_player_ref()

