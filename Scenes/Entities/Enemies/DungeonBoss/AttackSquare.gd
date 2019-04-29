extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var runTime = 0.0;
var time = 0.0;
var delay = 0.5;
var entangledBodies = [];
var entangledPositions = [];
var branch = null;
var attackLock = false;

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	set_process(false);
	visible = false;
	get_node("Collision").disabled = true;
	get_node("animation").animation = "Extend";
	get_node("animation").frame = 0;
	get_node("animation").stop();
	set_collision_layer_bit(Global.CollisionType.hazard, true);
	set_collision_mask_bit(Global.CollisionType.player, true);
	connect("body_entered", self, "Damage");
	connect("area_entered", self, "Damage");
	
	pass

func Damage(body):
	Damage.DealDamage(10, body, Damage.DamageType.grapple, self);
	entangledBodies.push_back(body);
	entangledPositions.push_back(body.global_position);
	return;

func BeginAttack(Time):
	if(!is_processing()):
		visible = true;
		runTime = Time;
		set_process(true);
	return;

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	time += delta;
	if(time >= delay && time < runTime - delay): #&& !get_node("animation").is_playing()):
		get_node("animation").play("Extend");
		get_node("Collision").disabled = false;
		global_position += Vector2(0,0);
		
	if(time >= runTime - delay):
		get_node("animation").play("Retract");
	
	for i in range(0, entangledBodies.size()):
		entangledBodies[i].global_position = entangledPositions[i];
	
	if(get_node("animation").animation == "Retract" && get_node("animation").frame == 4):
		visible = false;
		runTime = 0.0;
		time = 0.0;
		get_node("animation").stop();
		get_node("animation").animation = "Extend";
		get_node("animation").frame = 0;
		set_process(false);
		get_node("Collision").disabled = true;
		entangledBodies = [];
		entangledPositions = [];
		#if(branch == null):
		var newBranch = load("res://Scenes/Entities/Objects/Branch/Branch.tscn").instance();
		#	branch = newBranch;
		Global.current_scene.add_child(newBranch);
		newBranch.global_position = global_position + Vector2(40, 50);
		newBranch.apply_impulse(Vector2(0,0), Vector2(100,0).rotated(randf()*2*PI));
	pass
