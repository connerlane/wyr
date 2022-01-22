extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _input(event):
	if event is InputEventKey and (event.scancode == KEY_Q or event.scancode == KEY_ESCAPE) and event.pressed:
		get_tree().quit()


func _on_HealthBar_health_empty():
	self.game_over()
	
func game_over():
	$EnemySpawner.queue_free()
	$SquarePlayer.queue_free()


func _on_EnemySpawner_wave_change(value):
	$WavesLabel.text = "Waves: " + str(value)
