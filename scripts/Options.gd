extends Control


@export
var language_button : Button
@export
var fullscreen_button : CheckButton

# Called when the node enters the scene tree for the first time.
func _ready():
	var current_locale = TranslationServer.get_locale()
	language_button.text = current_locale.to_upper()
	


func _on_language_button_pressed():
	var new_locale = get_next_locale()
	TranslationServer.set_locale(new_locale)
	language_button.text = new_locale.to_upper()

func get_next_locale():
	var current_locale = TranslationServer.get_locale()
	if(current_locale == "es_ES"):
		return "en_EN"
	else:
		return "es_ES"

func _on_full_screen_button_toggled(button_pressed):
	var mode = DisplayServer.WINDOW_MODE_FULLSCREEN
	if(not button_pressed):
		mode = DisplayServer.WINDOW_MODE_WINDOWED
	DisplayServer.window_set_mode(mode)


func _on_back_button_pressed():
	Signals.options_back.emit()
