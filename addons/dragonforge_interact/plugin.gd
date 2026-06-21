@tool
extends EditorPlugin

const INTERACT_ACTION = "interact"


func _enable_plugin() -> void:
	InputMapAction.add(INTERACT_ACTION, InputMapAction.key(KEY_E), InputMapAction.joy_button(JOY_BUTTON_X), InputMapAction.mouse_button(MOUSE_BUTTON_LEFT))
	print_rich("[color=yellow][b]WARNING[/b][/color]: Project must be reloaded for InputMap changes to appear. [color=ivory][b]Project -> Reload Current Project[/b][/color]")


func _disable_plugin() -> void:
	InputMapAction.remove(INTERACT_ACTION)
	print_rich("[color=yellow][b]WARNING[/b][/color]: Project must be reloaded for InputMap changes to appear. [color=ivory][b]Project -> Reload Current Project[/b][/color]")
