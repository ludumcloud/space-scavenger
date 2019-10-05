extends Component

onready var hullJoint = get_node('./HullJoint')

# Called when the node enters the scene tree for the first time.
func _ready():
	print(hullJoint)
	joints.append(Component.make_joint('hull', hullJoint))


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
