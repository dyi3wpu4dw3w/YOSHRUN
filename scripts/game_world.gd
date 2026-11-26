extends Node3D

const PLAYER_SCRIPT = preload("res://scripts/player_controller.gd")
const HUNTER_SCRIPT = preload("res://scripts/maze_hunter.gd")

var player: CharacterBody3D
var hunter: CharacterBody3D
var status_label: Label
var key_collected := false
var gate_open := false
var elapsed := 0.0

func _ready() -> void:
	_build_world()
	_build_maze()
	_spawn_player()
	_spawn_hunter()
	_build_hud()

func _process(delta: float) -> void:
	elapsed += delta
	if is_instance_valid(hunter) and is_instance_valid(player):
		hunter.set("target", player)
	if status_label:
		var objective := "Find the key" if not key_collected else ("Reach the exit" if gate_open else "Unlock the gate")
		status_label.text = "YOSHRUN  •  THE MAZE\n" + objective + "     |     " + str(int(elapsed)) + "s"

func _build_world() -> void:
	var world_env := WorldEnvironment.new()
	var env := Environment.new()
	env.background_mode = Environment.BG_SKY
	env.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	env.ambient_light_color = Color(0.32, 0.37, 0.42)
	env.ambient_light_energy = 0.55
	world_env.environment = env
	add_child(world_env)
	var sun := DirectionalLight3D.new()
	sun.rotation_degrees = Vector3(-48, -32, 0)
	sun.light_energy = 0.65
	add_child(sun)

func _material(color: Color) -> StandardMaterial3D:
	var m := StandardMaterial3D.new()
	m.albedo_color = color
	m.roughness = 0.95
	return m

func _block(pos: Vector3, size: Vector3, color: Color) -> StaticBody3D:
	var body := StaticBody3D.new()
	body.position = pos
	var mesh := MeshInstance3D.new()
	var shape_mesh := BoxMesh.new()
	shape_mesh.size = size
	mesh.mesh = shape_mesh
	mesh.material_override = _material(color)
	body.add_child(mesh)
	var collision := CollisionShape3D.new()
	var shape := BoxShape3D.new()
	shape.size = size
	collision.shape = shape
	body.add_child(collision)
	add_child(body)
	return body

func _build_maze() -> void:
	_block(Vector3(0, -0.6, 0), Vector3(34, 1, 34), Color(0.17, 0.19, 0.18))
	var stone := Color(0.28, 0.31, 0.30)
	# Modular corridors: deliberately readable greybox layout.
	for x in [-15, -9, -3, 3, 9, 15]:
		_block(Vector3(x, 2, -12), Vector3(0.8, 4, 12), stone)
		_block(Vector3(x, 2, 12), Vector3(0.8, 4, 12), stone)
	for z in [-15, -9, -3, 3, 9, 15]:
		_block(Vector3(-12, 2, z), Vector3(6, 4, 0.8), stone)
		_block(Vector3(12, 2, z), Vector3(6, 4, 0.8), stone)
	# Key pedestal and exit gate are interactable objectives.
	var key := Area3D.new()
	key.name = "MazeKey"
	key.position = Vector3(-6, 0.7, -6)
	var key_mesh := MeshInstance3D.new()
	var sphere := SphereMesh.new()
	sphere.radius = 0.28
	sphere.height = 0.56
	key_mesh.mesh = sphere
	key_mesh.material_override = _material(Color(0.95, 0.72, 0.12))
	key.add_child(key_mesh)
	var key_collision := CollisionShape3D.new()
	var key_shape := SphereShape3D.new()
	key_shape.radius = 0.8
	key_collision.shape = key_shape
	key.add_child(key_collision)
	key.body_entered.connect(_on_key_body_entered)
	add_child(key)
	var gate := _block(Vector3(0, 1.8, -15), Vector3(4, 3.6, 0.6), Color(0.12, 0.09, 0.07))
	gate.name = "ExitGate"
	gate.set_meta("gate", true)
	gate.add_to_group("exit_gate")
	var exit_area := Area3D.new()
	exit_area.position = Vector3(0, 0.5, -16.5)
	var exit_shape := CollisionShape3D.new()
	var exit_box := BoxShape3D.new()
	exit_box.size = Vector3(4, 2, 2)
	exit_shape.shape = exit_box
	exit_area.add_child(exit_shape)
	exit_area.body_entered.connect(_on_exit_body_entered)
	add_child(exit_area)

func _spawn_player() -> void:
	player = CharacterBody3D.new()
	player.name = "Runner"
	player.position = Vector3(0, 0.2, 10)
	player.set_script(PLAYER_SCRIPT)
	add_child(player)

func _spawn_hunter() -> void:
	hunter = CharacterBody3D.new()
	hunter.name = "MazeHunter"
	hunter.position = Vector3(8, 0.2, -8)
	hunter.set_script(HUNTER_SCRIPT)
	add_child(hunter)

func _build_hud() -> void:
	var layer := CanvasLayer.new()
	add_child(layer)
	var root := Control.new()
	root.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	layer.add_child(root)
	status_label = Label.new()
	status_label.position = Vector2(24, 18)
	status_label.add_theme_font_size_override("font_size", 24)
	status_label.add_theme_color_override("font_color", Color(0.92, 0.94, 0.9))
	root.add_child(status_label)
	var help := Label.new()
	help.text = "LEFT SIDE: MOVE   •   RIGHT SIDE: LOOK   •   TAP NEAR OBJECT: INTERACT"
	help.anchor_left = 0.0
	help.anchor_top = 1.0
	help.anchor_bottom = 1.0
	help.offset_left = 24
	help.offset_top = -48
	help.add_theme_font_size_override("font_size", 16)
	root.add_child(help)

func _on_key_body_entered(body: Node3D) -> void:
	if body == player and not key_collected:
		key_collected = true
		var key_node := get_node_or_null("MazeKey")
		if key_node:
			key_node.queue_free()
		var gate := get_node_or_null("ExitGate")
		if gate:
			gate.queue_free()
		gate_open = true

func _on_exit_body_entered(body: Node3D) -> void:
	if body == player and key_collected:
		if status_label:
			status_label.text = "ESCAPE SUCCESSFUL  •  CHAPTER I TEST COMPLETE"
