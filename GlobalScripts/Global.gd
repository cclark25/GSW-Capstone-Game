extends Node2D;

var Context = null;
var currentScene = null;
var currentSceneId = null;
var neighbors = [];
var neighNames = [];
var Player = load("res://Scenes/Entities/Player/Player.tscn").instance();

enum Directions { Right, DownRight, Down, DownLeft, Left, UpLeft, Up, UpRight }
enum CollisionType {player, enemy, weapon, hookable, dragable, hazard, wall, hole};

func _ready():
	EnterMainMenu();
	#add_child(load("res://Scenes/Menu/HUD.tscn").instance());
	return;

func GetDoor(name, root=currentScene):
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

func GetAllDoors(root=currentScene):
	var doors = [];
	for child in root.get_children():
		if(child.has_method("get_door_id")):
			doors.push_back(child.exitScene);
			continue;
		else:
			doors += GetAllDoors(child);
	return doors;

func SetSceneContext(file):
	if(currentScene != null): currentScene.queue_free();
	Context = SceneLoader.MakeContext();
	var sceneFile = File.new();
	sceneFile.open(file, File.READ);
	var fileText = sceneFile.get_as_text();
	sceneFile.close();
	var a1 = fileText.split("\n", false);

	for e in a1:
		var sp = e.split(":");
		var loc = "res://" + sp[0];
		var pScene = load(loc);
		Context.StoreScene(pScene, sp[1]);
	SetScene("H3");

func SetScene(id, loadPosition=null):
	var scene = Context.FetchScene(id);
	if(scene == null):
		printerr("There is no scene in the scene set called \"" + id + "\"");
		return;
	var neighborList = GetAllDoors(scene);
	for n in neighNames:
		var index = neighNames.find(n);
		if(neighborList.find(n) < 0):
			Context.StoreScene(neighbors[index], n);
			neighbors.remove(index);
			neighNames.remove(index);
	for n in neighborList:
		if(neighNames.find(n) < 0):
			var s = Context.FetchScene(n);
			neighbors.push_back(s);
			neighNames.push_back(n);
			add_child(s);
	
	Context.StoreScene(currentScene, currentSceneId);
	if(currentScene != null): 
		currentScene.queue_free();
	currentScene = scene;
	currentSceneId = id;
	add_child(scene);
	if(!has_node("PlayerBody")):
		add_child(Player);
	if(loadPosition != null):
		currentScene.global_position = loadPosition;

func SpawnNode(entity):
	add_child(entity);

func EnterMainMenu():
	if(currentScene != null): remove_child(currentScene);
	currentScene = load("res://StartMenu.tscn").instance();
	add_child(currentScene);
	return;

func GetCurrentSceneId():
	return currentSceneId;

func GetSceneNames():
	return Context.PackedNames;