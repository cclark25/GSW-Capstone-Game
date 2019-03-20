extends "res://Dryad.gd"

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var inSlash = false;

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	
	if (position - get_parent().get_child(0).position).length() <= 150 || inSlash:
		slash(delta);
		
	pass

func slash(delta):
	if !inSlash:
		inSlash = true;
		animationTime = 0;
		get_child(1).show();
	var baseDir = animOffset * PI/2 - PI/4;
	get_child(1).rotation = baseDir;
	if(cos(baseDir) < 0 && int(cos(baseDir)) != 0):
		get_child(1).rotation *= -1;
	
	
	if(cos(baseDir) < 0 && int(cos(baseDir)) != 0):
		get_child(1).rotation -= (PI/2)*animationTime / .25;
	else:
		get_child(1).rotation += (PI/2)*animationTime / .25;
		
	if animationTime / .25 >= 1:
		inSlash = false;
		get_child(1).hide();
		return;