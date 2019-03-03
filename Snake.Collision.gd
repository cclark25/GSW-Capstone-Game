extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	connect("area_entered", self, "Hook");
	#connect("area_exited", self, "UnHook");
	pass

func Hook(body):
	if(body.has_method("Is_Hookable")):
		get_parent().Hook();
	pass;
	
func UnHook(body):
	get_parent().UnHook();
	pass;

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
