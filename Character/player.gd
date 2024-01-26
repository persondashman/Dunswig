extends CharacterBody2D

class_name Player

@export var speed : float = 200.0
@export var controls: Resource = null

@onready var sprite : Sprite2D = $Sprite2D
@onready var animation_tree : AnimationTree = $AnimationTree
@onready var state_machine : CharacterStateMachine = $CharacterStateMachine

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction

signal facing_direction_changed(facing_right : bool)

func _ready():
	animation_tree.active = true
	Global.player = self
	
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_axis(controls.move_left, controls.move_right)
	
	# Control whether to move or not to move
	if direction != 0 && state_machine.check_if_can_move():
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
	update_animation_parameters()
	update_facing_direction()
	
func update_animation_parameters():
	animation_tree.set("parameters/move/blend_position", direction)

func update_facing_direction():
	if direction > 0:
		sprite.flip_h = false
		
	elif direction < 0:
		sprite.flip_h = true
	
	emit_signal("facing_direction_changed", !sprite.flip_h)
