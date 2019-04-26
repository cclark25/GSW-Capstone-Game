extends AnimatedSprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"


func _ready():
	set_process(true);
	connect("animation_finished", self, "OnAnimationFinish");
	pass

func _process(delta):
	if get_parent().inAggroMode:
		var dir = 2 * int((get_parent().position.angle_to_point((Global.Player.position))) / (PI/3)) - 4;
		Play(dir);
	else:
		stop()
	pass

func Play(dir):
	match dir % 4:
		0:
			get_parent().get_node("CollisionShapeBodyVert").set_disabled(true);
			get_parent().get_node("Area2DVert/CollisionShape2DVert").set_disabled(true);
			get_parent().get_node("CollisionShapeBodyHor").set_disabled(false);
			get_parent().get_node("Area2DHor/CollisionShape2DHor").set_disabled(false);
		-2:
			get_parent().get_node("CollisionShapeBodyVert").set_disabled(false);
			get_parent().get_node("Area2DVert/CollisionShape2DVert").set_disabled(false);
			get_parent().get_node("CollisionShapeBodyHor").set_disabled(true);
			get_parent().get_node("Area2DHor/CollisionShape2DHor").set_disabled(true);
			
	play("Walk." + Global.Directions.keys()[dir]);
	
func OnAnimationFinish():
	pass