@icon("uid://ck238sqeqye0m")
## Add this [Interact] component to a [StaticBody3D], [RigidBody3D] or
## [MeshInstance3D] node and when the player mouses over any of the
## [StaticBody3D] or [RigidBody3D] nodes, the [member highlight_material] will
## be applied as an overlay material to all attached [MeshInstance3D] nodes. If
## no [member highlight_material] is defined, the default highlight material
## will be used.
class_name Highlight extends Interact

const INTERACTABLE_HIGHLIGHT = preload("uid://cim6co3oq08vt")

## A custom highlight material to use when this object has focus.
## Leaving this blank will use the default highlight material.
@export var highlight_material: Material = INTERACTABLE_HIGHLIGHT

var _mesh_list: Array[Node]


func _ready() -> void:
	super()
	_connect_meshes(get_parent())


func _connect_meshes(node: Node) -> void:
	if node is MeshInstance3D:
		_mesh_list.append(node)
	for subnode in node.get_children():
		_connect_meshes(subnode)


func _add_highlight() -> void:
	for mesh in _mesh_list:
		mesh.material_overlay = highlight_material


func _remove_highlight() -> void:
	for mesh in _mesh_list:
		mesh.material_overlay = null


func _on_mouse_entered() -> void:
	super()
	_add_highlight()


func _on_mouse_exited() -> void:
	super()
	_remove_highlight()
