@icon("uid://ccdwe1ilegtjt")
class_name Crosshair extends TextureRect

@export var interaction_ray_cast_3d: InteractionRayCast3D
@export var interaction_shape_cast_3d: InteractionShapeCast3D
@export var highlight_color: Color = Color.CHARTREUSE

var game: Variant


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	set_anchors_and_offsets_preset(Control.PRESET_CENTER, Control.PRESET_MODE_KEEP_SIZE)
	if get_tree().root.has_node("Game"):
		game = get_tree().root.get_node("Game")
		game.pause_changed.connect(_on_pause_changed)
		set_process(false)
	if interaction_ray_cast_3d:
		interaction_ray_cast_3d.interactable_detected.connect(_on_interactable_detected)
		interaction_ray_cast_3d.interactable_lost.connect(_on_interactable_lost)
	if interaction_shape_cast_3d:
		interaction_shape_cast_3d.interactable_detected.connect(_on_interactable_detected)
		interaction_shape_cast_3d.interactable_lost.connect(_on_interactable_lost)


# Handles hiding the crosshair when the game is paused, and showing it when the
# game is being played. Only works if the Dragonforge game Template Plugin
# is being used. Otherwise we rely on _process() to handle this.
func _on_pause_changed() -> void:
	if game.is_paused():
		hide()
	else:
		show()


# Handles hiding the crosshair when the game is paused, and showing it when the
# game is being played. Only used if Dragonforge Game Template is not installed.
func _process(delta: float) -> void:
	if get_tree().paused:
		hide()
	else:
		show()


func _on_interactable_detected() -> void:
	modulate = highlight_color


func _on_interactable_lost() -> void:
	modulate = Color.WHITE
