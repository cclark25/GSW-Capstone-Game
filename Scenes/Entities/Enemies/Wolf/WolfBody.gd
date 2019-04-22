extends KinematicBody2D

var lifePoints = 30;
var vectorToPlayer = Vector2(0,0);
var attackCounter = 0;
var attackFrames = 0;
var inAttack = false;
var avoidCounter = 0;
var inRetreatMode = false;
var inAggroMode = false;
var randCirDir = 1;
var randDirCounter = 0;
export (bool) var damaged = false;

func _ready():
	set_collision_layer_bit(Global.CollisionType.enemy, true);
	set_collision_mask_bit(Global.CollisionType.weapon, true);
	set_collision_mask_bit(Global.CollisionType.player, true);
	pass

func _process(delta):
	
	vectorToPlayer = Vector2((position.x - Global.Player.position.x),(position.y - Global.Player.position.y)).normalized();
	
	if randDirCounter <= 0:
		randCirDir = 2*randi()%2 - 1
		printerr(randCirDir)
		randDirCounter = 500 * delta;
	
	randDirCounter = randDirCounter - delta;
	
	
	if inAggroMode:
		attackCounter = attackCounter - delta;
		
		if position.distance_to(Global.Player.position) < 70:
			move_and_collide(-delta * Vector2(randCirDir * -vectorToPlayer.y, randCirDir * vectorToPlayer.x) * 50)
		else:
			move_and_collide(-delta * vectorToPlayer * 100)
			
		if position.distance_to(Global.Player.position) < 100  && attackCounter < 5 * delta || inAttack:
			JumpAttack(delta);
		
		if inRetreatMode:
			AvoidAttack(delta);
		
		if position.distance_to(Global.Player.position) > 200:
			inAggroMode = false;
			
	else:
		if position.distance_to(Global.Player.position) < 200:
			inAggroMode = true;

func _input(event):
	
	if(event.is_action_pressed("Left Click") && Global.Player.activeItem != null && inAggroMode):
		inRetreatMode = true;
	
func JumpAttack(delta):
		inAttack = true;
		if attackFrames > 0:
			move_and_collide(-position.distance_to(Global.Player.position) * 10 * delta * vectorToPlayer);
			attackFrames = attackFrames - delta;
		else:
			attackFrames = 10 * delta;
			attackCounter = 500 * delta;
			inAttack = false;
			return;
	
func AvoidAttack(delta):
	if avoidCounter < 20 * delta:
		move_and_collide(delta * vectorToPlayer * 150)
		avoidCounter = avoidCounter + delta;
		attackCounter = attackCounter - delta;
	else:
		avoidCounter = 0;
		inRetreatMode = false;
		
func TakeDamage(amount, source):
	damaged = true;
	lifePoints -= amount;
	if lifePoints <= 0:
		get_parent().remove_child(self);
	printerr("Wolf HP:", lifePoints);
	pass;
	