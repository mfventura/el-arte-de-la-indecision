extends Node

var data : Dictionary = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	data = load_json_data()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func load_json_data():
	var filePath = "res://config/events.json"
	var file = FileAccess.open(filePath, FileAccess.READ)
	return JSON.parse_string(file.get_as_text())
