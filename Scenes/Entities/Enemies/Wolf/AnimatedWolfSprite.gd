extends AnimatedSprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"


func _ready():
	set_process(false);
	connect("animation_finished", self, "OnAnimationFinish");
	pass

func _process(delta):
	var dir = int((get_parent().angleToPlayer()) / (PI/8));
	Play(dir);
	pass

func Play(dir):
	play("Walk." + Global.Directions.keys()[dir]);