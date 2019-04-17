extends AnimatedSprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"


func _ready():
	set_process(true);
	connect("animation_finished", self, "OnAnimationFinish");
	pass

func _process(delta):
	var dir = 2 * int((get_parent().position.angle_to_point((Global.Player.position))) / (PI/3)) - 4;
	Play(dir);
	pass

func Play(dir):
	match dir:
		0, -4, -8:
			get_parent().get_node("WolfCollisionAreaBody1").set_disabled(false);
			get_parent().get_node("WolfCollisionAreaBody2").set_disabled(true);
		-2, -6:
			get_parent().get_node("WolfCollisionAreaBody1").set_disabled(true);
			get_parent().get_node("WolfCollisionAreaBody2").set_disabled(false);
			
	play("Walk." + Global.Directions.keys()[dir]);
	
func OnAnimationFinish():
	pass