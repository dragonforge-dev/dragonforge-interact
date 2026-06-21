extends Camera3D

var sensitivity: float = 0.0075
var look := Vector2.ZERO

@onready var horizontal_pivot: Node3D = $".."
var speed = 5.0


func _input(event: InputEvent) -> void:
	if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED and event is InputEventMouseMotion and not get_tree().paused:
		look = -event.relative * sensitivity


func _physics_process(delta: float) -> void:
	if get_tree().paused:
		return
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down").normalized()
	horizontal_pivot.position += Vector3(input_dir.x, 0.0, input_dir.y) * speed * delta
	horizontal_pivot.rotate_y(look.x)
	rotate_x(look.y)
	look = Vector2.ZERO


func _process(_delta: float) -> void:
	if get_tree().paused:
		horizontal_pivot.position = Vector3(1.479, 0.955, 1.899)
		horizontal_pivot.rotation = Vector3.ZERO
		rotation_degrees = Vector3(-20.2, 16.1, 0.0)
