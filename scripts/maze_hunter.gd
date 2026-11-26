extends CharacterBody3D

@export var move_speed := 2.8
@export var detection_range := 18.0
@export var attack_range := 1.5
@export var attack_damage := 18
@export var attack_interval := 1.4

var target: Node3D
var gravity := 18.0
var visual: MeshInstance3D
var attack_cooldown := 0.0

func _ready() -> void:
	# The WARDEN: a towering original maze creature with layered armor and glowing eyes.
	var hide_mat := _mat(Color(0.075, 0.035, 0.045))
	var plate_mat := _mat(Color(0.22, 0.075, 0.055), 0.28)
	var glow_mat := _mat(Color(1.0, 0.12, 0.035), 0.1, true)
	_add_capsule(Vector3(0, 1.15, 0), 0.58, 2.1, hide_mat)
	_add_sphere(Vector3(0, 2.25, -0.05), 0.48, hide_mat)
	_add_box(Vector3(0, 1.55, -0.48), Vector3(0.95, 0.75, 0.16), plate_mat)
	for side in [-1.0, 1.0]:
		_add_capsule(Vector3(side * 0.72, 1.45, 0), 0.22, 1.5, plate_mat, Vector3(0, 0, side * -0.22))
		_add_capsule(Vector3(side * 0.30, 0.45, 0), 0.25, 0.95, hide_mat)
		_add_sphere(Vector3(side * 0.19, 2.30, -0.46), 0.075, glow_mat)
		_add_capsule(Vector3(side * 0.27, 2.76, 0.0), 0.10, 0.8, plate_mat, Vector3(0, 0, side * -0.48))
	var collision := CollisionShape3D.new()
	var shape := CapsuleShape3D.new()
	shape.radius = 0.62
	shape.height = 2.7
	collision.shape = shape
	collision.position.y = 1.35
	add_child(collision)

func _mat(color: Color, metallic := 0.0, glow := false) -> StandardMaterial3D:
	var m := StandardMaterial3D.new()
	m.albedo_color = color
	m.metallic = metallic
	m.roughness = 0.55
	if glow:
		m.emission_enabled = true
		m.emission = color
		m.emission_energy_multiplier = 2.8
	return m

func _add_capsule(pos: Vector3, radius: float, height: float, mat: Material, rot := Vector3.ZERO) -> void:
	var mesh := CapsuleMesh.new()
	mesh.radius = radius
	mesh.height = height
	var node := MeshInstance3D.new()
	node.mesh = mesh
	node.position = pos
	node.rotation = rot
	node.material_override = mat
	add_child(node)

func _add_sphere(pos: Vector3, radius: float, mat: Material) -> void:
	var mesh := SphereMesh.new()
	mesh.radius = radius
	mesh.height = radius * 2.0
	var node := MeshInstance3D.new()
	node.mesh = mesh
	node.position = pos
	node.material_override = mat
	add_child(node)

func _add_box(pos: Vector3, size: Vector3, mat: Material) -> void:
	var mesh := BoxMesh.new()
	mesh.size = size
	var node := MeshInstance3D.new()
	node.mesh = mesh
	node.position = pos
	node.material_override = mat
	add_child(node)

func _physics_process(delta: float) -> void:
	attack_cooldown = maxf(0.0, attack_cooldown - delta)
	if not is_instance_valid(target):
		velocity = Vector3.ZERO
		return
	var offset: Vector3 = target.global_position - global_position
	offset.y = 0
	var distance := offset.length()
	if distance <= detection_range and distance > attack_range:
		var direction := offset.normalized()
		velocity.x = direction.x * move_speed
		velocity.z = direction.z * move_speed
		look_at(Vector3(target.global_position.x, global_position.y, target.global_position.z), Vector3.UP)
	else:
		velocity.x = move_toward(velocity.x, 0.0, move_speed)
		velocity.z = move_toward(velocity.z, 0.0, move_speed)
	if not is_on_floor():
		velocity.y -= gravity * delta
	else:
		velocity.y = 0
	if distance <= attack_range and attack_cooldown <= 0.0:
		attack_cooldown = attack_interval
		if target.has_method("take_damage"):
			target.take_damage(attack_damage)
	move_and_slide()
