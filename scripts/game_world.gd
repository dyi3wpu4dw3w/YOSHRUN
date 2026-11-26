extends Node3D

const PLAYER_SCRIPT = preload("res://scripts/player_controller.gd")
const HUNTER_SCRIPT = preload("res://scripts/maze_hunter.gd")

var player: CharacterBody3D
var hunter: CharacterBody3D
var gate: StaticBody3D
var gate_collision: CollisionShape3D
var key_node: Area3D
var status_label: Label
var health_label: Label
var timer_label: Label
var camera_button: Button
var pause_button: Button
var pause_layer: ColorRect
var game_finished := false
var key_collected := false
var elapsed := 0.0

func _ready() -> void:
	_build_world()
	_build_maze()
	_build_world_details()
	_spawn_player()
	_spawn_hunter()
	_build_hud()
	player.health_changed.connect(_on_health_changed)
	player.player_died.connect(_on_player_died)

func _process(delta: float) -> void:
	if get_tree().paused or game_finished:
		return
	elapsed += delta
	if is_instance_valid(hunter) and is_instance_valid(player):
		hunter.target = player
	timer_label.text = "%02d:%02d" % [int(elapsed) / 60, int(elapsed) % 60]

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
	var material := StandardMaterial3D.new()
	material.albedo_color = color
	material.roughness = 0.95
	return material

func _block(pos: Vector3, size: Vector3, color: Color) -> StaticBody3D:
	var body := StaticBody3D.new()
	body.position = pos
	var mesh := MeshInstance3D.new()
	var box := BoxMesh.new()
	box.size = size
	mesh.mesh = box
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
	_block(Vector3(0, -0.6, 0), Vector3(34, 1, 34), Color(0.12, 0.14, 0.14))
	var stone := Color(0.28, 0.31, 0.30)
	for x in [-15, -9, -3, 3, 9, 15]:
		_block(Vector3(x, 2, -12), Vector3(0.8, 4, 12), stone)
		_block(Vector3(x, 2, 12), Vector3(0.8, 4, 12), stone)
	for z in [-15, -9, -3, 3, 9, 15]:
		_block(Vector3(-12, 2, z), Vector3(6, 4, 0.8), stone)
		_block(Vector3(12, 2, z), Vector3(6, 4, 0.8), stone)

	key_node = Area3D.new()
	key_node.name = "MazeKey"
	key_node.position = Vector3(-6, 0.7, -6)
	var key_mesh := MeshInstance3D.new()
	var sphere := SphereMesh.new()
	sphere.radius = 0.3
	sphere.height = 0.6
	key_mesh.mesh = sphere
	key_mesh.material_override = _material(Color(1.0, 0.72, 0.08))
	key_node.add_child(key_mesh)
	var key_collision := CollisionShape3D.new()
	var key_shape := SphereShape3D.new()
	key_shape.radius = 0.9
	key_collision.shape = key_shape
	key_node.add_child(key_collision)
	key_node.body_entered.connect(_on_key_body_entered)
	add_child(key_node)

	gate = _block(Vector3(0, 1.8, -15), Vector3(4, 3.6, 0.6), Color(0.12, 0.07, 0.04))
	gate.name = "ExitGate"
	gate_collision = gate.get_node_or_null("CollisionShape3D")
	var exit_area := Area3D.new()
	exit_area.position = Vector3(0, 0.5, -16.5)
	var exit_collision := CollisionShape3D.new()
	var exit_shape := BoxShape3D.new()
	exit_shape.size = Vector3(4, 2, 2)
	exit_collision.shape = exit_shape
	exit_area.add_child(exit_collision)
	exit_area.body_entered.connect(_on_exit_body_entered)
	add_child(exit_area)


func _build_world_details() -> void:
	# Ruined settlement around the labyrinth: huts, watchtowers, trees and warm lanterns.
	var wood := Color(0.20, 0.105, 0.055)
	var plaster := Color(0.43, 0.39, 0.30)
	var roof := Color(0.12, 0.16, 0.17)
	for p in [Vector3(-23, 0, -18), Vector3(23, 0, -18), Vector3(-23, 0, 18), Vector3(23, 0, 18)]:
		_build_house(p, wood, plaster, roof)
	for p in [Vector3(-20, 0, 0), Vector3(20, 0, 0), Vector3(0, 0, -22), Vector3(0, 0, 22)]:
		_build_watchtower(p)
	for p in [Vector3(-19, 0, -10), Vector3(19, 0, -10), Vector3(-19, 0, 10), Vector3(19, 0, 10), Vector3(-25, 0, 8), Vector3(25, 0, -8)]:
		_build_tree(p)
	for x in range(-15, 16, 6):
		for z in range(-15, 16, 6):
			if (abs(x) + abs(z)) % 12 == 0:
				_build_lantern(Vector3(float(x), 0, float(z)))

func _build_house(p: Vector3, wood: Color, plaster: Color, roof: Color) -> void:
	var base := _block(p + Vector3(0, 1.25, 0), Vector3(5.2, 2.5, 4.6), plaster)
	base.name = "RuinedHouse"
	_block(p + Vector3(0, 2.8, 0), Vector3(5.8, 0.45, 5.2), roof)
	_block(p + Vector3(0, 3.35, 0), Vector3(5.0, 0.55, 0.45), wood)
	_block(p + Vector3(-1.45, 1.7, -2.36), Vector3(0.75, 1.1, 0.12), Color(0.035, 0.045, 0.05))
	_block(p + Vector3(1.5, 1.7, -2.36), Vector3(0.75, 1.1, 0.12), Color(0.035, 0.045, 0.05))
	_block(p + Vector3(0, 0.8, 2.38), Vector3(1.0, 1.6, 0.16), wood)

func _build_watchtower(p: Vector3) -> void:
	_block(p + Vector3(0, 2.2, 0), Vector3(1.0, 4.4, 1.0), Color(0.28, 0.29, 0.27))
	_block(p + Vector3(0, 4.5, 0), Vector3(3.2, 0.35, 3.2), Color(0.16, 0.13, 0.10))
	_block(p + Vector3(0, 5.1, 0), Vector3(2.8, 0.9, 2.8), Color(0.22, 0.19, 0.14))

func _build_tree(p: Vector3) -> void:
	var trunk := MeshInstance3D.new()
	var trunk_mesh := CylinderMesh.new()
	trunk_mesh.top_radius = 0.18
	trunk_mesh.bottom_radius = 0.32
	trunk_mesh.height = 2.5
	trunk.mesh = trunk_mesh
	trunk.position = p + Vector3(0, 1.25, 0)
	trunk.material_override = _material(Color(0.19, 0.105, 0.055))
	add_child(trunk)
	var crown := MeshInstance3D.new()
	var crown_mesh := SphereMesh.new()
	crown_mesh.radius = 1.25
	crown_mesh.height = 2.2
	crown.mesh = crown_mesh
	crown.position = p + Vector3(0, 3.0, 0)
	crown.material_override = _material(Color(0.09, 0.20, 0.13))
	add_child(crown)

func _build_lantern(p: Vector3) -> void:
	_block(p + Vector3(0, 1.0, 0), Vector3(0.12, 2.0, 0.12), Color(0.12, 0.10, 0.08))
	var lamp := OmniLight3D.new()
	lamp.position = p + Vector3(0, 2.0, 0)
	lamp.light_color = Color(1.0, 0.57, 0.19)
	lamp.light_energy = 0.65
	lamp.omni_range = 4.5
	add_child(lamp)

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

func _make_button(text_value: String, parent: Control, pos: Vector2, size: Vector2) -> Button:
	var button := Button.new()
	button.text = text_value
	button.position = pos
	button.size = size
	button.add_theme_font_size_override("font_size", 18)
	parent.add_child(button)
	return button

func _build_hud() -> void:
	var layer := CanvasLayer.new()
	add_child(layer)
	var root := Control.new()
	root.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	layer.add_child(root)

	status_label = Label.new()
	status_label.position = Vector2(24, 18)
	status_label.text = "THE MAZE  |  FIND THE GOLDEN KEY"
	status_label.add_theme_font_size_override("font_size", 23)
	status_label.add_theme_color_override("font_color", Color(0.96, 0.94, 0.86))
	root.add_child(status_label)

	health_label = Label.new()
	health_label.position = Vector2(24, 58)
	health_label.add_theme_font_size_override("font_size", 19)
	root.add_child(health_label)
	_on_health_changed(100, 100)

	timer_label = Label.new()
	timer_label.anchor_left = 0.5
	timer_label.anchor_right = 0.5
	timer_label.offset_left = -55
	timer_label.offset_right = 55
	timer_label.offset_top = 20
	timer_label.offset_bottom = 52
	timer_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	timer_label.add_theme_font_size_override("font_size", 22)
	root.add_child(timer_label)

	camera_button = _make_button("3RD PERSON", root, Vector2(-220, 20), Vector2(145, 48))
	camera_button.anchor_left = 1.0
	camera_button.anchor_right = 1.0
	camera_button.pressed.connect(_on_camera_pressed)

	pause_button = _make_button("Ⅱ", root, Vector2(-62, 20), Vector2(48, 48))
	pause_button.anchor_left = 1.0
	pause_button.anchor_right = 1.0
	pause_button.pressed.connect(_show_pause_menu)

	var hint := Label.new()
	hint.text = "LEFT: MOVE     RIGHT: LOOK     COLLECT THE KEY TO OPEN THE EXIT"
	hint.anchor_top = 1.0
	hint.anchor_bottom = 1.0
	hint.offset_left = 24
	hint.offset_top = -42
	hint.add_theme_font_size_override("font_size", 15)
	root.add_child(hint)

	pause_layer = ColorRect.new()
	pause_layer.color = Color(0.01, 0.02, 0.03, 0.88)
	pause_layer.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	pause_layer.visible = false
	pause_layer.mouse_filter = Control.MOUSE_FILTER_STOP
	root.add_child(pause_layer)
	var menu := VBoxContainer.new()
	menu.set_anchors_and_offsets_preset(Control.PRESET_CENTER)
	menu.position = Vector2(-150, -110)
	menu.size = Vector2(300, 220)
	pause_layer.add_child(menu)
	var title := Label.new()
	title.text = "GAME PAUSED"
	title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	title.add_theme_font_size_override("font_size", 28)
	menu.add_child(title)
	var resume := Button.new()
	resume.text = "RESUME"
	resume.pressed.connect(_hide_pause_menu)
	menu.add_child(resume)
	var restart := Button.new()
	restart.text = "RESTART"
	restart.pressed.connect(_restart_game)
	menu.add_child(restart)

func _on_health_changed(current: int, maximum: int) -> void:
	if health_label:
		health_label.text = "HEALTH  %d / %d" % [current, maximum]

func _on_camera_pressed() -> void:
	if is_instance_valid(player):
		player.toggle_camera_view()
		camera_button.text = "1ST PERSON" if player.first_person else "3RD PERSON"

func _on_key_body_entered(body: Node3D) -> void:
	if body != player or key_collected or game_finished:
		return
	key_collected = true
	key_node.queue_free()
	_open_exit_gate()
	status_label.text = "KEY FOUND  |  EXIT GATE UNLOCKED — RUN!"

func _open_exit_gate() -> void:
	if not is_instance_valid(gate):
		return
	if is_instance_valid(gate_collision):
		gate_collision.set_deferred("disabled", true)
	var tween := create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(gate, "position:y", gate.position.y + 4.2, 1.1)
	tween.tween_callback(func() -> void:
		if is_instance_valid(gate):
			gate.visible = false
	)

func _on_exit_body_entered(body: Node3D) -> void:
	if body == player and key_collected and not game_finished:
		game_finished = true
		_finish_game("ESCAPE SUCCESSFUL", "CHAPTER I — THE MAZE")

func _on_player_died() -> void:
	if not game_finished:
		game_finished = true
		_finish_game("YOU WERE CAUGHT", "THE MAZE CLAIMED ANOTHER RUNNER")

func _finish_game(title_text: String, subtitle: String) -> void:
	status_label.text = title_text + "\n" + subtitle
	get_tree().paused = true
	pause_layer.visible = true
	for child in pause_layer.get_children():
		child.queue_free()
	var menu := VBoxContainer.new()
	menu.set_anchors_and_offsets_preset(Control.PRESET_CENTER)
	menu.position = Vector2(-170, -80)
	menu.size = Vector2(340, 160)
	pause_layer.add_child(menu)
	var title := Label.new()
	title.text = title_text + "\n" + subtitle
	title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	menu.add_child(title)
	var restart := Button.new()
	restart.text = "PLAY AGAIN"
	restart.pressed.connect(_restart_game)
	menu.add_child(restart)

func _show_pause_menu() -> void:
	if game_finished:
		return
	pause_layer.visible = true
	get_tree().paused = true

func _hide_pause_menu() -> void:
	pause_layer.visible = false
	get_tree().paused = false

func _restart_game() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()
