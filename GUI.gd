extends MarginContainer

var ship

# Called when the node enters the scene tree for the first time.
func _ready():
	ship = get_parent().get_parent().get_child(0);
	$VBoxContainer/Button.connect("button_down", self, "handle_warp_button")

func handle_warp_button():
	print("YOU WARPED")
	get_parent().get_parent().show_highscores();

func _process(delta):
	$VBoxContainer/HBoxContainer/FuelCapacity/Fuel.value = ship.fuel
	$VBoxContainer/HBoxContainer/FuelCapacity.value = ship.fuelMax
	$VBoxContainer/Button.disabled = (ship.fuel < 185)
