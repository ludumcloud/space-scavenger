extends Node2D
class_name Component

class ComponentJoint:
	var types: Array
	var joint: Node2D
	# This was initially typed but .initialize() only returns Node2D
	var component
	
	func _init(compTypes: Array, initJoint: Node2D):
		types = compTypes
		joint = initJoint
		component = null

	func can_attach(compType: String):
		return types.has(compType) and (component == null)

	func attach(comp):
		joint.add_child(comp)
		component = comp

var joints = []

func get_joints():
	return joints

static func make_joint(compTypes: Array, initJoint: Node2D):
	return ComponentJoint.new(compTypes, initJoint)

func search_joints(compType: String):
	var attach_joint = null
	for joint in joints:
		# DFS for attachment points
		var component = joint.component
		if component != null:
			attach_joint = component.search_joints(compType)
			if attach_joint != null:
				break

		if joint.can_attach(compType):
			attach_joint = joint
			break

	return attach_joint
