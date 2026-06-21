extends Label3D


func _ready() -> void:
	for interact in get_parent().get_children():
		if interact is Interact:
			interact.action_pressed.connect(_on_interact_action_pressed)


func _on_interact_action_pressed() -> void:
	text = "Clicked!"
	await get_tree().create_timer(0.7).timeout
	text = "Test"
