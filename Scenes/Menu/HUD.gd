extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var extended = false;
var time = 0.0;
export (float) var extendTime = 0.25;
export (float) var displayTime = 3.0;

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	set_process(false);
	pass

func _input(event):
	if(event.is_action_pressed("ActivateHUD")):
		time = 0.0;
		extended = true;
		set_process(true);
	if(event.is_action_released("ActivateHUD")):
		extended = false;
	
	return;

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	time += delta;
	if(position.y < 0):
		position.y = -100.0 * (1 - min(time / extendTime, 1));
	
	if(time < displayTime + extendTime):
		return;
	
	if(position.y > -100 && !extended):
		position.y = -100.0 * min((time - displayTime - extendTime) / extendTime, 1);
	else:
		time -= delta;
	
	if(time >= displayTime + extendTime * 2 && !extended):
		set_process(false);
	
	pass
