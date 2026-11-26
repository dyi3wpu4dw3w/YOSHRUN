extends CharacterBody3D

@export var move_speed := 5.2
@export var look_sensitivity := 0.004
var gravity := 18.0
var camera_pivot: Node3D
var camera: Camera3D
var visual: MeshInstance3D
var move_touch_id := -1
var look_touch_id := -1
var move_origin := Vector2.ZERO
var move_vector := Vector2.ZERO
var yaw := 0.0
var pitch := -0.18

func _ready() -> void:
	_make_player()
	_make_camera()

func _make_player() -> void:
	var capsule := CapsuleMesh.new()
	capsule.radius = 0.38
	capsule.height = 1.7
	visual = MeshInstance3D.new()
	visual.mesh = capsule
	var mat := StandardMaterial3D.new()
	mat.albedo_color = Color(0.18, 0.48, 0.62)
	visual.material_override = mat
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
	camera.current = true
	camera_pivot.add_child(camera)

func _input(event: InputEvent) -> void:
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
	var input_vec := move_vector
	if input_vec.length() < 0.05:
		input_vec = Vector2(
			Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
			Input.get_action_strength("move_back") - Input.get_action_strength("move_forward")
		)
	var direction := (camera_pivot.global_transform.basis * Vector3(input_vec.x, 0, input_vec.y)).normalized()
	velocity.x = direction.x * move_speed
	velocity.z = direction.z * move_speed
	if not is_on_floor():
		velocity.y -= gravity * delta
	else:
		velocity.y = 0
	move_and_slide()
