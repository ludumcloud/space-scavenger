extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
class Component:
	var added: bool
	var node: Node2D
	var subComps: Array
	
	func _init(compNode: Node2D):
		added = false
		node = compNode
		compNode.hide()
		
	func add():
		added = true
		node.show()

var ship = Component.new($Cockpit)
var scaffold1 = Component.new($Scaffold1)


# Called when the node enters the scene tree for the first time.
func _ready():
	ship.add()
	ship.subComps.append(scaffold1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
