extends Node2D

var enemy_scene = preload("res://Scenes/CircleEnemy.tscn")
var boss_scene = preload("res://Scenes/Boss.tscn")
var biden_scene = preload("res://Scenes/Biden.tscn")
signal wave_change(value)
var waves = 3
export var default_waves = 3
export var enemies_per_wave_start = 3
export var enemies_per_wave = 3
export var enemy_increase_per_wave = 1.4
export var difficulty_ramp = 1.5

var enemy_speed = 1

var enemies = []
var active = true
var enemies_spawned = 0
var biden = false
var boss_level = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func biden():
	biden = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !active:
		return
	if self.enemies_spawned >= enemies_per_wave:
		$SpawnTimer.stop()
	if self.get_children().size() <= 3 and $WaveTimer.is_stopped() and $SpawnTimer.is_stopped():
		$WaveTimer.start()

func begin_wave():
	$SpawnTimer.start()
	

func _on_SpawnTimer_timeout():
	randomize()
	enemies_spawned += 1
	var t = ""
	if biden:
		t = biden_scene.instance()
	else:
		t = enemy_scene.instance()
	t.speed *= self.enemy_speed
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
	enemies_spawned = 0
	self.waves -= 1
	self.enemies_per_wave *= self.enemy_increase_per_wave
	if floor(self.waves) == 0:
		$WaveTimer.stop()
		$SpawnTimer.stop()
		active = false
	if boss_level:
		emit_signal("wave_change", "???")
	else:
		emit_signal("wave_change", floor(self.waves))
	
func raise_difficulty():
	enemies_per_wave_start *= 1.2
	default_waves += 0.3334
	self.enemy_speed *= 1.1

func reset():
	enemies_spawned = 0
	enemies_per_wave = enemies_per_wave_start
	self.waves = self.default_waves
	if boss_level:
		emit_signal("wave_change", "???")
	else:
		emit_signal("wave_change", floor(self.waves))
	active = true

func spawn_boss():
	var b = boss_scene.instance()
	boss_level = true
	b.connect("boss_dead", self, "boss_dies")
	get_parent().add_child(b)

func boss_dies():
	self.boss_level = false
	waves = 0
