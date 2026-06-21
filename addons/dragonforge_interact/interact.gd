@icon("uid://c1drhxy75fnt3")
## Add this to a [StaticBody3D], [RigidBody3D] or [MeshInstance3D] node and when
##  the player mouses over any of the [StaticBody3D] or [RigidBody3D] nodes, the
## [member hover_mouse_cursor] will be shown. When clicked, the
## [member click_mouse_cursor] will be shown and the [signal interact] will be
## emitted.
class_name Interact extends Node

## Emitted when the "interact" action is pressed and _is_mouse_hovering is true.
## This is used to emulate the mouse using an [InterctionRayCast3D].
signal action_pressed

const HAND_THIN_CLOSED = preload("uid://djucjwd7o2d4w")
const HAND_THIN_OPEN = preload("uid://mygpecafjjhm")
const HAND_THIN_POINT = preload("uid://cob3ylfmwc7bg")

## An image to change the mouse cursor to when the mouse cursor is hovering over
## the object.
@export var hover_mouse_cursor: Texture2D = HAND_THIN_OPEN
## The offset for the [member hover_mouse_cursor] hotspot.
@export var hover_mouse_cursor_hotspot: Vector2 = Vector2(8, 4)
## An image to change the mouse cursor to when the mouse cursor is hovering over
## the object, and the user clicks.
@export var click_mouse_cursor: Texture2D = HAND_THIN_CLOSED
## The offset for the [member click_mouse_cursor] hotspot.
@export var click_mouse_cursor_hotspot: Vector2 = Vector2(8, 4)
## The default image to change the mouse cursor to when the object is not
## being hovered over. Setting this to `null` resets it to the system default.
@export var default_mouse_cursor: Texture2D = HAND_THIN_POINT
## The offset for the [member default_mouse_cursor] hotspot.
@export var default_mouse_cursor_hotspot: Vector2 = Vector2(8, 4)
## The amount of time the mouse curosr displays the [member click_mouse_cursor]  before reverting to the
## [member default_mouse_cursor].
@export var click_time: float = 0.3

var _is_mouse_hovering: bool = false
var _click_timer: Timer


func _ready() -> void:
	_connect_mouse(get_parent())
	
	_click_timer = Timer.new()
	_click_timer.one_shot = true
	add_child(_click_timer)
	_click_timer.timeout.connect(_on_click_timer_timeout)


func _input(event: InputEvent) -> void:
	if _is_mouse_hovering and event.is_action("interact"):
		if event.is_pressed():
			Input.set_custom_mouse_cursor(click_mouse_cursor, Input.CURSOR_ARROW, click_mouse_cursor_hotspot)
			action_pressed.emit()
		else:
			_click_timer.start(click_time)


func _connect_mouse(node: Node) -> void:
	if node is StaticBody3D or node is RigidBody3D:
		node.mouse_entered.connect(_on_mouse_entered)
		node.mouse_exited.connect(_on_mouse_exited)
	for subnode in node.get_children():
		_connect_mouse(subnode)


func _on_mouse_entered() -> void:
	_is_mouse_hovering = true
	Input.set_custom_mouse_cursor(hover_mouse_cursor, Input.CURSOR_ARROW, hover_mouse_cursor_hotspot)


func _on_mouse_exited() -> void:
	_is_mouse_hovering = false
	Input.set_custom_mouse_cursor(default_mouse_cursor, Input.CURSOR_ARROW, default_mouse_cursor_hotspot)


func _on_click_timer_timeout() -> void:
	if _is_mouse_hovering:
		Input.set_custom_mouse_cursor(hover_mouse_cursor, Input.CURSOR_ARROW, hover_mouse_cursor_hotspot)
	else:
		Input.set_custom_mouse_cursor(default_mouse_cursor, Input.CURSOR_ARROW, default_mouse_cursor_hotspot)
