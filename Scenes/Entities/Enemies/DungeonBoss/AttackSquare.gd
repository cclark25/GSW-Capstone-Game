extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var runTime = 0.0;
var time = 0.0;
var delay = 0.5;

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	set_process(false);
	visible = false;
	get_node("animation").animation = "Extend";
	get_node("animation").frame = 0;
	get_node("animation").stop();
	pass

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
	if(time >= runTime - delay):
		get_node("animation").play("Retract");
	
	
	
	if(get_node("animation").animation == "Retract" && get_node("animation").frame == 4):
		visible = false;
		runTime = 0.0;
		time = 0.0;
		set_process(false);
	pass
