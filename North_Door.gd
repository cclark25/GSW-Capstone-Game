extends StaticBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export (bool) var is_locked = true;
var animationTime = 0;


func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	#connect("body_entered", self, "unlock")
	set_process(false);
	pass
	
func unlock():
	is_locked = false;
	set_process(true);
	animationTime = 0;
	pass;

func lock():
	is_locked = true;
	set_process(true);
	animationTime = 0;
	pass

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	
	animationTime += delta;
	if(is_locked):
		get_child(0).frame = 3 - int(animationTime / .07);
		if(get_child(0).frame <= 0):
			get_child(0).frame = 0;
			set_process(false);
			get_child(1).disabled = false;
	else:
		get_child(0).frame = int(animationTime / .07);
		if(get_child(0).frame >= 3):
			get_child(0).frame = 3;
			set_process(false);
			get_child(1).disabled = true;
		
	pass
