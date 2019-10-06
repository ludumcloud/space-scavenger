extends Node2D

var elapsedTime = 0
var isActive = false
var isTracking = false

func init(position: Vector2, currGameTime):
	self.global_position = position
	elapsedTime = currGameTime
	setActive(isActive)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func setActive(newActive):
	isActive = newActive
	if (isActive):
		$AnimatedSprite.frame = 1
	else:
		$AnimatedSprite.frame = 0
		
func setTracking():
	print("Set tracking")
	$AnimatedSprite.playing = true
	isTracking = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	elapsedTime += delta
	if (elapsedTime >= 10):
		setActive(true)
	if elapsedTime >= 30:
		setTracking()
		
	if isTracking:
		var updateVec = get_parent().get_child(0).position - self.global_position
		updateVec = updateVec.normalized() * 3
		self.translate(updateVec)

	if (isActive):
		var ship = get_parent().get_child(0)
		if (ship.global_position - self.global_position).length() < 100:
			ship.reinit()
			get_parent().remove_child(self)
