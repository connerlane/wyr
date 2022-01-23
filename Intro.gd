extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal circ_selection
var clock = 0
export var twist_mag = 1.7
export var twist_speed = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	clock += delta
	$Camera2D.rotation_degrees = sin(clock * twist_speed) * twist_mag
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_button_down():
	Global.char_selection = "triangle"
	get_tree().change_scene("res://Scenes/Main.tscn")
	

func _on_ButtonSquare_button_down():
	Global.char_selection = "square"
	get_tree().change_scene("res://Scenes/Main.tscn")


func _on_ButtonCircle_button_down():
	Global.char_selection = "circle"
	get_tree().change_scene("res://Scenes/Main.tscn")
