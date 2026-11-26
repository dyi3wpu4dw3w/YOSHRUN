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
	var mesh := CapsuleMesh.new()
	mesh.radius = 0.62
	mesh.height = 2.2
	visual = MeshInstance3D.new()
	visual.mesh = mesh
	var mat := StandardMaterial3D.new()
	mat.albedo_color = Color(0.32, 0.08, 0.07)
	mat.roughness = 0.8
	visual.material_override = mat
	visual.position.y = 1.1
	add_child(visual)
	var collision := CollisionShape3D.new()
	var shape := CapsuleShape3D.new()
	shape.radius = 0.62
	shape.height = 2.2
	collision.shape = shape
	collision.position.y = 1.1
	add_child(collision)

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
