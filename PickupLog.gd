extends VBoxContainer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


class TimedMessage:
	var timeLeft
	var node
	var color

var messages

# Called when the node enters the scene tree for the first time.
func _ready():
	messages = []


func addTimedMessage(text, color):
	var tm = TimedMessage.new()
	tm.timeLeft = 4
	var label = Label.new()
	label.text = text
	label.align = Label.ALIGN_RIGHT
	label.add_color_override("font_color", color)
	self.add_child(label)
	tm.node = label
	tm.color = color
	messages.push_front(tm)

func found_component(component):
	addTimedMessage("found " + component.componentName, Color(0,255,0))
	
func found_fuel():
	addTimedMessage("found fuel", Color(0,255,255))

func found_mine():
	addTimedMessage("you blew it", Color(255,0,0))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for message in messages:
		message.timeLeft -= delta
		if message.timeLeft <= 0:
			self.remove_child(message.node)
			messages.erase(message)
		else:
			var newColor = Color(message.color.r, message.color.g, message.color.b, message.timeLeft/4)
			message.node.add_color_override("font_color",  newColor)