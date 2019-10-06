extends Node2D

var CollComponent = preload("res://CollComponent.tscn")
var CollResource = preload("res://CollResource.tscn")
var Mine = preload("res://Mine.tscn")
var rng = RandomNumberGenerator.new()

var zoomTransitionClicks = 0
var zoomTransitionStep = 0
var zoomTransitionTarget = 0

var currentZoomFactor = 0

var accTime = 0.0

var levelOneComponents = [
	"doepfer-wing-left",
	"doepfer-wing-right",
	"bastl-hull-simple",
	"mutable-engine-left",
	"mutable-engine-right",
	"basimilus-engine-left",
	"basimilus-engine-right",
]

var collectibles = [
	{ "type": "fuel", "weight": 10 },
	{ "type": "doepfer-hull-left", "weight": 1 },
	{ "type": "doepfer-hull-right", "weight": 1 },
	{ "type": "bastl-hull-simple", "weight": 2 },
	{ "type": "doepfer-wing-left", "weight": 1},
	{ "type": "doepfer-wing-right", "weight": 1 },
	{ "type": "mutable-engine-left", "weight": 2 },
	{ "type": "mutable-engine-right", "weight": 2 }
]

var stuffBag = []
func gen_bag():
	for obj in collectibles:
		for i in range(0, obj.weight):
			stuffBag.append(obj.type)

func generate_collectible_component(set):
	var compType = set[rng.randi_range(0, set.size()-1)]
	var component = CollComponent.instance()
	var initialPos = Vector2(rng.randi_range(0, 500), rng.randi_range(0, 500))
	component.init(compType, initialPos)
	self.add_child(component)

# Called when the node enters the scene tree for the first time.
func _ready():
	gen_bag()
	rng.randomize()
	var testComp = CollComponent.instance()
	testComp.init("bastl-hull-simple", Vector2(500, 300))

	var testComp2 = CollComponent.instance()
	testComp2.init("doepfer-wing-left", Vector2(300, 500))

	var testComp3 = CollComponent.instance()
	testComp3.init("mutable-engine-left", Vector2(350, 500))

	self.add_child(testComp)
	self.add_child(testComp2)
	self.add_child(testComp3)

	var testResc = CollResource.instance()
	testResc.init("fuel", Vector2(150, 100))
	self.add_child(testResc)


func calc_current_zoom():
	#
	# Allow for zooming transitions to generate
	# smooth zooming transitions when adding
	# to the ship.
	#u
	var zoomFactor = ($Ship.hullNum * 0.2) + 1;
	var needsUpdate = false

	if currentZoomFactor == 0:
		# Initialize from the scene
		currentZoomFactor = zoomFactor
		needsUpdate = true
	elif zoomFactor != currentZoomFactor:
		if zoomTransitionClicks == 0:
			zoomTransitionClicks = 20
			zoomTransitionStep = (zoomFactor - currentZoomFactor) / zoomTransitionClicks
		elif zoomTransitionClicks == 1:
			currentZoomFactor = zoomFactor # save exact float value for cmp
			needsUpdate = true
		else:
			currentZoomFactor += zoomTransitionStep
			needsUpdate = true

		zoomTransitionClicks -= 1

	if needsUpdate:
		$ParallaxBackground.set_scale(Vector2(currentZoomFactor, currentZoomFactor));
		$Ship/Camera2D.set_zoom(Vector2(currentZoomFactor, currentZoomFactor));


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	accTime += delta
	if stuffBag.size() == 0:
		gen_bag()
	if Input.is_action_pressed("ui_left"):
		$Ship.angle -= delta * $Ship.angularVelocity
	if Input.is_action_pressed("ui_right"):
		$Ship.angle += delta * $Ship.angularVelocity

	if Input.is_action_pressed("ui_up"):
		$Ship.shipVelocity = Vector2($Ship.maxShipSpeed * sin($Ship.angle), $Ship.maxShipSpeed * -cos($Ship.angle))
	else:
		$Ship.shipVelocity = Vector2(0.0, 0.0)

	$Ship.rotation = $Ship.angle
	$Ship.translate($Ship.shipVelocity * delta * 30)

	if (rng.randi_range(0, 300) > 298):
		if $Ship.shipVelocity.length() > 0:
			spawn_object()

	calc_current_zoom()

func spawn_object():
	print('Spawning object')
	var randAngle = $Ship.angle + rng.randf_range(-0.3, 0.3)
	var spawn_point = $Ship.position + 100 * $Ship.shipVelocity + 800 \
			* Vector2(sin(randAngle), -cos(randAngle))

	var upperRange = 1000 + accTime * 5
	if upperRange > 2000:
		upperRange = 2000

	var spawnVal = rng.randi_range(0, upperRange)

	var component
	if spawnVal <= 1000:
		var index = spawnVal % stuffBag.size()
		if stuffBag[index] == "fuel":
			component = CollResource.instance()
			component.init("fuel", spawn_point)
		else:
			component = CollComponent.instance()
			component.init(stuffBag[index], spawn_point)
		stuffBag.remove(index)
	elif spawnVal > 1000:
		component = Mine.instance()
		component.init(spawn_point, accTime)


	self.add_child(component)

