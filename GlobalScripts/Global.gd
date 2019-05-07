extends Node2D

var Player = load("res://Scenes/Entities/Player/Player.tscn").instance();
var currentSet = null;

enum Directions { Right, DownRight, Down, DownLeft, Left, UpLeft, Up, UpRight }
enum CollisionType {player, enemy, weapon, hookable, dragable, hazard, wall, hole};

func SetSceneSet(set):
	currentSet = load(set).instance();
	if(Player.get_parent() != null):
		Player.get_parent().remove_child(Player);
	add_child(Player);
	add_child(currentSet);
	return;

func SpawnNode(node):
	add_child(node);

func GetAllDoors(root):
	var list = [];
	for e in root.get_children():
		if(e.has_method("get_door_id")):
			if(e.exitScene != null): list.push_back(e);
		else:
			list += GetAllDoors(e);
	return list;