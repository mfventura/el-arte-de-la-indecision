extends Node

#HUD
signal change_hunger(new_value)
signal change_energy(new_value)
signal change_motivation(new_value)
signal change_money(new_value)
signal change_progress(new_value)

signal day_change_start(next_day, days_left)
signal day_change_end
signal event(event)
signal pick_decision(consequence)
signal options_back
signal change_day_progress(new)
signal start_minigame
signal end_minigame
signal add_progress_score(value)
signal credits_back
