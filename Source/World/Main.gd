extends Node

#Main world script
class_name Main

#export variable
export(PackedScene) var enemy_ship

#onready variables
onready var player = $PlayerShip
onready var enemy_node = $Enemy


#Ready function
func _ready() -> void:
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	PlayerData.reset()


#Process function
func _process(delta: float) -> void:
	$EnemySpawnPath2D.position = $PlayerShip.position - Vector2(1024.5, 576)
	$EnemyDespawn.position = $PlayerShip.position


#function to spawn the enemies when the timer time out
func _on_EnemyTimer_timeout() -> void:
	var enemy_spawn_location = $EnemySpawnPath2D/EnemySpawnPathFollow2D
	enemy_spawn_location.offset = randi()
	var enemy = enemy_ship.instance()
	enemy_node.add_child(enemy)
	enemy.position = enemy_spawn_location.position
	enemy._initialize(enemy.position, player.position)


#Despawn the enemies which exits the despawn region
func _on_EnemyDespawn_body_exited(body: Node) -> void:
	body.queue_free()
