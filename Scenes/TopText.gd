extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var to_display = ""
var game_over = false
onready var player = get_node("/root/Main").get_player_ref()

# Called when the node enters the scene tree for the first time.
func _ready():
	self.text = ""
	player.connect("health_hit", self, "_on_Player_health_hit")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
var normal_insults = ["yikes", "embarassing", ":x", "oof", "wow bad"]


func choice(lst):
	randomize()
	return lst[randi() % lst.size()]
	
func insult():
	self.text = ""
	self.to_display = choice(normal_insults)
	$HangTimer.stop()
	$CharacterTimer.start()


func _on_Player_health_hit():
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

func display_text(text):
	self.text = ""
	self.to_display = text
	$HangTimer.stop()
	$CharacterTimer.start()

func _on_Main_player_changed():
	player.disconnect("health_hit", self, "_on_Player_health_hit")
	player = get_node("/root/Main").get_player_ref()
	player.connect("health_hit", self, "_on_Player_health_hit")


func _on_EnemySpawner_wave_change(value):
	if value == 1:
		display_text("Last Wave")


func _on_Main_game_start():
	display_text("Good Luck :)")


func _on_Main_level_change(value):
	display_text("Level " + str(value))
