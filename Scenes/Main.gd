extends Node2D


export(PackedScene) var circle_player_scene
export(PackedScene) var square_player_scene
export(PackedScene) var triangle_player_scene
var player = ""
signal player_changed


var choice_a_code = ""
var choice_b_code = ""

var level_count = 1 

# Called when the node enters the scene tree for the first time.
func _enter_tree():
	self.set_player()
	

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
	if value > 0:
		$WavesLabel.text = "Waves left: " + str(value)
	else:
		self.advance_level()
		
func advance_level():
	self.level_count += 1 
	$LevelLabel.text = "Level: " + str(self.level_count)
	# 	check if that was last level
	#		possibly spawn boss choice?
	
	# offer a new choice
	self.offer_choice()
	# 	pull a choice pair from WYR_generator
	# apply that choice
	$EnemySpawner.raise_difficulty()
	
func offer_choice():
	var choices = $WYRFetcher.get_pair(self.level_count, self.player)
	var choiceA = choices[0]
	var choiceB = choices[1]
	choice_a_code = choiceA[0]
	choice_b_code = choiceB[0]
	$WYRs/ChoiceA/Label.text = choiceA[2]
	$WYRs/ChoiceB/Label.text = choiceB[2]
	$WYRs.visible = true

func set_player():
	if Global.char_selection == "circle":
		var p = circle_player_scene.instance()
		p.global_position.x = 400
		p.global_position.y = 350
		add_child(p)
		self.player = "CirclePlayer"
	elif Global.char_selection == "square":
		var p = square_player_scene.instance()
		p.global_position.x = 400
		p.global_position.y = 350
		add_child(p)
		self.player = "SquarePlayer"
	elif Global.char_selection == "triangle":
		var p = triangle_player_scene.instance()
		p.global_position.x = 400
		p.global_position.y = 350
		add_child(p)
		self.player = "TrianglePlayer"

func clear_choice_menu():
	$WYRs.visible = false
	$EnemySpawner.reset()

func _on_ChoiceA_button_down():
	apply_choice(self.choice_a_code)
	clear_choice_menu()


func _on_ChoiceB_button_down():
	apply_choice(self.choice_b_code)
	clear_choice_menu()

func apply_choice(choice):
	if self.choice_a_code == "tokyo_ghoul":
		$Bgm.stream = load("res://audio/Tokyoboe.mp3")
		$Bgm.play()
	elif self.choice_a_code == "developer_commentary":
		$Bgm.stream = load("res://audio/Commentary.mp3")
		$Bgm.play()
