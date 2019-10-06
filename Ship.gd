extends Node2D

var Scaffold = preload("res://Scaffold.tscn")
var WingL = preload("res://WingL.tscn")
var WingR = preload("res://WingR.tscn")

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
		'wing-left':
			print('added wing left')
			angularVelocity += 0.2
			var node = WingL.instance()
			print("instancing")
			print(node)
			joint.attach(node)
		'wing-right':
			print('added wing right')
			angularVelocity += 0.2
			joint.attach(WingR.instance())
		'hull':
			print('added hull')
			joint.attach(Scaffold.instance())
			

func add_resource(resourceType: String):
	match resourceType:
		"fuel":
			fuel += 20


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
