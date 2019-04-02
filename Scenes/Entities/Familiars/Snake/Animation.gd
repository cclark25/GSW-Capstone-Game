extends AnimatedSprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var lastDir; 

enum Modes { Walk, Extend, Retract }

func Play(dir, mode):
	var thisAnimation = Modes.keys()[mode] + "." + Global.Directions.keys()[dir];
	lastDir = dir;
	play(thisAnimation);

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	connect("animation_finished", self, "ExtendStopped");
	set_process(false);
	pass

func ExtendStopped():
	var type = animation.split(".", false)[0];
	
	if(type == "Extend" && lastDir != null ): #&& get_parent().has_method("SetupNextAnimation")):
		Play(lastDir, Modes.Retract);
		return;
	
	if(type == "Retract" && lastDir != null ): #&& get_parent().has_method("SetupNextAnimation")):
		get_parent().visible = false;
		return;
	
	return;

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	pass
