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
	play("Walk." + Global.Directions.keys()[dir]);
	
func OnAnimationFinish():
	pass