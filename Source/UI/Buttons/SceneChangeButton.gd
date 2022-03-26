tool
extends Button

#Scene changing button
class_name SceneChangeButton

#next scene file path
export(String, FILE) var next_scene: = ""


#config warning
func _get_configuration_warning() -> String:
	return "next_scene must be set" if next_scene=="" else ""


#If the button is pressed, change the next scene
func _on_SceneChangeButton_pressed() -> void:
	get_tree().change_scene(next_scene)
