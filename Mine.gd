extends Node2D

var elapsedTime = 0
var isActive = false
var isTracking = false
var rotation_speed: float

func init(position: Vector2, currGameTime):
	self.global_position = position
	elapsedTime = currGameTime
	setActive(isActive)
	rotation_speed = rand_range(-1, 1)

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.connect("animation_finished", self, 'on_animation_finished')

func setActive(newActive):
	isActive = newActive
	if (isActive):
		$AnimatedSprite.frame = 1
	else:
		$AnimatedSprite.frame = 0

func setTracking():
	$AnimatedSprite.play("default")
	isTracking = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	elapsedTime += delta
	if (elapsedTime >= 10 && !isActive):
		setActive(true)
	if elapsedTime >= 30 && !isTracking:
		setTracking()

	if isTracking:
		var updateVec = get_parent().get_child(0).position - self.global_position
		updateVec = updateVec.normalized() * delta * 200
		self.translate(updateVec)
		self.rotate(rotation_speed * delta)

	var ship = get_parent().get_child(0)
	var distance = (ship.global_position - self.global_position).length()
	if (isActive):
		if distance < 100:
			
			#get_parent().get_child(2).get_child(2).found_mine()
			ship.reinit()
			if $AnimatedSprite.animation != "explode":
				# Go into the exploding playback for audio/anim
				$AudioStreamPlayer2D.play(0.0)
				$AnimatedSprite.play("explode")

	#distance based cleanup
	if (distance > 4000):
		get_parent().remove_child(self)

func on_animation_finished():
	if $AnimatedSprite.animation == "explode":
		get_parent().remove_child(self)
