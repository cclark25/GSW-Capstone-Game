extends KinematicBody2D

var lifePoints = 15;
var vectorToPlayer = Vector2(0,0);
var attackCounter = 0;
var avoidCounter = -1;
export (bool) var damaged = false;

func _ready():
	position = Vector2(get_viewport().size.x/2, get_viewport().size.y/2)
	set_collision_layer_bit(Global.CollisionType.enemy, true);
	set_collision_mask_bit(Global.CollisionType.player, true);
	set_collision_mask_bit(Global.CollisionType.weapon, true);
	
	pass

func _process(delta):
	
	attackCounter = attackCounter - delta;
	if position.distance_to(Global.Player.position) < 200:
		if position.distance_to(Global.Player.position) < 70:
			vectorToPlayer = Vector2((position.y - Global.Player.position.y),(position.x - Global.Player.position.x)).normalized();
		else:
			vectorToPlayer = Vector2(position.x - Global.Player.position.x, position.y - Global.Player.position.y).normalized();
	else:
		vectorToPlayer = Vector2(0,0);
		
	if position.distance_to(Global.Player.position) < 70  && attackCounter < 5 * delta:
		JumpAttack(delta);
	
	
	translate(-delta * vectorToPlayer * 100)
	
	
	if avoidCounter != -1:
		avoidCounter = avoidCounter + delta
	
	if avoidCounter > 10 * delta:
		AvoidAttack(delta);

func _input(event):
	
	if(event.is_action_pressed("Left Click") && position.distance_to(Global.Player.position) < 70):
		avoidCounter = 0;

func Damage(amount, sourceLocation):
	if(!damaged):
		damaged = true;
		lifePoints -= amount;
		if(lifePoints <= 0):
			self_modulate.b = 4;
		position += (position - sourceLocation ).normalized() * 75;
	pass
	
	return;
	
func JumpAttack(delta):
	attackCounter = 500 * delta;
	vectorToPlayer = Vector2(position.x - Global.Player.position.x, position.y - Global.Player.position.y).normalized();
	translate(-50 * delta * vectorToPlayer)
	
func AvoidAttack(delta):
	avoidCounter = -1;
	vectorToPlayer = Vector2(position.x - Global.Player.position.x, position.y - Global.Player.position.y).normalized();
	translate(60 * delta * vectorToPlayer)
	