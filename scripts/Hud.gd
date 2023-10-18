extends Control

func _ready ():
	Signals.change_hunger.connect(_on_change_hunger)
	Signals.change_energy.connect(_on_change_energy)
	Signals.change_motivation.connect(_on_change_motivation)
	Signals.change_progress.connect(_on_change_progress)
	Signals.change_day_progress.connect(_on_change_day_progress)
	Signals.change_money.connect(_on_change_money)

func _on_change_progress(new):
	$ProjectProgress.set_value_no_signal(27.0 + float(73*new/100))
	$ProjectProgress/Label.text = str(new) + "%"

func _on_change_hunger(new):
	$HungerProgressBar.set_value_no_signal(new)

func _on_change_energy(new):
	$EnergyProgressBar.set_value_no_signal(new)

func _on_change_motivation(new):
	$MotivationProgressBar.set_value_no_signal(new)

func _on_change_day_progress(new):
	$DayProgress.set_value_no_signal(new)

func _on_change_money(new):
	$Money/Label.text = str(new)
