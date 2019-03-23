extends AnimatedSprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var time = 0;
var inRoll = false;
var dir = 0;

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	set_process(false);
	connect("animation_finished", self, "FinishAnimation");
	pass


enum Modes { Walk, Roll }

var CurrentMode = Modes.Walk;

func Play(dir, mode):
	play(Modes.keys()[mode] + "." + Global.Directions.keys()[dir]);
	

func Update():
	set_process(true);
	if(get_parent().direction.length() == 0 && !get_parent().targetCursor.visible):
		return;
	if(get_parent().targetCursor.visible):
		dir = int(get_parent().get_angle_to(get_viewport().get_mouse_position()) / (PI/4));
	else:
		dir = int((get_parent().direction.angle()) / (PI/4));
	if(dir < 0): dir = 8 + dir;

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	if(get_parent().targetCursor.visible):
		dir = int(get_parent().get_angle_to(get_viewport().get_mouse_position()) / (PI/8));
		if(dir % 2 == 1):
			dir = int(dir / 2) + 1;
		else:
			dir = int(dir / 2);
	
	match CurrentMode:
		Walk:
			Play(dir, CurrentMode);
			if(get_parent().direction.length() == 0):
				stop();
				frame = 0;
				set_process(false);
		Roll:
			if(!inRoll):
				inRoll = true;
				Play(dir, Roll);
			
			if(!is_playing()):
				inRoll = false;
				CurrentMode = Walk;
	pass

func FinishAnimation():
	match CurrentMode:
		Roll:
			inRoll = false;
			CurrentMode = Walk;
	pass;