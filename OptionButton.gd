extends OptionButton

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var count = 0;

func ListScenes(next="Scenes"):
	var nextDirs = [];
	var dir = Directory.new();
	dir.open(next);
	dir.list_dir_begin();
	
	while true:
		var file = dir.get_next()
		
		if file == "":
			break
		elif(file == "." || file == ".."):
			continue;
		elif(dir.dir_exists(file)):
			nextDirs.append(file);
		elif file.ends_with(".cfg"):
			#printerr("Adding scene: ");
			#printerr(file);
			add_item(next + "/" + file, count + 1);
			count += 1;

	dir.list_dir_end();
	#printerr(nextDirs);
	for newDir in nextDirs:
		if(newDir != ""):
			ListScenes(next + "/" + newDir);

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	clear();
	ListScenes();
	
	get_parent().get_node("Start").disabled = false;
	pass



#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
