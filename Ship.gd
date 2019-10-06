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
var maxShipSpeed = 4.0
var fuel = 0
var fuelMax = 100

var hullNum = 0
var engineNum = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	ship = $Cockpit
	reinit()

func reinit():
	ship.clear_joints()
	angularVelocity = 1.5
	shipVelocity = Vector2(0.0, 0.0)
	maxShipSpeed = 4.0
	fuel = 0
	fuelMax = 100
	hullNum = 0
	engineNum = 0
	get_parent().reset_time()

func can_attach(compType: String):
	var joint = ship.search_joints(compType)
	return joint != null

# pretty much the same as above, but with actions
func do_attach(compType: String, node):
	var joint = ship.search_joints(compType)
	if joint == null:
		return

	hullNum += 1
	match compType:
		'wing-left':
			print('added wing left')
			angularVelocity += 0.4
		'wing-right':
			print('added wing right')
			angularVelocity += 0.4
		'engine-left':
			print('added engine left')
			engineNum += 1
		'engine-right':
			print('added engine right')
			engineNum += 1
		'hull':
			print('added hull')
			fuelMax += 100
		'hull-left':
			print('added hull left')
			fuelMax += 50
		'hull-rigth':
			print('added hull right')
			fuelMax += 50
	joint.attach(node)

func add_resource(resourceType: String):
	match resourceType:
		"fuel":
			fuel += 20
			if fuel > fuelMax:
				fuel = fuelMax

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if fuel < 0:
		maxShipSpeed = 4.0
	else:
		maxShipSpeed = 6.0 + (engineNum * 3)
	
	maxShipSpeed -= hullNum * 1.0

	if shipVelocity.length() > 0 && fuel > 0:
		fuel -= engineNum  * delta
