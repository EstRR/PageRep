extends Node2D

onready var P_Algo_Option = $VBoxContainer/HBoxContainer/VBoxContainer/PageRepAlgo/OptionButton
onready var Stream_Box = $VBoxContainer/HBoxContainer/VBoxContainer2/StreamValues
onready var Num_Pages = $VBoxContainer/HBoxContainer/VBoxContainer/MaxAge/SpinBox
onready var StatesHBox = $VBoxContainer/HBoxContainer2/NinePatchRect/ScrollContainer/States

var Page_State = preload("res://PageState.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func updatePages(var Ages: Array):
	for i in Ages.size():
		Ages[i] -= 1
	return Ages

func LookForOldest(var Ages: Array):
	var curr_oldest = 0;
	for i in Ages.size():
		if Ages[curr_oldest] > Ages[i]:
			curr_oldest = i
	return curr_oldest


func inPageTable(var Values: Array, var search):
	for i in Values.size():
		if Values[i] == search:
			return i
	return -1

func LRU(var values: Array, var pages: int):
	var curr_val: Array
	var curr_age: Array
	var oldest: int
	var indx: int
	var StateBox
	var val_tag = "A_val"
	var age_tag = "Val"
	
	for i in pages:
		curr_val.push_back(-1)
		curr_age.push_back(-1)
	
	for i in values.size():
		var stats: String
		indx = inPageTable(curr_val, values[i])
		if indx >= 0 :
			curr_age = updatePages(curr_age)
			curr_age[indx] = pages
			stats = "Hit"
		else:
			curr_age = updatePages(curr_age)
			oldest = LookForOldest(curr_age)
			curr_age[oldest] = pages
			curr_val[oldest] = values[i]
			stats = "Miss"
			
		StateBox = Page_State.instance()
		for j in curr_age.size():
			StateBox.set_Values(j + 1, curr_val[j], curr_age[j], values[i], stats)
			
		StatesHBox.add_child(StateBox)
		print("added child : ", i)
		
	StateBox = Page_State.instance()
	StatesHBox.add_child(StateBox)

func FIFO(var values: Array, var pages: int):
	var curr_val: Array
	var curr_age: Array
	var oldest: int
	var indx: int
	var StateBox
	var val_tag = "A_val"
	var age_tag = "Val"
	
	for i in pages:
		curr_val.push_back(-1)
		curr_age.push_back(-1)
	
	for i in values.size():
		var stats: String
		indx = inPageTable(curr_val, values[i])
		if indx >= 0 :
			stats = "Hit"
		else:
			curr_age = updatePages(curr_age)
			oldest = LookForOldest(curr_age)
			curr_age[oldest] = pages
			curr_val[oldest] = values[i]
			stats = "Miss"
			
		StateBox = Page_State.instance()
		for j in curr_age.size():
			StateBox.set_Values(j + 1, curr_val[j], curr_age[j], values[i], stats)
			
		StatesHBox.add_child(StateBox)
		print("added child : ", i)
		
	StateBox = Page_State.instance()
	StatesHBox.add_child(StateBox)
	

func _on_Simulate_pressed():
	var string_of_values = Stream_Box.text
	var P_algo = P_Algo_Option.get_selected_id()
	var Max_Pages = int(Num_Pages.value)
	var values = string_of_values.split_floats(" ", false)
	
	for child in StatesHBox.get_children():
		StatesHBox.remove_child(child)
		child.propagate_call("queue_free", [])
	
	if P_algo == 1:
		LRU(values, Max_Pages)
	else:
		FIFO(values, Max_Pages)
	



# Button is pressed
#	get string of values
#	get paging algorithm 
#	get the number of pages
#
