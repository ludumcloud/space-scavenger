extends MarginContainer

var metalCapacityBar
var metalBar
var fuelBar
var ship


# Called when the node enters the scene tree for the first time.
func _ready():
	ship = get_parent().get_parent().get_child(0);

func _process(delta):
	$VBoxContainer/HBoxContainer/FuelCapacity/Fuel.value = ship.fuel
	$VBoxContainer/HBoxContainer/FuelCapacity.value = ship.fuelMax
	$VBoxContainer/Button.disabled = (ship.fuel < 200)