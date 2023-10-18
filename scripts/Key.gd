extends RigidBody2D

var keycode
@onready var key_label = $Sprite2D/Label
var speed

func _physics_process(_delta):
	linear_velocity = Vector2(-speed, 0)

func set_key(key):
	keycode = key
	key_label.text = OS.get_keycode_string(keycode)
