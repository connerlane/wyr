extends Node2D

const BAD_WYRs = [ 
	["double_enemies",
	1.0,
	"Double the enemies."],

	["enemies_shoot",
	2.0,
	"Enemies shoot bullets."],
]

const NEUTRAL_WYRs = [
	["tokyo_ghoul",
	2.0,
	"Music becomes shitty anime OPs."],
]

const GOOD_WYRs = [
	["character_upgrade",
	2.0,
	"Your character levels up."],
]

const CIRC_SPECIFIC_WYRs = [
	["double_bullets",
	"g",
	1.0,
	"Double your bullets."],
]
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func get_pair(level, char_selection):
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
