extends Control

#End Menu
class_name EndMenu

#onready variable
onready var label : Label = $Score


#Ready function
func _ready() -> void:
	#Print the score on the screen
	label.text = label.text % PlayerData.score
