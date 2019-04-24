extends Node

signal spawn_node(node);

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var Player = preload("res://Scenes/Entities/Player/Player.tscn").instance();
var current_scene = null;
var SceneList = [];
var PackedScenes = [];
var SceneNames = [];

var spawn_pending = [];
var spawned = [];

enum Directions { Right, DownRight, Down, DownLeft, Left, UpLeft, Up, UpRight }
enum CollisionType {player, enemy, weapon, hookable, dragable, hazard, wall};

func GetDoor(name, root=current_scene):
	var door = null;
	for child in root.get_children():
		if(child.has_method("get_door_id") && child.get_door_id() == name):
			door = child;
			return door;
		else:
			door = GetDoor(name, child);
			if(door != null):
				return door;
	return door;

func AddScene(scene, id):
	if(!SceneNames.has(id)):
		SceneNames.push_back(id);
		SceneList.push_back(scene);
	else:
		printerr("Error: Scene Exists already!");
	return;

func _input(event):
	if(event.is_action_pressed("DEBUG")):
		var index = SceneList.find(current_scene);
		if(index >= 0):
			SceneList[index] = PackedScenes[index].instance();
			set_current_scene(SceneNames[index]);
	return;

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	var sceneFile = File.new();
	sceneFile.open("res://Scenes/SceneList.cfg", File.READ);
	var fileText = sceneFile.get_as_text();
	sceneFile.close();
	var a1 = fileText.split("\n", false);
#
	for e in a1:
		var sp = e.split(":");
		var loc = "res://" + sp[0];
		var pScene = load(loc);
		PackedScenes.push_back(pScene);
		AddScene(pScene.instance(), sp[1]);

	if(current_scene == null):
		set_current_scene("start_menu");
	SpawnNode(Player);

	return;

func SpawnNode(entity):
	spawn_pending.push_back(entity);
	return;

func GetScene(id):
	return SceneList[SceneNames.find(id)];

func DespawnSpawned():
	for e in spawned:
		if(e.get_parent() != null):
			e.get_parent().remove_child(e);
		spawn_pending.push_back(e);
	spawned.clear();
	return;

func SpawnPending(doorEntered=null):
	for e in spawn_pending:
		if(e.get_parent() != null):
			e.get_parent().remove_child(e);
		current_scene.add_child(e);
		#if(current_scene.has_node(e.name + "SpawnPoint")):
		#	e.global_position = current_scene.get_node(e.name + "SpawnPoint").global_position;
				
		spawned.push_back(e);
	
	if(doorEntered != null && doorEntered.has_method("GetRespawnables")):
#		for o in current_scene.get_children():
#			if(o.has_method("get_door_id") && o.get_door_id() == doorEntered.exitTo):
#				var entities = doorEntered.GetRespawnables();
#				entities.push_back(Player);
#				for i in entities:
#					i.global_position = o.GetSpawnPoint();
#				if(o.has_method("_SceneReload")): o._SceneReload();
#				break;
		var dest = GetDoor(doorEntered.exitTo);
		var entities = doorEntered.GetRespawnables();
		entities.push_back(Player);
		for i in entities:
			i.global_position = dest.GetSpawnPoint();
			if(dest.has_method("_SceneReload")): 
				dest._SceneReload();
	spawn_pending.clear();
	return;

func ReloadScenes(scene):
	for child in scene.get_children():
		ReloadScenes(child);
		if(child.has_method("_SceneReload")): child._SceneReload();

func GetCurrentSceneId():
	var index = SceneList.find(current_scene);
	return SceneNames[index];

func set_current_scene(id, doorway=null):
	var newScene = GetScene(id);
	if(newScene == null):
		printerr("Error: newScene is null!");
		return;
	
	if(current_scene != null):
		remove_child(current_scene);
	add_child(newScene);
	current_scene = newScene;
	
	DespawnSpawned();
	SpawnPending(doorway);
	
	ReloadScenes(current_scene);
	
	print("Scene changed to \"" + id + "\".");
	return;

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
