extends Node2D

var key_scene = load("res://scenes/Key.tscn")
@onready var keys : Node = $Keys
@onready var key_spawn_timer = $KeySpawnTimer
@onready var timer = $Timer
@onready var marker = $MarkerSprite/Marker
@onready var audio = $Audio
var key_speed = 100
var correct_audio = load("res://art/correct_choice_sound.wav")
var wrong_audio = load("res://art/wrong_choice_sound.wav")

# Called when the node enters the scene tree for the first time.
func _ready():
	Signals.start_minigame.connect(_start)
	key_spawn_timer.timeout.connect(_spawn_key)
	timer.timeout.connect(_end)
	timer.autostart = false

func _input(event):
	if event is InputEventKey and event.pressed and visible:
		if event.keycode >= 65 and event.keycode <= 90:
			if marker.has_overlapping_bodies():
				var key_overlaping = marker.get_overlapping_bodies()[0]
				if key_overlaping.keycode == event.keycode:
					_gain_progress()
					keys.remove_child(key_overlaping)
				else:
					_lose_progress()
					keys.remove_child(keys.get_children()[0])
			else:
				_lose_progress()

func _start(spawn_key_time, minigame_time, speed):
	visible = true
	key_speed = speed
	key_spawn_timer.start(spawn_key_time)
	timer.start(minigame_time)

func _spawn_key():
	if (not timer.is_stopped()) and visible:
		var new_key = key_scene.instantiate()
		new_key.speed = key_speed
		keys.add_child(new_key)
		var keycode_r = _generate_random_key()
		new_key.set_key(keycode_r)
	else:
		key_spawn_timer.stop()

func _end():
	key_spawn_timer.stop()
	visible = false
	for key in keys.get_children():
		keys.remove_child(key)
		key.queue_free()
	Signals.end_minigame.emit()
	
#Generates a in between 65-A and 90-Z
func _generate_random_key():
	return randi_range(65, 90)


func _on_marker_key_exited(body):
	if visible:
		keys.remove_child(body)
		_lose_progress()

func _gain_progress():
	audio.stream = correct_audio
	audio.play()
	Signals.add_progress_score.emit(0.3)

func _lose_progress():
	audio.stream = wrong_audio
	audio.play()
	Signals.add_progress_score.emit(-0.3)
