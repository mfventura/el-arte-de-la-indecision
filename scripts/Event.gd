extends Control

var current_event : Dictionary

#Nodes
var title_label : Label
var title_image : TextureRect
var decision1_button : TextureButton
var decision1_label : Label
var decision2_button : TextureButton
var decision2_label : Label
var decision3_button : TextureButton
var decision3_label : Label
# Called when the node enters the scene tree for the first time.
func _ready():
	Signals.event.connect(_show_event)
	
	title_label = $Title/Title
	title_image = $Title
	decision1_button = $Decisions/Decision1
	decision1_label = $Decisions/Decision1/Title
	decision2_button = $Decisions/Decision2
	decision2_label = $Decisions/Decision2/Title
	decision3_button = $Decisions/Decision3
	decision3_label = $Decisions/Decision3/Title
	
	pass # Replace with function body.

func _show_event(event):
	visible = true
	current_event = event
	
	var def_font_size_title = 40
	var def_font_size_decision = 40
	
	title_label.text = TranslationServer.translate(event.get("event"))
	var text_w = title_label.get_theme_font("font").get_multiline_string_size(title_label.text).x
	var font_size = def_font_size_title * (title_image.size.x / text_w)
	title_label.set("theme_override_font_sizes/font_size", font_size)
	
	decision1_label.text = TranslationServer.translate(event.get("decisions")[0].text)
	text_w = decision1_label.get_theme_font("font").get_multiline_string_size(decision1_label.text).x
	font_size = def_font_size_decision * (decision1_button.size.x / text_w)
	decision1_label.set("theme_override_font_sizes/font_size", font_size)
	
	decision2_label.text = TranslationServer.translate(event.get("decisions")[1].text)
	text_w = decision2_label.get_theme_font("font").get_multiline_string_size(decision2_label.text).x
	font_size = def_font_size_decision * (decision2_button.size.x / text_w)
	decision2_label.set("theme_override_font_sizes/font_size", font_size)
	
	decision3_label.text = TranslationServer.translate(event.get("decisions")[2].text)
	text_w = decision3_label.get_theme_font("font").get_multiline_string_size(decision3_label.text).x
	font_size = def_font_size_decision * (decision3_button.size.x / text_w)
	decision3_label.set("theme_override_font_sizes/font_size", font_size)


func _on_decision_1_pressed():
	Signals.pick_decision.emit(current_event.get("decisions")[0])

func _on_decision_2_pressed():
	Signals.pick_decision.emit(current_event.get("decisions")[1])

func _on_decision_3_pressed():
	Signals.pick_decision.emit(current_event.get("decisions")[2])

func _draw():
	draw_rect(Rect2(0,0, 1280, 720), Color(Color.DIM_GRAY, 0.4))
