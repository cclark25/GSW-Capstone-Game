extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var time = 0.0;
var attackTimer = 0.0;
export (float) var closedTime = 5.0;
export (float) var openTime = 2.0;
export (float) var attackWait = 10.0;
export (float) var attackDuration = 10.0;
var opened = false;
var attack = false;
var attackDir = 0;
export (float) var HitPoints = 30;

func GetColorableChildren():
	return [get_node("Eye"), get_node("Vines"), get_node("AttackVine")];

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	get_node("Vines").play("Idle");
	set_collision_layer_bit(Global.CollisionType.enemy, true);
	randomize();
	pass

func TakeDamage(amount, source):
	HitPoints -= amount;
	return;

func EndAttack():
	attack = false;

func Attack():
	var atVine = get_node("AttackVine");
	var extendDur = 0.50;
	var extendDist;
	if(round(sin(atVine.rotation)*10000)/10000 != 0):
		extendDist = (5.0/3.0) / abs(sin(atVine.rotation));
	else:
		extendDist = 10.0 / 3.0;
	var shake = Vector2(randf() * 1.0, randf() * 1.0);
	
	if(atVine.animation == "Extend" && atVine.scale.x < extendDist): 
		if(atVine.frame == 1):
			atVine.scale.x = max(extendDist * min(time / extendDur, 1), 1.0);
			shake *= min(time, 1.0);
	if(time >= attackDuration - extendDur):
		atVine.scale.x = max(extendDist * min((attackDuration - time) / extendDur, 1), 1.0);
		shake *= max(attackDuration - time, 0.0);
		atVine.play("Retract");
	
	if(time > extendDur && time < attackDuration - extendDur && get_node("Squares").get_child_count() >= attackDir + 1 && get_node("Squares").get_child(attackDir).has_method("BeginAttack") && !get_node("Squares").get_child(attackDir).attackLock):
		get_node("Squares").get_child(attackDir).BeginAttack(attackDuration - 2*extendDur);
		get_node("Squares").get_child(attackDir).attackLock = true;
	
	get_node("Eye").position = shake;
	get_node("Vines").position = shake;
	
	
	if(time >= attackDuration):
		time = 0.0;
		attackTimer = 0.0;
		attack = false;
		get_node("Squares").get_child(attackDir).attackLock = false;
		get_node("Vines").play("Idle");
		get_node("Eye").position = Vector2(0,0);
		get_node("Vines").position = Vector2(0,0);
		atVine.visible = false;
		atVine.scale.x = 1;
	return;

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	time += delta;
	attackTimer += delta;
	
	if((get_node("Eye").animation == "Open" && get_node("Eye").frame != 0) || (get_node("Eye").animation == "Close" && get_node("Eye").frame != 2)):
		get_node("WeakPoint").disabled = false;
	else:
		get_node("WeakPoint").disabled = true;
	
	if(!attack && attackTimer >= attackWait):
		attack = true;
		#attackDir = randi()%8;
		#attackDir += 1;
		#attackDir %= 8;
		attackDir = round((Global.Player.global_position - global_position).angle() / (PI/4));
		if(attackDir < 0): attackDir += 8;
		var angle = Vector2(1, 0).rotated((attackDir / 8.0) * 2*PI);
		
		angle.x *= 16;
		angle.y *= 9;
		angle = angle.normalized();
		if(attackDir == 4):
			angle = Vector2(-1, 0);
		
		time = 0.0;
		get_node("Eye").play("Close");
		get_node("AttackVine").position = Vector2(10, 0).rotated(angle.angle());
		get_node("AttackVine").play("Extend");
		get_node("AttackVine").rotation = angle.angle();
		get_node("AttackVine").visible = true;
		get_node("Vines").play("Extend." + Global.Directions.keys()[attackDir]);
	if(attack):
		Attack();
		return;
	
	if(opened && time >= openTime):
		opened = false;
		time = 0.0;
		get_node("Eye").play("Close");
	if(!opened && time >= closedTime):
		opened = true;
		time = 0.0;
		get_node("Eye").play("Open");
	
	pass
