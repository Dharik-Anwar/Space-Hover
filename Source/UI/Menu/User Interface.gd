extends Control

#User Interface script
class_name UserInterface

#export variable
export(PackedScene) var end_menu

#onready variables
onready var scene_tree := get_tree()
onready var HP_Progress : TextureProgress = $ProgressBars/HPBar/Progress
onready var Thruster_Progress : TextureProgress = $ProgressBars/ThrusterBar/Progress
onready var score : Label = $Score
onready var pause_overlay := $PauseOverlay

#variable
var paused := false setget set_paused


#Ready function
func _ready() -> void:
	PlayerData.connect("score_updated", self, "_update_interface")
	PlayerData.connect("player_died", self, "_player_died")
	PlayerData.connect("fuel_changed", self, "_update_interface")
	PlayerData.connect("player_attacked", self, "_update_interface")
	_update_interface()


#Process function
func _process(delta: float) -> void:
	if paused:
		Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


#function to open the pause menu and pause the game
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("Pause") and pause_overlay.visible == false:
		self.paused = not paused
		scene_tree.set_input_as_handled()


#function to end the game when player dead
func _player_died() -> void:
	scene_tree.change_scene_to(end_menu)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


#function to update the interface
func _update_interface() -> void:
	score.text = "SCORE : %s" % PlayerData.score
	HP_Progress.value = PlayerData.HP
	Thruster_Progress.value = PlayerData.Thruster


#function to set the pause
func set_paused(value: bool) -> void:
	paused = value
	scene_tree.paused = paused
	pause_overlay.visible = paused


#function to continue the game when continue button is pressed
func _on_ContinueButton_pressed() -> void:
	paused = false
	scene_tree.paused = false
	pause_overlay.visible = false
