extends Node2D

var gameEvents = []
var currentDay : int
var totalDays : int
var day_time : int

#Attributes
var hunger : float
var energy: float
var motivation : float
var money: int
var originality: float
var reputation: float
var graphics: float
var music: float
var progress: float
var total_progress: float

var max_hunger : float
var max_energy: float
var max_motivation : float

var minigame_spawn_key_time : float
var minigame_time: float
var minigame_key_speed : float

#Nodes
var day_timer : Timer
var day_change : Node
var hud : Node
var event : Node
var minigame : Node
var audio : AudioStreamPlayer2D


# Called when the node enters the scene tree for the first time.
func _ready():
	#Load initial information
	gameEvents = Data.data.get("events") #We could filter in the future based on the gameprogress
	currentDay = 1
	totalDays = 7
	day_time = 90
	
	minigame_spawn_key_time = 0.65
	minigame_time = 15
	minigame_key_speed = 300
	
	#Assign nodes to variables
	day_timer = $Timers/DayTimer
	day_change = $DayChange
	hud = $HUD
	event = $Event
	minigame = $Minigame
	audio = $Audio
	
	audio.stream = load("res://art/general.mp3")
	
	#TODO load possible upgrades
	max_hunger = 100.0
	max_energy = 100.0
	max_motivation = 100.0
	
	#Attributes
	hunger = max_hunger
	energy = max_energy
	motivation = max_motivation
	progress = 0.0
	money = 100
	originality = 0.0
	reputation = 0.0
	graphics = 0.0
	music = 0.0
	
	#Signals
	day_timer.timeout.connect(_end_current_day)
	Signals.day_change_end.connect(_start_day)
	Signals.pick_decision.connect(_decision_picked)
	Signals.add_progress_score.connect(_add_progress)
	Signals.end_minigame.connect(_end_minigame)
	audio.finished.connect(_next_song)
	#Send signals with initial values for HUD
	_update_hud()
	
	audio.play()
	day_change.visible = false
	Signals.day_change_start.emit(currentDay, totalDays-(currentDay-1))

func _end_minigame():
	if not day_timer.is_stopped():
		_show_event()

func _process(_delta):
	if(!day_timer.is_stopped()):
		_update_hud()

func _show_event():
	if gameEvents.size() > 0 and not event.visible:
		var randomIdx = randi() % gameEvents.size()
		var currentEvent = gameEvents[randomIdx]
		gameEvents.remove_at(randomIdx)
		Signals.event.emit(currentEvent)
	_update_hud()

func _decision_picked(decision):
	for consequence in decision.consequences:
		_apply_consequence(consequence)
	if decision.get("popup") != null:
		print("Hay popup")
	else:
		_start_minigame()

func _apply_consequence(consequence):
	match consequence.key:
		"hunger":
			hunger += _transform_consequence_value_to_num(consequence.value)
			if (hunger > max_hunger):
				hunger = max_hunger
			elif hunger <= 0:
				#TODO lose game
				hunger = 0
		"energy":
			energy += _transform_consequence_value_to_num(consequence.value)
			if (energy > max_energy):
				energy = max_energy
			elif energy <= 0:
				#TODO lose game
				energy = 0
		"motivation":
			motivation += _transform_consequence_value_to_num(consequence.value)
			if (motivation > max_motivation):
				motivation = max_motivation
			elif motivation <= 0:
				#TODO lose game
				motivation = 0
		"progress":
			progress += _transform_consequence_value_to_num(consequence.value)
			if (progress > 100):
				progress = 100
			elif progress < 0:
				progress = 0
			total_progress = ((music + graphics + originality + reputation) / 4) + progress
		"money":
			money += consequence.value
			if (money < 0):
				money = 0
		"time":
			var new_time = float(day_timer.time_left - consequence.value)
			if(new_time < 0.0):
				new_time = 0.1
			day_timer.stop()
			day_timer.start(new_time)
		"originality":
			originality += _transform_consequence_value_to_num(consequence.value)
			if (originality > 100):
				originality = 100
			elif originality < 0:
				originality = 0
			total_progress = ((music + graphics + originality + reputation) / 4) + progress
		"reputation":
			reputation += _transform_consequence_value_to_num(consequence.value)
			if (reputation > 100):
				reputation = 100
			elif reputation < 0:
				reputation = 0
			total_progress = ((music + graphics + originality + reputation) / 4) + progress
		"graphics":
			graphics += _transform_consequence_value_to_num(consequence.value)
			if (graphics > 100):
				graphics = 100
			elif graphics < 0:
				graphics = 0
			total_progress = ((music + graphics + originality + reputation) / 4) + progress
		"music":
			music += _transform_consequence_value_to_num(consequence.value)
			if (music > 100):
				music = 100
			elif music < 0:
				music = 0
			total_progress = ((music + graphics + originality + reputation) / 4) + progress


func _transform_consequence_value_to_num(value):
	var number = 0.0
	match value:
		"-":
			number = -5
		"--":
			number = -10
		"+":
			number = 5
		"++":
			number = 10
	return number

func _start_day():
	day_change.visible = false
	hud.visible = true
	day_timer.start(day_time)
	if randi() % 1 == 1:
		_start_minigame()
	else: 
		_show_event()

func _end_current_day():
	hud.visible = false
	event.visible = false
	minigame._end()
	if(currentDay == totalDays):
		print("fin del juego")
		print("score:")
		total_progress = ((music + graphics + originality + reputation) / 4) + progress
		print(total_progress)
		var mainMenuScene = load("res://scenes/MainMenu.tscn")
		get_tree().change_scene_to_packed(mainMenuScene)
	else:
		currentDay += 1
		Signals.day_change_start.emit(currentDay, totalDays-(currentDay-1))

func _update_hud():
	Signals.change_hunger.emit(hunger)
	Signals.change_energy.emit(energy)
	Signals.change_motivation.emit(motivation)
	Signals.change_day_progress.emit(day_time - day_timer.get_time_left())
	Signals.change_progress.emit(total_progress)
	Signals.change_money.emit(money)

func _add_progress(value : float):
	progress += value
	if(progress < 0.0):
		progress = 0
	total_progress = float(float(((music + graphics + originality + reputation) / 4)) + progress)
	if(total_progress > 100):
		total_progress = 100
	_update_hud()

func _start_minigame():
	event.visible = false
	minigame_spawn_key_time = minigame_spawn_key_time*0.95
	minigame_key_speed = minigame_key_speed * 1.05
	Signals.start_minigame.emit(minigame_spawn_key_time, minigame_time, minigame_key_speed) #Todo send spawn key time and keys speed

func _next_song():
	audio.stream = load("res://art/general.mp3")
