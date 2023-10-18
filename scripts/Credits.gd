extends Control

func _on_button_pressed():
	Signals.credits_back.emit()
