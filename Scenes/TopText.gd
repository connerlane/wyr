extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var to_display = ""
var game_over = false

# Called when the node enters the scene tree for the first time.
func _ready():
	self.text = ""


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
var normal_insults = ["yikes", "embarassing", ":x", "oof", "wow bad"]


func choice(lst):
	return lst[randi() % lst.size()]
	
func insult():
	self.text = ""
	self.to_display = choice(normal_insults)
	$HangTimer.stop()
	$CharacterTimer.start()


func _on_SquarePlayer_health_hit():
	if game_over:
		return
	self.insult()

func _on_CharacterTimer_timeout():
	if self.text.length() < self.to_display.length():
		self.text = to_display.substr(0, self.text.length() + 1)
	else:
		$HangTimer.start()
		$CharacterTimer.stop()

func _on_HangTimer_timeout():
	self.text = ""

func _on_HealthBar_health_empty():
	game_over = true
	self.text = ""
	self.to_display = "Game Over"
	$HangTimer.stop()
	$HangTimer.wait_time = 999999
	$CharacterTimer.start()
	$CharacterTimer.wait_time = 0.3

