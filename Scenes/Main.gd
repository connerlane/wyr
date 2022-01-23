extends Node2D


export(PackedScene) var circle_player_scene
export(PackedScene) var square_player_scene
export(PackedScene) var triangle_player_scene
var player = ""
signal player_changed
signal game_start
signal level_change(value)
var choice_a_code = ""
var choice_b_code = ""
var can_click_choice = false
var level_count = 1 

# Called when the node enters the scene tree for the first time.
func _enter_tree():
	self.set_player()
	
func _ready():
	emit_signal("game_start")
	
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
		$WavesLabel.text = "Waves: " + str(value - 1)
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
	$WYRs/Cards/ChoiceA/Label.text = choiceA[1]
	$WYRs/Cards/ChoiceB/Label.text = choiceB[1]
	$WYRs/Cards/ChoiceA.clock = 0
	$WYRs/Cards/ChoiceB.clock = 0
	$WYRs/Cards/ChoiceB._ready()
	$WYRs/Cards/ChoiceB.started = false
	$WYRs/Cards/ChoiceB/Timer.start()
	$WYRs/ChoiceMisclickTimer.start()
	if choices[2] == "g":
		$WYRs/Cards/ChoiceA.display_good_colors()
		$WYRs/Cards/ChoiceB.display_good_colors()
	elif choices[2] == "n":
		$WYRs/Cards/ChoiceA.display_neutral_colors()
		$WYRs/Cards/ChoiceB.display_neutral_colors()
	else:
		$WYRs/Cards/ChoiceA.display_bad_colors()
		$WYRs/Cards/ChoiceB.display_bad_colors()
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
	var w = $WYRs
	remove_child(w)
	add_child(w)
	

func clear_choice_menu():
	$WYRs.visible = false
	$EnemySpawner.reset()
	emit_signal("level_change", self.level_count)
	can_click_choice = false
	
func _on_ChoiceA_button_down():
	if !can_click_choice:
		return
	apply_choice(self.choice_a_code)
	clear_choice_menu()

func _on_ChoiceB_button_down():
	if !can_click_choice:
		return
	apply_choice(self.choice_b_code)
	clear_choice_menu()

func _on_ChoiceMisclickTimer_timeout():
	self.can_click_choice = true
	
func apply_choice(choice):
	if choice == "tokyo_ghoul":
		$Bgm.stream = load("res://audio/Tokyoboe.mp3")
		$Bgm.play()
	elif choice == "developer_commentary":
		$Bgm.stream = load("res://audio/Commentary.mp3")
		$Bgm.volume_db = -2
		$Bgm.play()
	elif choice == "you_speed_up":
		self.get_player_ref().run_speed *= 1.5
	elif choice == "enemies_speed_up":
		$EnemySpawner.enemy_speed *= 1.5
	elif choice == "texas":
		self.get_player_ref().get_node("Avatar/Sprite").texture = load("res://sprites/Texas.png")
		self.get_player_ref().get_node("Avatar/Sprite").scale.x = 1.5
		self.get_player_ref().get_node("Avatar/Sprite").scale.y = 1.5
	elif choice == "biden":
		$EnemySpawner.biden()
	elif choice == "math":
		$VideoPlayer.play()
	
	else:
		print("missing implementation for " + choice)
		



