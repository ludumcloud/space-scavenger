extends Component

# Called when the node enters the scene tree for the first time.
func _ready():
	joints.append(Component.make_joint(['hull'], get_node('./HullJoint')))


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
