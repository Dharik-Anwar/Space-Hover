extends KinematicBody2D

#Enemy's functions
class_name Enemy

#CONSTANTS
const MIN_SPEED : float = 200.0
const MAX_SPEED : float = 300.0
const DEFAULT_MASS: = 35.0
const DISTANCE_THRESHOLD: = 35.0
const LASER : int = 1
const SCORE : int = 5

#variables
var HP := 100 setget set_HP
var velocity : Vector2 = Vector2.ZERO
var rand_speed = rand_range(MIN_SPEED, MAX_SPEED)


#Steering function for smooth movement
static func _follow(
		velocity: Vector2,
		position: Vector2,
		target_position: Vector2,
		speed,
		mass: = DEFAULT_MASS
	) -> Vector2:
	
	var desired_direction: Vector2 = (target_position - position).normalized() * speed
	var steering: Vector2 = (desired_direction - velocity) / mass
	return (velocity + steering)


#initialze: similar to a constructor to initialize the velocity
func _initialize(start: Vector2, player: Vector2) -> void:
	position = start
	look_at(player)
	rotation += PI/2
	velocity = Vector2.UP * rand_speed
	velocity = velocity.rotated(rotation)


#function to follow the player
func _follow_player(
		node_position: Vector2,
		target_position: Vector2,
		enemy: KinematicBody2D
	) -> void:
	
	if node_position.distance_to(target_position) <= DISTANCE_THRESHOLD:
		velocity = Vector2.ZERO
		return 
	velocity = _follow(velocity, global_position, target_position, rand_speed)
	velocity = move_and_slide(velocity)
	enemy.rotation = velocity.angle() + PI/2


#function to fire the laser
func _fire(laser: RayCast2D) -> void:
	#cast the laser when it collid with player
	laser.is_casting = laser.is_colliding()


#function to set HP for enemy
func set_HP(value: int) -> void:
	HP = value


#Enemy killed function
func _killed() -> void:
	#When HP of the enemy reaches zero
	#Update player score
	#queue_free() the enemy
	if HP <= 0:
		PlayerData.score += SCORE
		queue_free()
