extends MarginContainer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var metalCapacityBar
var metalBar
var fuelBar
var ship


# Called when the node enters the scene tree for the first time.
func _ready():
	metalCapacityBar = get_child(0).get_child(0).get_child(0);
	metalBar = get_child(0).get_child(0).get_child(0).get_child(0);
	fuelBar =  get_child(0).get_child(1).get_child(0);
	ship = get_parent().get_parent().get_child(0);
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _process(delta):
	fuelBar.value = ship.fuel;