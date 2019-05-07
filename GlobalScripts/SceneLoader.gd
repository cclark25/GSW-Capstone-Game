extends Node2D;

class SceneContext extends Node2D:
	var PackedScenes = [];
	var PackedNames = [];
	
	func StoreScene(scene, name):
		
		var p;
		var e;
		if(scene is PackedScene):
			p = scene;
			e = OK;
		else:
			p = PackedScene.new();
			e = p.pack(scene);
			scene.queue_free();
		if(e == OK):
			PackedScenes.push_back(p);
			PackedNames.push_back(name);
		return e;
	
	func FetchScene(name):
		var index = PackedNames.find(name);
		if(index < 0):
			return null;
		else:
			var scene = PackedScenes[index];
			PackedScenes.remove(index);
			PackedNames.remove(index);
			return scene;
	
	func StorePack(pack, name):
		PackedScenes.push_back(pack);
		PackedNames.push_back(name);
		return;

func MakeContext():
	return SceneContext.new();