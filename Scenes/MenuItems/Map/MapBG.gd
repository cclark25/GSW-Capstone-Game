extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var square = load("Scenes/MenuItems/Map/Square/Square.tscn");
var width = 8;
var height = 5;
var list = [];
var activeRoom;
var time = 0.0;
var numRows = 0;
var numCol = 0;

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	for scene in Global.SceneNames:
		if(scene.length() == 2):
			var r = square.instance();
			r.name = scene;
			list.push_back(r);
			add_child(r);
			var x = scene[1];
			var y = scene[0];
			x = x.to_int() - 1;
			y = y.to_ascii()[0] - 65;
			numCol = max(numCol, x + 1);
			numRows = max(numRows, y + 1);
			r.position.x = width * x;
			r.position.y = height * y;
			r.modulate = Color(0,0,0);
			pass;
	get_node("Outline").scale.x = (numCol * width) / (5.0 * width) + 0.2;
	get_node("Outline").scale.y = (numRows * height) / (8.0 * height) + 0.2;
	Show();
	pass

#func _input(event):
#	if(event.is_action_pressed("DEBUG") ):
#		Show();

func Show():
	visible = true;
	set_process(true);
	time = 0.0;
	var id = Global.GetCurrentSceneId();
	var entry = null;
	
	for s in list:
		if(s.name == id):
			entry = s;
			break;
	
	if(activeRoom != null):
		activeRoom.modulate = Color(0,0,0);
	activeRoom = entry;

func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
	time += delta;
	if(activeRoom != null): 
		activeRoom.modulate.b = sin(PI*(time - int(time)));
	pass
