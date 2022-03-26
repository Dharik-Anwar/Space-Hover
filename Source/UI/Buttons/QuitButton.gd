extends Button

#Quit button
class_name QuitButton


#If the button is pressed, quit the game
func _on_QuitButton_button_up() -> void:
	get_tree().quit()
