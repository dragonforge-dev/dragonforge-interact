extends Node


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		get_tree().paused = !get_tree().paused
		if get_tree().paused:
			print("PAUSED")
		else:
			print("UNPAUSED")
