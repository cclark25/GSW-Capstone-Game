extends WorldEnvironment

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var Context = null;
export (String) var startRoom = null;
var currentScene = null;
var neighborScenes = [];
var neighborNames = [];

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	Context = SceneLoader.MakeContext();
	
	for room in get_children():
		if(room is InstancePlaceholder):
			Context.StorePack(load(room.get_instance_path()), room.name);
	
	SetScene(startRoom);

	pass

func SetScene(id):
	var previous ;
	if(currentScene != null):
		previous = currentScene.get_name().split('@', false)[0];
		if(id == previous):
			return;
	
	var neighbor = neighborNames.find(id);
	if(neighbor >= 0):
		if(currentScene != null):
			var tmp = currentScene;
			currentScene = neighborScenes[neighbor];
			neighborScenes[neighbor] = tmp;
			neighborNames[neighbor] = tmp.name;
		else:
			currentScene = neighborScenes[neighbor];
			neighborScenes.remove(neighbor);
			neighborNames.remove(neighbor);
	else:
		if(currentScene != null):
			neighborScenes.push_back(currentScene);
			neighborNames.push_back(currentScene.get_name().split('@', false)[0]);
		currentScene = Context.FetchScene(id).instance();
		add_child(currentScene);
	currentScene.set_name(id);
	
	var doors = [];
	for door in Global.GetAllDoors(currentScene):
		doors.push_back(door.exitScene);
	for i in range(0, neighborNames.size()):
		var index = doors.find(neighborNames[i]);
		if(index < 0):
			Context.StoreScene(neighborScenes[i], neighborNames[i]);
			neighborNames.remove(i);
			neighborScenes.remove(i);
	for i in range(0, doors.size()):
		if(doors[i] == previous): continue;
		var index = neighborNames.find(doors[i]);
		if(index < 0):
			neighborScenes.push_back(Context.FetchScene(doors[i]).instance());
			neighborNames.push_back(doors[i]);
			add_child(neighborScenes.back());
	

func SetOwners(root):
	for e in root.get_children():
		printerr("Setting the owner of " + e.name + " to " + e.get_parent().name);
		e.set_owner(e.get_parent());
		SetOwners(e);
	return;

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	
	pass
