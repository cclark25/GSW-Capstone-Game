extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var direction = Vector2(0,0);
export (int) var speed = 5;
export (float) var jumpModifier = 1.75;
onready var activeItem = get_node("Sword");
var targetCursor = preload("res://Scenes/Entities/Familiars/Bird/Bird.tscn").instance();

func get_direction():
	return direction;

class _target extends Node2D:
	func _init():
		pass;
	func _ready():
		set_process(false);
		pass;
	func _process(delta):
		var new_pos = get_viewport().get_mouse_position();
		#if(new_pos.distance_to(global_position) >= 10):
		global_position = new_pos; #- Vector2(10,0).rotated(new_pos.angle());
		pass;
		
var targetBody = _target.new();


func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	set_process(false);
	targetBody.set_name("TargetBody");
	
	
	#if(Global.get_current_scene() == null):
	#	Global.set_current_scene(self);
	
	Global.SpawnNode(targetCursor);
	Global.SpawnNode(targetBody);
	#targetCursor.global_position = targetBody.global_position;
	
	set_collision_layer_bit(Global.CollisionType.player, true);
	#printerr(Global.get_current_scene().name);
	
	return;
	
func TakeDamage(amount, sourceLocation):
	#if(!(get_child(1).damaged)):
	#	get_child(1).damaged = true;
	#	get_child(1).animationTime = 0;
	#	get_child(1).lifePoints -= amount;
	#	if(get_child(1).lifePoints <= 0):
	#		get_tree().change_scene("res://GameOverScreen.tscn");
	#	move_and_collide((position - sourceLocation ).normalized() * 75);
	pass	

func Move(delta):
	var animator = get_node("Animation");
	if(animator.CurrentMode == animator.Modes.Walk && direction.length() != 0):
		move_and_collide(direction.normalized() * speed);
		return;
	
	if(animator.CurrentMode == animator.Modes.Roll):
		move_and_collide(direction.normalized() * speed * jumpModifier);
		return;
	
	set_process(false);
	pass;

func Target():
	if(!targetBody.is_processing()):
		targetBody.global_position = get_viewport().get_mouse_position();
		targetCursor.Send(targetBody, self);
		targetBody.set_process(true);
	else:
		#targetBody.position *= 0;
		targetBody.global_position = global_position;
		targetCursor.Return(targetBody, self);
		targetBody.set_process(false);
	pass;

func _input(event):
	set_process(true);
	var animator = get_node("Animation");
	
	if(event.is_action_pressed("Right")):
		direction.x += 1;
	if(event.is_action_released("Right")):
		direction.x -= 1;
	if(event.is_action_pressed("Left")):
		direction.x -= 1;
	if(event.is_action_released("Left")):
		direction.x += 1;
	if(event.is_action_pressed("Up")):
		direction.y -= 1;
	if(event.is_action_released("Up")):
		direction.y += 1;
	if(event.is_action_pressed("Down")):
		direction.y += 1;
	if(event.is_action_released("Down")):
		direction.y -= 1;
	
	if(event.is_action_pressed("Jump")):
		animator.CurrentMode = animator.Modes.Roll;
	
	if(event.is_action_pressed("Target")):
		Target();
	
	if(event.is_action_pressed("Left Click") && activeItem != null && activeItem.has_method("Use")):
		activeItem.Use();
	
	animator.Update();
	pass;

func _process(delta):
	Move(delta);
	
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	pass
