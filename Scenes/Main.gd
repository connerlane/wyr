extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	OS.window_fullscreen = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _input(event):
	if event is InputEventKey and (event.scancode == KEY_Q or event.scancode == KEY_ESCAPE) and event.pressed:
		get_tree().quit()
