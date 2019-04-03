extends AnimatedSprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var lastDir; 

enum Modes { Walk, Extend, Retract }

func Play(mode):
	var thisAnimation = Modes.keys()[mode];
	play(thisAnimation);

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	connect("animation_finished", self, "ExtendStopped");
	connect("frame_changed", get_parent(), "frameChange");
	set_process(false);
	pass

func ExtendStopped():
	
	if(animation == "Extend" ):#&& lastDir != null ): #&& get_parent().has_method("SetupNextAnimation")):
		Play(Modes.Retract);
		return;
	
	if(animation == "Retract" ):#&& lastDir != null ): #&& get_parent().has_method("SetupNextAnimation")):
		get_parent().EndMove();
		return;
	
	return;
