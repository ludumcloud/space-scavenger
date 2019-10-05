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
var scaffold1: Component
var wingL: Component
var wingR: Component

# Called when the node enters the scene tree for the first time.
func _ready():
	ship = HullComponent.new($Cockpit)
	scaffold1 = HullComponent.new($Scaffold1)

	ship.add()
	ship.nextCenterComp = scaffold1

	wingL = Component.new($WingL)
	scaffold1.leftComp = wingL

	wingR = Component.new($WingR)
	scaffold1.rightComp = wingL


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
				elif (currentComp.nextCenterComp):
					currentComp = currentComp.nextCenterComp
			else:
				return false

func do_attach():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
