extends KinematicBody2D

#Player functions
class_name Player

#CONSTANTS
const SPEED : float = 250.0
const BOOSTER : float = 500.0
const ANGULAR_SPEED : float = 2*PI/3
const ACCELERATION : float = 25.0
const LASER : int = 8

#variables
var move_speed : float
var velocity : Vector2 = Vector2.ZERO
var direction : Vector2


#function to set the speed of the player
func _speed() -> void:
	if PlayerData.Thruster == 0.0:
		move_speed = SPEED
		if Input.is_action_pressed("Ctrl"):
			PlayerData.Thruster = 0.0
		else:
			PlayerData.Thruster += 0.5
	elif Input.is_action_pressed("Ctrl") and Input.is_action_pressed("Move_forward"):
		move_speed = BOOSTER
		PlayerData.Thruster -= 0.8
	elif not Input.is_action_pressed("Ctrl"):
		PlayerData.Thruster += 0.5
		move_speed = SPEED


#function to rotate the player
func _rotation(delta : float) -> void:
	if Input.is_action_pressed("Rotate_left"):
		rotation -= ANGULAR_SPEED * delta
	elif Input.is_action_pressed("Rotate_right"):
		rotation += ANGULAR_SPEED * delta


#function to move the player
func _move(delta : float) -> void:
	direction.y = - Input.get_action_strength("Move_forward")
	direction = direction.rotated(rotation)
	velocity = lerp(velocity, move_speed * direction, ACCELERATION * delta )
	velocity = move_and_slide(velocity)


#function to update the thruster
func _thruster_update() -> void:
	if PlayerData.Thruster >= 150.0:
		PlayerData.Thruster = 150.0
	if PlayerData.Thruster <= 0.0:
		PlayerData.Thruster = 0.0


#function to fire the laser
func _firing(laser: RayCast2D) -> void:
	if Input.is_action_pressed("Space"):
		laser.is_casting = true
	else:
		laser.is_casting = false


#function for the player killed
func _killed() -> void:
	PlayerData.death = true


#fucntion to attack the enemy
func _attacking(laser: RayCast2D) -> void:
	if laser.get_collider() != null:
		laser.get_collider().HP -= LASER


#function to set the effects for boosting the speed
func _thruster_anim(anim: Node2D) -> void:
	if PlayerData.Thruster > 0.0 and Input.is_action_pressed("Ctrl") and Input.is_action_pressed("Move_forward"):
		anim.visible = true
	else:
		anim.visible = false
