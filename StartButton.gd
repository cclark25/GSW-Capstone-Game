extends Button

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _pressed():
	#var scene = get_parent().get_node("OptionButton").get_item_text(get_parent().get_node("OptionButton").get_selected_id() - 1);
	#printerr(scene);
	#get_tree().change_scene(scene);
	Global.set_current_scene(get_parent().get_node("OptionButton").get_item_text(get_parent().get_node("OptionButton").selected));
	pass;

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
