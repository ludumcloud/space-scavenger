extends Node2D

var Scaffold = preload("res://Scaffold.tscn")

var ship = null

var angularVelocity = 0.5
var fuel = 20

# Called when the node enters the scene tree for the first time.
func _ready():
	ship = $Cockpit

func can_attach(compType: String):
	var joint = ship.search_joints(compType)
	return joint != null

# pretty much the same as above, but with actions
func do_attach(compType: String):
	var joint = ship.search_joints(compType)
	if joint == null:
		return
	
	
	match compType:
		'wing':
			print('added wing')
			angularVelocity += 0.2
		'hull':
			print('added hull')
			joint.joint.add_child(Scaffold.instance())
			

func add_resource(resourceType: String):
	match resourceType:
		"fuel":
			fuel += 20


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
