extends Node;

enum DamageType {slash, bludgeon, burn, freeze, shock, psychic, bite};

class DHandler extends Node2D:
	var origin = null;
	var destination = null;
	var body = null;
	var time = 0.0;
	var maxTime = 0.1;
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
		
		if(body is KinematicBody2D):
			body.move_and_collide((destination - origin) * delta / maxTime);
		else:
			body.global_position = origin + (destination - origin)*(time/maxTime);
		
		var mod = abs(sin((time / maxTime) * PI * 4));
		for i in range(0, modChildren.size()):
			modChildren[i].self_modulate.r = normalColors[i].r + mod;
		
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