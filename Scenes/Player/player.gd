class_name Player
extends CharacterBody2D

@onready var coyote_timer = $CoyoteTimer
@onready var jump_buffer_timer = $JumpBufferTimer
@onready var jump_trojectory_line = $JumpTrojectoryLine
@onready var timer_label = $UILayer/TimerLabel

# Audio nodes are optional - may not exist in all scenes
var jump_sfx_1: AudioStreamPlayer
var land_sfx_1: AudioStreamPlayer
var jump_sfx_1_vari: AudioStreamPlayer
var land_sfx_1_vari: AudioStreamPlayer


var was_on_floor := false
var reset := false

# Timer tracking
var elapsed_time := 0.0
var is_timer_running := false
var start_position := Vector2.ZERO
var victory_height := 10000
var victory_reached := false

# Jump tracking for variable jump height
var is_jump_held := false
var jump_hold_boost := 0.0
var max_jump_hold_boost := 200.0  # Additional velocity boost from holding


@export_group("Movement")
## Maximum speed reachable by player
@export_range(0, 500) var max_speed := 200.0
## Minimum speed when variable_min_speed is set to true & min_speed isn't 0
@export_range(0, 500) var min_speed := 0.0
## Acceleration while on the ground (how quickly the player reaches max speed)
@export_range(0, 500) var acceleration := 100.0
## Friction while on group (how quickly the player slows down)
@export_range(0, 50) var friction := 50.0
## Acceleration while in the air (how quickly the player reaches max speed)
@export_range(0, 500) var air_acceleration := 5.0
## Air friction while in the air (how quickly the player slows down)
@export_range(0, 50) var air_resistance := 50.0
## Sets a variable max speed depending on how far the joystick is pushed
@export var is_variable_max_speed := false
## sets a minimum speed based on min_speed
@export var is_variable_min_speed := false

@export_group("Jump Assist")
## Max amount of time allowed after leaving the ground while still being able to jump
@export_range(0, 1) var coyote_timer_value = 0.1
## Max amount of time the game holds on to the players input to accecute when avaiable
@export_range(0, 1) var jump_buffer_timer_value = 0.15


@export_group("Jump")
## Max jump height
@export var jump_height := 100
## Amount of time it takes the player to reach the peak of their jump
@export var jump_time_to_peak := 0.4
## Amount of time it takes the player to fall from the peak of their jump to the ground
@export var jump_time_to_descent := 0.3
## Determains if a player jump highet changes depending on how long they held it in
@export var variable_jump_height := true
## Determains the minumum jump heighet a player can reach if they barely tap the jump button (and variable_jump_height is true)
@export var minimum_jump_height := 100

@export_group("Jump Trojectory")
## Maximum amount of points used to visualize player's jump trojectory (WiP)
@export var max_trojectory_ponints := 100

@export_group("Audio - Folio (SDT)")
## Maximum fall speed for impact energy calculation
@export_range(100, 1000) var max_fall_speed := 500.0
## Current surface type for folio synthesis (wood, stone, metal, etc.)
@export var current_surface_tag := "wood"


@onready var jump_velocity : float = (2.0 * jump_height) / jump_time_to_peak * -1
@onready var jump_gravity : float = (-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak) * -1
@onready var fall_gravity : float = (-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent) * -1


@export_group("Scene Rules")
@export var jump_enabled_scenes: PackedStringArray = PackedStringArray([
	"res://Scenes/Main/main.tscn",
	"res://Scenes/Main/static-sample-jump.tscn",
	"res://Scenes/Main/static-sample-variations-jump.tscn"
])
@export var scene_shortcuts: PackedStringArray = PackedStringArray([
	"res://Scenes/Main/main.tscn",
	"res://Scenes/Main/low-accel-SDT-s1.tscn",
	"res://Scenes/Main/static-sample-jump.tscn",
	"res://Scenes/Main/static-sample-variations-jump.tscn"
])

func _ready():
	coyote_timer.wait_time = coyote_timer_value
	jump_buffer_timer.wait_time = jump_buffer_timer_value
	start_position = global_position
	victory_height = -2510
	_update_timer_display()
	reset = true
	
	# Try to load audio nodes if they exist
	if has_node("jump_sfx_1"):
		jump_sfx_1 = $jump_sfx_1
	if has_node("land_sfx_1"):
		land_sfx_1 = $land_sfx_1
	if has_node("jump_sfx_1_vari"):
		jump_sfx_1_vari = $jump_sfx_1_vari
	if has_node("land_sfx_1_vari"):
		land_sfx_1_vari = $land_sfx_1_vari


# Sets the gravity depending on the context
func _get_gravity(_velocity):
	return jump_gravity if _velocity.y < 0.0 else fall_gravity


# Calculates the players movement depending on the context
func _get_movement(fric: float, accel: float, delta: float):
	var direction = Input.get_axis("Move_Left", "Move_Right")

	if direction:
		velocity.x += sign(direction) * accel * delta * 100
	
	if !direction or sign(direction) != sign(velocity.x):
		velocity.x = move_toward(velocity.x, 0, fric * delta * 100)
	
	if is_variable_max_speed:
		velocity.x = clamp(velocity.x, -max_speed * abs(direction), max_speed * abs(direction))
	else:
		velocity.x = clamp(velocity.x, -max_speed, max_speed)
	
	if is_variable_min_speed and min_speed > 0:
			velocity.x = maxf(abs(velocity.x), abs(min_speed * sign(direction))) * sign(direction)

# A way to visialize the players jump trojectory in real time (WiP)
func _projected_jump_trojectory(_delta, direction):
	var max_points = max_trojectory_ponints
	
	jump_trojectory_line.clear_points()
	var pos := Vector2.ZERO
	var vel := Vector2(max_speed * direction, jump_velocity)
	for point in max_points:
		jump_trojectory_line.add_point(pos)
		vel.y += _get_gravity(vel) * _delta
		pos += vel * _delta


# Flips the player sprite depending on their movemnt direction
func _set_sprite_direction(direction: int) -> void:
	if direction > 0.0:
		$AnimatedSprite2D.flip_h = true

	if direction < 0.0:
		$AnimatedSprite2D.flip_h = false


func _physics_process(delta):
	if not is_on_floor():
		velocity.y += _get_gravity(velocity) * delta
		_get_movement(air_resistance, air_acceleration, delta)

		# SDT wind procsesing
		_sdt_wind()

	else:
		if coyote_timer.is_stopped():
			coyote_timer.start()
		if jump_buffer_timer.time_left > 0.0:
			jump_buffer_timer.stop()
			jump()
		_get_movement(friction, acceleration, delta)
	
	_set_sprite_direction(sign(velocity.x))
	
	if Input.is_action_just_pressed("Jump"):
		jump()
	
	if Input.is_action_just_released("Jump"):
		jump_cut()
	
	# Add boost to jump velocity while jump is held (variable jump height)
	if is_jump_held and Input.is_action_pressed("Jump") and variable_jump_height:
		if velocity.y < 0.0:  # Only boost while going upward
			jump_hold_boost += 200.0 * delta  # Boost accumulation rate
			jump_hold_boost = clamp(jump_hold_boost, 0.0, max_jump_hold_boost)
			velocity.y -= jump_hold_boost * delta
	
	# Start timer on first keyboard input (movement or jump)
	if not is_timer_running and (Input.is_action_pressed("Move_Left") or Input.is_action_pressed("Move_Right") or Input.is_action_pressed("Jump")) and reset:
		is_timer_running = true
		reset = false
		print("Timer started on input!")
	
	# Update timer if running
	if is_timer_running:
		elapsed_time += delta
		_update_timer_display()
		
		# Check if player reached victory height
		if position.y <= victory_height:
			_on_victory()
	
	if velocity != Vector2.ZERO:
		$AnimatedSprite2D.play("walk")
		$"OSCClient - OUT".send_message("/player/velocity", [velocity.x])
	else:
		$AnimatedSprite2D.play("idle")
		$"OSCClient - OUT".send_message("/player/velocity", [0])
		
#	if Input.is_action_just_pressed("Preview_Jump"):
#		_projected_jump_trojectory(delta, sign(velocity.x))
	
	# Capture velocity before move_and_slide() resets it
	var pre_landing_velocity = velocity
	
	move_and_slide()
	
	# Check if player just landed (velocity.y is now 0 after move_and_slide)
	if not was_on_floor and is_on_floor():
		is_jump_held = false
		jump_hold_boost = 0.0
		_on_landed(pre_landing_velocity, current_surface_tag)
	
	was_on_floor = is_on_floor()


func _unhandled_input(event):
	if event is InputEventKey and event.pressed and not event.echo:
		var scene_index := _get_scene_shortcut_index(event.keycode)
		if scene_index != -1:
			if scene_index == 9:  # 0 key - reset player position and timer
				_reset_player()
			else:
				_switch_to_scene(scene_index)


func _get_scene_shortcut_index(keycode: Key) -> int:
	if keycode >= KEY_1 and keycode <= KEY_9:
		return int(keycode - KEY_1)

	if keycode == KEY_0:
		return 9

	return -1


func _switch_to_scene(scene_index: int) -> void:
	if scene_index < 0 or scene_index >= scene_shortcuts.size():
		return

	var scene_path := scene_shortcuts[scene_index]
	if scene_path.is_empty():
		return

	if get_tree().current_scene and get_tree().current_scene.scene_file_path == scene_path:
		return

	get_tree().change_scene_to_file(scene_path)

	print("Switched to scene: ", scene_index + 1, " - ", scene_shortcuts[scene_index])


# Update the timer display label
func _update_timer_display() -> void:
	timer_label.text = "%.2f" % elapsed_time


# Called when the player reaches victory height
func _on_victory() -> void:
	is_timer_running = false
	print("Victory! Final time: %.2f seconds" % elapsed_time)
	_update_timer_display()
	$"OSCClient - OUT".send_message("/player/victory", [elapsed_time])


# Reset player position and timer to initial state
func _reset_player() -> void:
	global_position = start_position
	velocity = Vector2.ZERO
	elapsed_time = 0.0
	is_timer_running = false
	is_jump_held = false
	jump_hold_boost = 0.0
	_update_timer_display()
	reset = true
	victory_reached = false
	print("Player and timer reset!")


func _is_jump_enabled_in_current_scene() -> bool:
	if jump_enabled_scenes.is_empty():
		return true

	var current_scene := get_tree().current_scene
	if not current_scene:
		return false

	return current_scene.scene_file_path in jump_enabled_scenes


# Adds the player's jump velocity if able
func jump():
	
	if not _is_jump_enabled_in_current_scene():
		return
	
	if coyote_timer.time_left > 0.0:
		coyote_timer.stop()
		is_jump_held = true
		jump_hold_boost = 0.0
		
		# Set initial jump velocity to minimum if variable jump is enabled
		if variable_jump_height:
			velocity.y = -(minimum_jump_height / jump_time_to_peak * 2.0)
		else:
			velocity.y = jump_velocity
		
		print("Player Jumped at position: ", position)
		$"OSCClient - OUT".send_message("/player/jump", [1])
		
		# play jump sfx static sample
		if jump_sfx_1:
			jump_sfx_1.play()
			
		if jump_sfx_1_vari:
			# randomize the pitch scale
			jump_sfx_1_vari.pitch_scale = randf_range(0.8, 1.2)
			jump_sfx_1_vari.play()
		
	
	if _get_gravity(velocity) == fall_gravity:
		jump_buffer_timer.start()


# Stops jump acceleration if variable_jump_height is enabled
func jump_cut():
	is_jump_held = false
	jump_hold_boost = 0.0
	
	if not variable_jump_height:
		return
	
	# Limit jump height to minimum if released early
	if velocity.y < -minimum_jump_height:
		velocity.y = -minimum_jump_height

# function that runs when player lands
# Sends velocity and surface data to MAX for folio synthesis using SDT (Sound Design Toolkit)
func _on_landed(landing_velocity: Vector2, surface_tag: String):
	# Calculate impact energy from vertical velocity (0.0 to 1.0)
	var impact_energy = clamp(abs(landing_velocity.y) / max_fall_speed, 0.0, 10.0)
	
	# Send to MAX/SDT:
	# - Strike velocity: use negative vertical velocity for impact intensity
	$"OSCClient - OUT".send_message("/sdt/strike", [-landing_velocity.y, impact_energy])
	
	# - Surface type affects modal frequencies and decay times
	$"OSCClient - OUT".send_message("/sdt/surface", [surface_tag])
	
	# - Horizontal velocity for directional folio cues
	$"OSCClient - OUT".send_message("/sdt/direction", [sign(landing_velocity.x)])
	
	print("Player Landed - Impact Energy: %.2f" % impact_energy)
	$"OSCClient - OUT".send_message("/player/impact_energy", [impact_energy])
	$"OSCClient - OUT".send_message("/player/landed", [1])
	
	# play landing sfx static sample
	if land_sfx_1:
		land_sfx_1.play()
		
	if land_sfx_1_vari:
		land_sfx_1_vari.pitch_scale = randf_range(0.8, 1.2)
		land_sfx_1_vari.play()
		
func _sdt_wind():
	# send player velocity to MAX/SDT for wind synthesis
	$"OSCClient - OUT".send_message("/player/wind_velocity", [velocity.y])
