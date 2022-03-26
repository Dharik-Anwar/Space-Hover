extends Node

class_name Player_Data

#signals
signal score_updated
signal player_died
signal player_attacked
signal fuel_changed

#variables
var score = 0 setget set_score
var death = false setget set_death
var HP = 250 setget set_HP
var Thruster = 150.0 setget set_thruster


#reset function: to reset the datas of player
#everytime the game starts
func reset() -> void:
	score = 0
	death = false
	HP = 250
	Thruster = 150.0


#Score set function: emits signal when score changes
func set_score(value: int) -> void:
	score = value
	emit_signal("score_updated")


#Death function: emits the signal when player dead
func set_death(value: bool) -> void:
	death = value
	emit_signal("player_died")


#HP set function: emits signal when hp changes
func set_HP(value: int) -> void:
	HP = value
	emit_signal("player_attacked")


#Thruster function: emits signal when fuel changes
func set_thruster(value: float) -> void:
	Thruster = value
	emit_signal("fuel_changed")
