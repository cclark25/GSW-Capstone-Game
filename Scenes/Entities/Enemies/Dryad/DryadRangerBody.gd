extends KinematicBody2D

var lifePoints = 30;
var vectorToPlayer = Vector2(0,0);
var activeItem;
var shootTimer = 1;
var isAggro = false;
var invincible = false;

func _ready():
	activeItem = preload("../../Items/Bow/Bow.tscn").instance();
	add_child(activeItem);
	set_collision_layer_bit(Global.CollisionType.enemy, true);
	set_collision_mask_bit(Global.CollisionType.enemy, true);
	set_collision_mask_bit(Global.CollisionType.weapon, true);
	set_collision_mask_bit(Global.CollisionType.player, true);
	pass

func _process(delta):
	var animator = get_node("AnimatedDryadSprite")
	shootTimer = shootTimer - delta;
	vectorToPlayer = Vector2((position.x - Global.Player.position.x),(position.y - Global.Player.position.y)).normalized();
	if position.distance_to(Global.Player.position) < 200:
		move_and_collide(vectorToPlayer * delta * 75);
		isAggro = true;
	elif position.distance_to(Global.Player.position) < 210:
		move_and_collide(vectorToPlayer * 0);
		isAggro = true;
		animator.stop();
	elif position.distance_to(Global.Player.position) < 300:
		move_and_collide(-vectorToPlayer * delta * 75);
		isAggro = true;
	else:
		isAggro = false;
		
	
	if shootTimer <= 0 && isAggro:
		activeItem.Use();
		shootTimer = randi()%100 * delta;
	
	pass


func GetHitPoints():
	return lifePoints;

func GetColorableChildren():
	return [get_node("AnimatedDryadSprite")];
	
func TakeDamage(amount, source):
	lifePoints -= amount;
	printerr("Dryad HP:", lifePoints);
	pass;
	
func SetInvincible(invince):
	invincible = invince;
	
func IsInvincible():
	return invincible;

func get_direction():
	return position.angle_to_point(Global.Player.position);