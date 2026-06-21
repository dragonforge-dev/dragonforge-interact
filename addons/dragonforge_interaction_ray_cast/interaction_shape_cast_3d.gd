class_name InteractionShapeCast3D extends ShapeCast3D

signal interactable_detected
signal interactable_lost

var _last_interactable: Interact:
	set(value):
		if value == null and _last_interactable:
			_last_interactable._on_mouse_exited()
			interactable_lost.emit()
			_last_interactable.tree_exiting.disconnect(_on_interactable_destroyed)
		else:
			interactable_detected.emit()
			value.tree_exiting.connect(_on_interactable_destroyed)
		
		_last_interactable = value


func _physics_process(_delta: float) -> void:
	if is_colliding():
		for i in range(get_collision_count()):
			var collider: Node = get_collider(i)
		
			var interactable: Interact = get_interact_node_in(collider)
			if interactable:
				# If we haven't changed colliders, do nothing.
				if interactable == _last_interactable:
					return
				# If we were on an Interact node, let it know we've moved off.
				if _last_interactable:
					_last_interactable = null
				_last_interactable = interactable
				_last_interactable._on_mouse_entered()
				# Once we've found an interactiable, stop processing. This is 
				# basically a fat RayCast3D
				break
	# If we have no collider, but were on an Interact node, let it know we've moved off.
	elif _last_interactable:
		_last_interactable = null


## Return an [Interact] node if it is attached to the passed collider [Node],
## otherwise retun null.
func get_interact_node_in(collider: Node) -> Interact:
	for node in collider.get_children():
		if node is Interact:
			return node
	return _search_up_for_interactable(collider)
	return null


# If the [StaticBody3D] or [RigidBody3D] we are colliding with is not the parent
# object, then we search up the tree until we find something that contains an
# [Interact] or doesn't look like it's a part of this object.
func _search_up_for_interactable(node: Node) -> Interact:
	var parent = node.get_parent()
	for subnode in parent.get_children():
		if subnode is Interact:
			return subnode
	if parent is MeshInstance3D or parent is StaticBody3D or parent is RigidBody3D:
		return _search_up_for_interactable(parent)
	return null


func _on_interactable_destroyed() -> void:
	interactable_lost.emit()
