extends Player

#Player script
class_name PlayerShip

#onready variables
onready var anim := $AnimatedSprites
onready var laser := $Laser


#Physics process function: executing all the function under the conditions
func _physics_process(delta: float) -> void:
	direction = Vector2.ZERO
	_speed()
	_thruster_update()
	_thruster_anim(anim)
	_rotation(delta)
	_move(delta)
	_firing(laser)
	if laser.is_casting:
		_attacking(laser)
	if PlayerData.HP <= 0.0:
		_killed()
