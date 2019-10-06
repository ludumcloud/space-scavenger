extends Node2D

var Scaffold = preload("res://Scaffold.tscn")
var WingL = preload("res://WingL.tscn")
var WingR = preload("res://WingR.tscn")
var EngineL = preload("res://EngineAL.tscn")
var EngineR = preload("res://EngineAR.tscn")

var ship = null

var angularVelocity = 1.5
var angle = 0 * PI
var shipVelocity = Vector2(0.0, 0.0)
var maxShipSpeed = 5.0
var fuel = 20

var hullNum = 0;
var engineNum = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	ship = $Cockpit

func reinit():
	print('BOOOOOOOOOOOOOOOOOOOOM!!!!!!!!!!!!!');

func can_attach(compType: String):
	var joint = ship.search_joints(compType)
	return joint != null

# pretty much the same as above, but with actions
func do_attach(compType: String):
	var joint = ship.search_joints(compType)
	if joint == null:
		return
	
	hullNum += 1
	match compType:
		'wing-left':
			print('added wing left')
			angularVelocity += 0.4
			joint.attach(WingL.instance())
		'wing-right':
			print('added wing right')
			angularVelocity += 0.4
			joint.attach(WingR.instance())
		'engine-left':
			print('added engine left')
			maxShipSpeed += 1
			joint.attach(EngineL.instance())
			engineNum += 1
		'engine-right':
			print('added engine right')
			maxShipSpeed += 1
			joint.attach(EngineR.instance())
			engineNum += 1
		'hull':
			print('added hull')
			joint.attach(Scaffold.instance())
			

func add_resource(resourceType: String):
	match resourceType:
		"fuel":
			fuel += 20


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if shipVelocity.length() > 0:
		fuel -= engineNum  * delta
