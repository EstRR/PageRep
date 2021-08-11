extends SpinBox


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var line = get_line_edit()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_SpinBox_value_changed(value):
	apply()
	line.text = String(value)
