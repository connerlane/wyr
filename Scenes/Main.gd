extends Node2D



var player = "SquarePlayer"
signal player_changed
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func get_player_ref():
	return get_node(self.player)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _input(event):
	if event is InputEventKey and (event.scancode == KEY_Q or event.scancode == KEY_ESCAPE) and event.pressed:
		get_tree().quit()

func _on_HealthBar_health_empty():
	self.game_over()
	
func game_over():
	$GameOverSound.play()
	$EnemySpawner.queue_free()
	$HealthBar.queue_free()
	$PowerBar.queue_free()
	self.get_player_ref().queue_free()


func _on_EnemySpawner_wave_change(value):
	$WavesLabel.text = "Waves: " + str(value)

