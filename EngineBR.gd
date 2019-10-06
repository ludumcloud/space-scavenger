extends Component

func _ready():
	joints.append(Component.make_joint(['wing-right'], get_node('./WingRJoint')))
	joints.append(Component.make_joint(['engine-right', 'hull-right'], get_node('./EngineRJoint')))
