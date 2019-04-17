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
	match [Global.Directions.keys()[dir]]:
		["Right", "Left"]:
			get_parent().get_node("WolfCollisionAreaBody1").Visible = false;
			get_parent().get_node("WolfCollisionAreaBody2").Visible = true;
		["Up", "Down"]:
			get_parent().get_node("WolfCollisionAreaBody1").Visible = true;
			get_parent().get_node("WolfCollisionAreaBody2").Visible = false;
			
	play("Walk." + Global.Directions.keys()[dir]);
	
func OnAnimationFinish():
	pass