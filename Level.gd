extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var CollComponent = preload("res://CollComponent.tscn")
var CollResource = preload("res://CollResource.tscn")
var rng = RandomNumberGenerator.new()

var levelOneComponents = [
	"wing-left",
	"wing-right",
	"hull",
	"engine-a-l",
	"engine-a-r",
	"engine-b-l",
	"engine-b-r",
]

func generate_collectible_component(set):
	var compType = set[rng.randi_range(0, set.size()-1)]
	var component = CollComponent.instance()
	var initialPos = Vector2(rng.randi_range(0, 500), rng.randi_range(0, 500))
	component.init(compType, initialPos)
	self.add_child(component)

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	var testComp = CollComponent.instance()
	testComp.init("hull", Vector2(500, 300))

	var testComp2 = CollComponent.instance()
	testComp2.init("wing-left", Vector2(300, 500))
	
	var testComp3 = CollComponent.instance()
	testComp3.init("engine-left", Vector2(350, 500))
	
	self.add_child(testComp)
	self.add_child(testComp2)
	self.add_child(testComp3)

	generate_collectible_component(levelOneComponents);
	generate_collectible_component(levelOneComponents);
	
	var testResc = CollResource.instance()
	testResc.init("fuel", Vector2(150, 100))
	self.add_child(testResc)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ui_left"):
		$Ship.rotate(-PI * delta * $Ship.angularVelocity);
	if Input.is_action_pressed("ui_right"):
		$Ship.rotate(PI * delta * $Ship.angularVelocity);
	if Input.is_action_pressed("ui_up"):
		$Ship.translate(Vector2(sin($Ship.rotation), -cos($Ship.rotation)) * 90.0 * delta);

	var zoomFactor = ($Ship.hullNum * 0.2) + 1;
	$ParallaxBackground.set_scale(Vector2(zoomFactor, zoomFactor));
	$Ship/Camera2D.set_zoom(Vector2(zoomFactor, zoomFactor));

