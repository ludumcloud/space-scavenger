extends Node2D
class_name Component

class ComponentJoint:
	var type: String
	var joint: Node2D
	# This was initially typed but .initialize() only returns Node2D
	var component
	
	func _init(compType: String, initJoint: Node2D):
		type = compType
		joint = initJoint
		component = null

	func can_attach(compType: String):
		return (compType == type) and (component == null)

	func attach(comp):
		joint.add_child(comp)
		component = comp

	func detach():
		if component != null:
			joint.remove_child(component)
			component = null

var joints = []

func get_joints():
	return joints

static func make_joint(compType: String, initJoint: Node2D):
	return ComponentJoint.new(compType, initJoint)

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

func clear_joints():
	for joint in joints:
		joint.detach()