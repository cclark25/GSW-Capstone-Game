extends Node

signal spawn_node(node);

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var Player = preload("res://Scenes/Entities/Player/Player.tscn").instance();
var current_scene = null;
var SceneList = [];
var SceneNames = [];

var spawn_pending = [];
var spawned = [];

enum Directions { Right, DownRight, Down, DownLeft, Left, UpLeft, Up, UpRight }
enum CollisionType {player, enemy, weapon};

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	SpawnNode(Player);
	pass;

func AddScene(scene, id):
	if(SceneNames.has(id)):
		printerr("Scene " + id + "already exists in tree.");
	else:
		SceneNames.push_back(id);
		SceneList.push_back(scene);
	pass;

func GetScene(id):
	var index = SceneNames.find(id);
	if(index >= 0):
		return SceneList[index];

func SpawnNode(node):
	spawn_pending.push_back(node);
	if(current_scene != null):
		SpawnAll();
	pass;

func SpawnAll():
	if(current_scene == null):
		printerr("Error: no scene loaded. Cannot spawn entities.");
		return;
	for e in spawn_pending:
		#printerr("Spawning " + e.name + " to " + current_scene.name);
		if(e.get_parent() != null):
			e.get_parent().remove_child(e);
		current_scene.add_child(e);
		e.owner = current_scene;
		spawned.push_back(e);
	spawn_pending.clear();
	pass;

func get_current_scene():
	return current_scene;

func set_current_scene(scene):
	assert(typeof(scene) == TYPE_STRING);
	
	var sceneIndex = SceneNames.find(scene);
	assert(sceneIndex >= 0);
	
	for e in spawned:
		spawn_pending.append(e);
	spawned.clear();
	
	get_tree().set_current_scene(GetScene(scene));
	current_scene = get_tree().get_current_scene();
	
	SpawnAll();

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
