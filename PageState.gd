extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_Values(var node_name: int, var value, var Age, var insert, var status: String):
	var val = get_node("VBoxContainer/HBoxContainer/ValueColumn/Val" + String(node_name))
	
	if value < 0:
		val.text = "empty"
	else:
		val.text = String(value)
		
	val = get_node("VBoxContainer/HBoxContainer/AgeColumn/A_val" + String(node_name))
	if Age < 0:
		val.text = "0"
	else:
		val.text = String(Age)
		
	val = get_node("VBoxContainer/Insert")
	val.text = "Search: "+ String(insert)
	val = get_node("VBoxContainer/Stat")
	val.text = status



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
