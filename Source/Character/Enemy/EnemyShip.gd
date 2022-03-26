extends Enemy

#Enemy script
class_name EnemyShip

#onready variables
onready var enemy := $"."
onready var player := get_parent().get_parent().get_node("PlayerShip")
onready var laser := $Laser

#variables
var detect : bool = false


#Ready function
func _ready() -> void:
	set_physics_process(detect)


#Process function: activate when physics process is false
func _process(delta: float) -> void:
	move_and_slide(velocity) #move the player
	_killed() #enemy killed function execute


#Physics process: activate when the enemy detects the player
func _physics_process(delta: float) -> void:
	_follow_player(global_position, player.global_position, enemy) #follow the player
	_fire(laser) #fire the laser at the player
	_killed() #enemy killed function execute


#If the player enter the detection region
func _on_PlayerEnter_body_entered(body: Node) -> void:
	detect = true
	set_process(not detect)
	set_physics_process(detect)


#If the player exit the detection region
func _on_PlayerExit_body_exited(body: Node) -> void:
	detect = false
	set_process(not detect)
	set_physics_process(detect)


#If the laser hit the player reduce the HP of the player
func _on_Laser_hit() -> void:
	PlayerData.HP -= LASER
