extends Node2D

export(PackedScene) var triangle_enemy
signal wave_change(value)
export var waves = 4
export var enemies_per_wave = 2
export var enemy_increase_per_wave = 3

var enemies = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if self.get_children().size() >= enemies_per_wave:
		$SpawnTimer.stop()
	if self.get_children().size() <= 3 and $WaveTimer.is_stopped() and $SpawnTimer.is_stopped():
		$WaveTimer.start()
		
func begin_wave():
	$SpawnTimer.start()

func _on_SpawnTimer_timeout():
	var t = triangle_enemy.instance()
	var c = randi() % 4
	if c == 0:
		t.position.x = randi() % 800
		t.position.y = -20
	elif c == 1:
		t.position.y = randi() % 700
		t.position.x = 820
	elif c == 2:
		t.position.x = randi() % 800
		t.position.y = 735
	elif c == 3:
		t.position.y = randi() % 700
		t.position.x = -20
	add_child(t)


func _on_WaveTimer_timeout():
	$SpawnTimer.start()
	self.waves -= 1
	emit_signal("wave_change", self.waves)
	self.enemies_per_wave += self.enemy_increase_per_wave
