extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	Signals.day_change_start.connect(_set_texts)

func _set_texts(nextDay, days_left):
	if(nextDay == 1):
		print("Primer día")
	if(days_left == 1):
		print("Ultimo dia")
	$Labels/Days.text = "Día %s" % str(nextDay)
	$Labels/DaysLeft.text = "Faltan %s días para la fecha límite" % str(days_left)
	visible = true

func _process(_delta):
	if(Input.is_action_just_pressed("finish_day") and visible):
		Signals.day_change_end.emit()

func _draw():
	draw_rect(Rect2(0,0, 1280, 720), Color(Color.DIM_GRAY, 0.9))
