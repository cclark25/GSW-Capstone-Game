extends Area2D

var speed = 500;
var dir = 0;
var stop = false;
var arrow_life_counter = 0;

func _ready():
	set_collision_mask_bit(Global.CollisionType.player, true);
	set_collision_mask_bit(Global.CollisionType.wall, true)
	connect("area_entered", self, "HitTarget");
	connect("body_entered", self, "HitTarget");
	pass

func _process(delta):
	var arrow_life_span = 100 * delta;
	arrow_life_counter = arrow_life_counter + delta;
	if arrow_life_counter >= arrow_life_span:
		get_parent().remove_child(self);
	if !stop:
		translate(Vector2( -cos(dir) * speed * delta, -sin(dir) * speed * delta));
	
	pass

func _shoot(arr_dir):
	self.rotation = arr_dir + PI/2;
	dir = arr_dir;
	pass
	
func HitTarget(body):
	Damage.DealDamage(10, body, Damage.DamageType.pierce, self);
	get_node("CollisionShape2D").set_disabled(true);
	stop = true;
	pass;