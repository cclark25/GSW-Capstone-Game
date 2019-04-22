extends Node;

enum DamageType {slash, bludgeon, burn, freeze, shock, psychic, bite};

class DHandler extends Node2D:
	var origin = null;
	var destination = null;
	var body = null;
	var time = 0.0;
	var maxTime = 1.0;
	var normalColors = [];
	var modChildren = [];
	
	func _ready():
		set_process(false);
		
	func Handle(Origin, Destination, Body):
		if(time > 0.0 || Origin == null || Destination == null || Body == null):
			return;
		origin = Origin;
		destination = Destination;
		body = Body;
		if(body.has_method("SetInvincible")):
			body.SetInvincible(true);
		if(body.has_method("GetColorableChildren")):
			modChildren = body.GetColorableChildren();
			for c in modChildren:
				normalColors.push_back(c.modulate);
		else:
			modChildren.push_back(body);
			normalColors.push_back(body.modulate)
		set_process(true);
	
	func _process(delta):
		time += delta;
		
		if(body.has_method("GetHitPoints") && body.GetHitPoints() <= 0):
			for i in range(0, modChildren.size()):
				modChildren[i].self_modulate.a = normalColors[i].a * (1 - time/(maxTime/2));
			if(time >= maxTime/2):
				if(body == Global.Player):
					Global.set_current_scene();
				if(Global.current_scene.has_method("handleDeath")):
					Global.current_scene.handleDeath(body);
				body.queue_free();
				queue_free();
			
		
		if(time < maxTime/10):
		 if(body is KinematicBody2D):
		 	body.move_and_collide((destination - origin) * delta / (maxTime/10));
		 else:
		 	body.set_global_position(origin + (destination - origin)*(time/(maxTime/10))) ;
		
		var mod = abs(sin((time / maxTime) * PI * 4)) + 1;
		for i in range(0, modChildren.size()):
			modChildren[i].self_modulate.r = normalColors[i].r * mod;
		
		if(time >= maxTime):
			if(body.has_method("SetInvincible")):
				body.SetInvincible(false);
			for i in range(0, modChildren.size()):
				modChildren[i].self_modulate.r = normalColors[i].r;
			set_process(false);
			queue_free();

func DealDamage(amount, targetBody, type=DamageType.slash, sourceBody=null):
	if(!targetBody.has_method("TakeDamage")):
		return;
	if(targetBody.has_method("IsInvincible") && targetBody.IsInvincible()):
		return;
	
	if(type == DamageType.bite):
		DealBite(amount, targetBody, sourceBody);
	if(type == DamageType.slash):
		DealSlash(amount, targetBody, sourceBody);
	return;

func KickBack(targetBody, sourceBody, amount):
	var direction = (targetBody.global_position - sourceBody.global_position).normalized();
	var weight = 5.0;
	if(targetBody.has_method("GetWeight")):
		weight = targetBody.GetWeight();
	var kickback = amount / weight;
	
	#targetBody.global_position += direction * 100 * kickback;
	var handler = DHandler.new();
	add_child(handler);
	handler.Handle(targetBody.global_position, targetBody.global_position + direction * 100 * kickback, targetBody);
	
	return;

func DealBite(amount, targetBody, sourceBody):
	targetBody.TakeDamage(amount, sourceBody);
	if(sourceBody != null): 
		KickBack(targetBody, sourceBody, amount);
	return;
	
func DealSlash(amount, targetBody, sourceBody):
	targetBody.TakeDamage(amount, sourceBody);
	if(sourceBody != null): 
		KickBack(targetBody, sourceBody, amount);
	return;