extends CharacterBody3D

signal health_changed(current: int, maximum: int)
signal player_died

@export var move_speed := 5.2
@export var look_sensitivity := 0.004
@export var max_health := 100

var health := 100
var gravity := 18.0
var camera_pivot: Node3D
var camera: Camera3D
var move_touch_id := -1
var look_touch_id := -1
var move_origin := Vector2.ZERO
var move_vector := Vector2.ZERO
var yaw := 0.0
var pitch := -0.18
var damage_lock := 0.0
var dead := false
var first_person := false

func _ready() -> void:
	health = max_health
	_make_player()
	_make_camera()
	health_changed.emit(health, max_health)

func _make_player() -> void:
	var capsule := CapsuleMesh.new()
	capsule.radius = 0.38
	capsule.height = 1.7
	var visual := MeshInstance3D.new()
	visual.mesh = capsule
	var material := StandardMaterial3D.new()
	material.albedo_color = Color(0.18, 0.48, 0.62)
	visual.material_override = material
	visual.position.y = 0.85
	add_child(visual)
	var collision := CollisionShape3D.new()
	var shape := CapsuleShape3D.new()
	shape.radius = 0.38
	shape.height = 1.7
	collision.shape = shape
	collision.position.y = 0.85
	add_child(collision)

func _make_camera() -> void:
	camera_pivot = Node3D.new()
	camera_pivot.position = Vector3(0, 1.45, 0)
	add_child(camera_pivot)
	camera = Camera3D.new()
	camera.position = Vector3(0, 1.0, 4.8)
	camera.rotation.x = -0.12
	camera.fov = 75.0
	camera.current = true
	camera_pivot.add_child(camera)

func toggle_camera_view() -> void:
	first_person = not first_person
	if first_person:
		camera.position = Vector3(0, 0.12, 0.12)
		camera.fov = 82.0
	else:
		camera.position = Vector3(0, 1.0, 4.8)
		camera.fov = 75.0

func _input(event: InputEvent) -> void:
	if dead or get_tree().paused:
		return
	if event is InputEventScreenTouch:
		if event.pressed:
			if event.position.x < get_viewport().get_visible_rect().size.x * 0.48 and move_touch_id == -1:
				move_touch_id = event.index
				move_origin = event.position
			elif look_touch_id == -1:
				look_touch_id = event.index
		else:
			if event.index == move_touch_id:
				move_touch_id = -1
				move_vector = Vector2.ZERO
			if event.index == look_touch_id:
				look_touch_id = -1
	elif event is InputEventScreenDrag:
		if event.index == move_touch_id:
			move_vector = (event.position - move_origin).limit_length(90.0) / 90.0
		elif event.index == look_touch_id:
			yaw -= event.relative.x * look_sensitivity
			pitch = clamp(pitch - event.relative.y * look_sensitivity, -0.8, 0.35)
			camera_pivot.rotation.y = yaw
			camera.rotation.x = pitch

func _physics_process(delta: float) -> void:
	if get_tree().paused:
		return
	damage_lock = maxf(0.0, damage_lock - delta)
	if dead:
		velocity = Vector3.ZERO
		return
	var input_vector := move_vector
	if input_vector.length() < 0.05:
		input_vector = Vector2(
			Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
			Input.get_action_strength("move_back") - Input.get_action_strength("move_forward")
		)
	var direction := (camera_pivot.global_transform.basis * Vector3(input_vector.x, 0, input_vector.y)).normalized()
	velocity.x = direction.x * move_speed
	velocity.z = direction.z * move_speed
	if not is_on_floor():
		velocity.y -= gravity * delta
	else:
		velocity.y = 0.0
	move_and_slide()

func take_damage(amount: int) -> void:
	if dead or damage_lock > 0.0:
		return
	health = maxi(0, health - amount)
	damage_lock = 0.65
	health_changed.emit(health, max_health)
	if health <= 0:
		dead = true
		player_died.emit()

func heal(amount: int) -> void:
	if dead:
		return
	health = mini(max_health, health + amount)
	health_changed.emit(health, max_health)
