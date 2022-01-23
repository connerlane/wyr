extends Node2D

export var good_thresh = 0.8
export var neutral_thresh = 0.35

# "Generic specificity. Bad (negative) effects. Mild severity.
const GEN_BAD_MILD = [ 
#	["double_enemies",
#	"Double the enemies."],
	["math",
	"Learn math."],
]

const GEN_BAD_MEDIUM = [ 
#	["double_enemies",
#	"Double the enemies."],

]

const GEN_BAD_SEVERE = [ 
#	["enemies_shoot",
#	"Enemies shoot bullets."],
	["enemies_speed_up",
	"Enemies are 50% faster."],
	["camera_spin",
	"The camera spins."],
]

const GEN_NEUTRAL_MILD = [
	["tokyo_ghoul",
	"Listen to terrible anime covers."],
	["developer_commentary",
	"Listen to Developer Commentary."],
	["texas",
	"You are now Texas."],
	["biden",
	"Enemies are now Joe Biden."],
]

const GEN_NEUTRAL_MEDIUM = []
const GEN_NEUTRAL_SEVERE = [
]
const GEN_GOOD_MILD = []
const GEN_GOOD_MEDIUM = [
	["you_speed_up",
	"You get 50% extra movement speed."],
]
const GEN_GOOD_SEVERE = []


const CIR_BAD_MILD = []
const CIR_BAD_MEDIUM = []
const CIR_BAD_SEVERE = []
const CIR_NEUTRAL_MILD = []
const CIR_NEUTRAL_MEDIUM = []
const CIR_NEUTRAL_SEVERE = []
const CIR_GOOD_MILD = []
const CIR_GOOD_MEDIUM = []
const CIR_GOOD_SEVERE = []


const TRI_BAD_MILD = []
const TRI_BAD_MEDIUM = []
const TRI_BAD_SEVERE = []
const TRI_NEUTRAL_MILD = []
const TRI_NEUTRAL_MEDIUM = []
const TRI_NEUTRAL_SEVERE = []
const TRI_GOOD_MILD = []
const TRI_GOOD_MEDIUM = []
const TRI_GOOD_SEVERE = []


const SQ_BAD_MILD = []
const SQ_BAD_MEDIUM = []
const SQ_BAD_SEVERE = []
const SQ_NEUTRAL_MILD = []
const SQ_NEUTRAL_MEDIUM = []
const SQ_NEUTRAL_SEVERE = []
const SQ_GOOD_MILD = []
const SQ_GOOD_MEDIUM = []
const SQ_GOOD_SEVERE = []



onready var ALL_LISTS = [
	GEN_BAD_MILD, GEN_BAD_MEDIUM, GEN_BAD_SEVERE,
	GEN_NEUTRAL_MILD, GEN_NEUTRAL_MEDIUM, GEN_NEUTRAL_SEVERE,
	GEN_GOOD_MILD, GEN_GOOD_MEDIUM, GEN_GOOD_SEVERE,
	CIR_BAD_MILD, CIR_BAD_MEDIUM, CIR_BAD_SEVERE,
	CIR_NEUTRAL_MILD, CIR_NEUTRAL_MEDIUM, CIR_NEUTRAL_SEVERE,
	CIR_GOOD_MILD, CIR_GOOD_MEDIUM, CIR_GOOD_SEVERE,
	TRI_BAD_MILD, TRI_BAD_MEDIUM, TRI_BAD_SEVERE,
	TRI_NEUTRAL_MILD, TRI_NEUTRAL_MEDIUM, TRI_NEUTRAL_SEVERE,
	TRI_GOOD_MILD, TRI_GOOD_MEDIUM, TRI_GOOD_SEVERE,
	SQ_BAD_MILD, SQ_BAD_MEDIUM, SQ_BAD_SEVERE,
	SQ_NEUTRAL_MILD, SQ_NEUTRAL_MEDIUM, SQ_NEUTRAL_SEVERE,
	SQ_GOOD_MILD, SQ_GOOD_MEDIUM, SQ_GOOD_SEVERE
	]

onready var ALL_BAD = GEN_BAD_MILD + CIR_BAD_MILD + TRI_BAD_MILD + SQ_BAD_MILD + GEN_BAD_MEDIUM + CIR_BAD_MEDIUM + TRI_BAD_MEDIUM + SQ_BAD_MEDIUM + GEN_BAD_SEVERE + CIR_BAD_SEVERE + TRI_BAD_SEVERE + SQ_BAD_SEVERE 

onready var ALL_NEUTRAL = GEN_NEUTRAL_MILD + CIR_NEUTRAL_MILD + TRI_NEUTRAL_MILD + SQ_NEUTRAL_MILD + GEN_NEUTRAL_MEDIUM + CIR_NEUTRAL_MEDIUM + TRI_NEUTRAL_MEDIUM + SQ_NEUTRAL_MEDIUM + GEN_NEUTRAL_SEVERE + CIR_NEUTRAL_SEVERE + TRI_NEUTRAL_SEVERE + SQ_NEUTRAL_SEVERE 

onready var ALL_GOOD = GEN_GOOD_MILD + CIR_GOOD_MILD + TRI_GOOD_MILD + SQ_GOOD_MILD + GEN_GOOD_MEDIUM + CIR_GOOD_MEDIUM + TRI_GOOD_MEDIUM + SQ_GOOD_MEDIUM + GEN_GOOD_SEVERE + CIR_GOOD_SEVERE + TRI_GOOD_SEVERE + SQ_GOOD_SEVERE 


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func get_pair(level, char_selection):
	randomize()
	var good_bad_neutral = ""
	var dice = randf()
	var selected_list = []
	if dice < neutral_thresh:
		selected_list = ALL_BAD
		good_bad_neutral = "b"
	elif dice < good_thresh:
		selected_list = ALL_NEUTRAL
		good_bad_neutral = "n"
	else:
		selected_list = ALL_GOOD
		good_bad_neutral = "g"
	
	var choiceA = []
	var choiceB = []
	selected_list.shuffle()
	if selected_list.size() == 0:
		choiceA = ["test", "<Test>"]
	else:
		choiceA = selected_list.pop_back()
	if selected_list.size() == 0:
		choiceB = ["test", "<Test>"]
	else:
		choiceB = selected_list.pop_back()
	
	return [choiceA, choiceB, good_bad_neutral]
	
