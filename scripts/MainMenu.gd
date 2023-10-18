extends Control

var audio : AudioStreamPlayer2D

func _ready():
	Signals.options_back.connect(_options_back)
	Signals.credits_back.connect(_options_back)
	audio = $Audio
	audio.stream = load("res://art/general.mp3")
	audio.play()

func _on_options_pressed():
	$Buttons.visible = false
	$Options.visible = true
	$Credits.visible = false

func _on_exit_pressed():
	get_tree().quit()


func _on_play_pressed():
	var gameScene = load("res://scenes/Game.tscn")
	get_tree().change_scene_to_packed(gameScene)


func _on_credits_pressed():
	$Buttons.visible = false
	$Options.visible = false
	$Credits.visible = true

func _options_back():
	$Buttons.visible = true
	$Options.visible = false
	$Credits.visible = false
