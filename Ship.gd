extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
class Component:
	var added: bool
	var node: Node2D

	func _init(compNode: Node2D):
		added = false
		node = compNode
		compNode.hide()

	func add():
		added = true
		node.show()

class HullComponent extends Component:
	var nextCenterComp: Component

	var leftComp: Component
	var rightComp: Component

	func _init(compNode: Node2D).(compNode):
		pass

var ship: Component
var hull1: Component
var hull2: Component
var hull3: Component
var hull4: Component
var hull5: Component
var wingL: Component
var wingR: Component

var angularVelocity = 1.0

# Called when the node enters the scene tree for the first time.
func _ready():
	ship = HullComponent.new($Cockpit)
	hull1 = HullComponent.new($Scaffold1)
	hull2 = HullComponent.new($Scaffold2)
	hull3 = HullComponent.new($Scaffold3)
	hull4 = HullComponent.new($Scaffold4)
	hull5 = HullComponent.new($Scaffold5)

	ship.add()
	ship.nextCenterComp = hull1
	hull1.nextCenterComp = hull2
	hull2.nextCenterComp = hull3
	hull3.nextCenterComp = hull4
	hull4.nextCenterComp = hull5

	wingL = Component.new($WingL)
	hull1.leftComp = wingL

	wingR = Component.new($WingR)
	hull1.rightComp = wingL


func can_attach(compType: String):
	var currentComp = ship.nextCenterComp

	# Hulls are special and can only be attached as a "center" component
	if (compType == 'hull'):
		while (currentComp != null):
			if (currentComp.added):
				currentComp = currentComp.nextCenterComp
			else:
				return true

		# couldn't find a center comp that was not added, break
		return false
	else:
		# for all other component types, we walk the center parts and
		# check if the left and right spots are open
		while (currentComp != null):
			if (currentComp.added):
				# if current comp was added, check if we can add to the left or right
				# side, if not, continue down the hull
				if (currentComp.leftComp.added == false || currentComp.rightComp.added == false):
					return true
				else:
					currentComp = currentComp.nextCenterComp
			else:
				return false


func _add_leaf_component(component: Component, compType: String):
	component.add()
	match compType:
		'wing':
			print('added wing')
			angularVelocity += 0.2

# pretty much the same as above, but with actions
func do_attach(compType: String):
	var currentComp = ship.nextCenterComp

	if (compType == 'hull'):
		while (currentComp != null):
			if (currentComp.added):
				currentComp = currentComp.nextCenterComp
			else:
				currentComp.add()
				return
	else:
		while (currentComp != null):
			if (currentComp.added):
				if (currentComp.leftComp != null && currentComp.leftComp.added == false):
					_add_leaf_component(currentComp.leftComp, compType)
				elif (currentComp.rightComp != null && currentComp.rightComp.added == false):
					_add_leaf_component(currentComp.rightComp, compType)
				else:
					currentComp = currentComp.nextCenterComp
			else:
				return


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
