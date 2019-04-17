extends KinematicBody2D

var lifePoints = 15;
var vectorToPlayer = Vector2(0,0);
var attackCounter = 0;
var attackFrames = 0;
var avoidCounter = -1;
var inAttack = false;
export (bool) var damaged = false;

func _ready():
	position = Vector2(get_viewport().size.x/2, get_viewport().size.y/2)
	set_collision_layer_bit(Global.CollisionType.enemy, true);
	set_collision_mask_bit(Global.CollisionType.weapon, true);
	set_collision_mask_bit(Global.CollisionType.player, true);
	connect("body_entered", self, "DealDamage");
	connect("area_entered", self, "DealDamage");
	
	pass

func _process(delta):
	
	
	vectorToPlayer = Vector2((position.x - Global.Player.position.x),(position.y - Global.Player.position.y)).normalized();
	attackCounter = attackCounter - delta;
	
	if position.distance_to(Global.Player.position) < 200:
		if position.distance_to(Global.Player.position) < 70:
			move_and_collide(-delta * Vector2(-vectorToPlayer.y, vectorToPlayer.x) * 50)
		else:
			move_and_collide(-delta * vectorToPlayer * 100)
	else:
		translate(Vector2(0,0));
		
	if position.distance_to(Global.Player.position) < 100  && attackCounter < 5 * delta || inAttack:
		JumpAttack(delta);
	
	if avoidCounter != -1:
		avoidCounter = avoidCounter + delta
	
	if avoidCounter > 10 * delta:
		AvoidAttack(delta);

func _input(event):
	
	if(event.is_action_pressed("Left Click") && position.distance_to(Global.Player.position) < 70):
		avoidCounter = 0;


func DealDamage(body):
	printerr("damages")
	Damage.DealDamage(10, body, Damage.DamageType.bite, self);
	pass;
	
	return;
	
func JumpAttack(delta):
		inAttack = true;
		if attackFrames > 0:
			printerr("attack");
			move_and_collide(-position.distance_to(Global.Player.position) * 10 * delta * vectorToPlayer);
			attackFrames = attackFrames - delta;
		else:
			attackFrames = 10 * delta;
			attackCounter = 500 * delta;
			inAttack = false;
			return;
	
func AvoidAttack(delta):
	avoidCounter = -1;
	translate(6000 * delta * vectorToPlayer)
	