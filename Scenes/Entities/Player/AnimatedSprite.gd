extends AnimatedSprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var time = 0;
var inRoll = false;
var dir = 0;
var parent ; # = get_parent();

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
	parent = get_parent();
	set_process(true);
	dir = (parent.direction.angle()) / (PI/4);
	if(dir < 0): dir = 9 + dir;

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	
	match CurrentMode:
		Walk:
			if(parent.direction.length() != 0):
				Play(dir, CurrentMode);
			else:
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