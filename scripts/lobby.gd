extends Node3D
## YOSHRUN cinematic mobile lobby. All interface elements are built at runtime.

const GOLD := Color(1.0, 0.72, 0.12)
const CYAN := Color(0.08, 0.72, 1.0)
const DARK := Color(0.025, 0.045, 0.075, 0.94)

var selected_mode := "MAZE ROYALE"
var selected_tab := "HOME"
var mode_label: Label
var info_label: Label
var hero_root: Node3D
var hero_nodes: Array[Node3D] = []

func _ready() -> void:
	_build_environment()
	_build_lobby_stage()
	_build_interface()

func _material(color: Color, metallic := 0.0, emission := 0.0) -> StandardMaterial3D:
	var m := StandardMaterial3D.new()
	m.albedo_color = color
	m.metallic = metallic
	m.roughness = 0.48
	if emission > 0.0:
		m.emission_enabled = true
		m.emission = color
		m.emission_energy_multiplier = emission
	return m

func _box(parent: Node3D, pos: Vector3, size: Vector3, color: Color, emission := 0.0) -> MeshInstance3D:
	var mesh := BoxMesh.new()
	mesh.size = size
	var node := MeshInstance3D.new()
	node.mesh = mesh
	node.position = pos
	node.material_override = _material(color, 0.12, emission)
	parent.add_child(node)
	return node

func _build_environment() -> void:
	var env_node := WorldEnvironment.new()
	var env := Environment.new()
	env.background_mode = Environment.BG_SKY
	env.sky = Sky.new()
	env.sky.sky_material = ProceduralSkyMaterial.new()
	env.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	env.ambient_light_color = Color(0.36, 0.48, 0.62)
	env.ambient_light_energy = 0.8
	env_node.environment = env
	add_child(env_node)
	var sun := DirectionalLight3D.new()
	sun.rotation_degrees = Vector3(-48, -28, 0)
	sun.light_energy = 1.25
	add_child(sun)
	var fill := OmniLight3D.new()
	fill.position = Vector3(0, 5, 1)
	fill.light_color = CYAN
	fill.light_energy = 2.2
	fill.omni_range = 18
	add_child(fill)

func _build_lobby_stage() -> void:
	var floor := _box(self, Vector3(0, -0.18, 0), Vector3(42, 0.35, 26), Color(0.12, 0.16, 0.19))
	floor.name = "LobbyFloor"
	for side in [-1.0, 1.0]:
		for i in range(5):
			_box(self, Vector3(side * 10.5, 2.4, -8.0 + i * 4.0), Vector3(1.3, 5.0, 1.3), Color(0.19, 0.22, 0.23))
	_box(self, Vector3(0, 5.0, -10.0), Vector3(11.0, 1.0, 1.2), Color(0.20, 0.24, 0.27))
	_box(self, Vector3(-4.8, 3.0, -10.0), Vector3(1.0, 5.0, 1.2), Color(0.20, 0.24, 0.27))
	_box(self, Vector3(4.8, 3.0, -10.0), Vector3(1.0, 5.0, 1.2), Color(0.20, 0.24, 0.27))
	var portal := MeshInstance3D.new()
	var ring := TorusMesh.new()
	ring.inner_radius = 1.65
	ring.outer_radius = 2.05
	ring.rings = 48
	ring.ring_segments = 12
	portal.mesh = ring
	portal.position = Vector3(0, 3.0, -9.2)
	portal.material_override = _material(CYAN, 0.4, 3.0)
	add_child(portal)
	var camera := Camera3D.new()
	camera.position = Vector3(0, 5.0, 13.5)
	camera.look_at(Vector3(0, 2.0, -4.0))
	camera.fov = 48
	add_child(camera)
	camera.current = true
	hero_root = Node3D.new()
	hero_root.name = "OriginalHeroSquad"
	add_child(hero_root)
	_create_hero("RAYAN", Vector3(0, 0, 1.1), Color(0.06, 0.48, 0.66), Color(0.04, 0.08, 0.12), 1.12)
	_create_hero("LINA", Vector3(-3.0, 0, 0.1), Color(0.72, 0.34, 0.18), Color(0.18, 0.12, 0.10), 0.94)
	_create_hero("KADIR", Vector3(3.0, 0, 0.1), Color(0.72, 0.42, 0.12), Color(0.12, 0.12, 0.12), 0.98)
	_create_hero("NOUR", Vector3(5.2, 0, -0.5), Color(0.28, 0.38, 0.72), Color(0.10, 0.12, 0.20), 0.90)

func _create_hero(hero_name: String, pos: Vector3, accent: Color, outfit: Color, scale_factor: float) -> void:
	var root := Node3D.new()
	root.name = hero_name
	root.position = pos
	root.scale = Vector3.ONE * scale_factor
	hero_root.add_child(root)
	hero_nodes.append(root)
	var torso := MeshInstance3D.new()
	var body_mesh := CapsuleMesh.new()
	body_mesh.radius = 0.48
	body_mesh.height = 1.55
	torso.mesh = body_mesh
	torso.position.y = 1.55
	torso.material_override = _material(outfit)
	root.add_child(torso)
	var head := MeshInstance3D.new()
	var head_mesh := SphereMesh.new()
	head_mesh.radius = 0.34
	head_mesh.height = 0.68
	head.mesh = head_mesh
	head.position.y = 2.55
	head.material_override = _material(Color(0.66, 0.46, 0.34))
	root.add_child(head)
	_box(root, Vector3(0, 2.05, -0.03), Vector3(0.9, 0.18, 0.55), accent, 0.12)
	for side in [-1.0, 1.0]:
		var arm := MeshInstance3D.new()
		var arm_mesh := CapsuleMesh.new()
		arm_mesh.radius = 0.15
		arm_mesh.height = 1.0
		arm.mesh = arm_mesh
		arm.position = Vector3(side * 0.58, 1.52, 0)
		arm.rotation.z = side * -0.12
		arm.material_override = _material(outfit)
		root.add_child(arm)
		var leg := MeshInstance3D.new()
		var leg_mesh := CapsuleMesh.new()
		leg_mesh.radius = 0.19
		leg_mesh.height = 0.95
		leg.mesh = leg_mesh
		leg.position = Vector3(side * 0.23, 0.48, 0)
		leg.material_override = _material(Color(0.07, 0.08, 0.10))
		root.add_child(leg)
	var name_tag := Label3D.new()
	name_tag.text = hero_name
	name_tag.position.y = 3.15
	name_tag.font_size = 30
	name_tag.modulate = Color(0.9, 0.95, 1.0)
	root.add_child(name_tag)

func _panel(parent: Control, rect: Rect2, color := DARK) -> Panel:
	var p := Panel.new()
	p.position = rect.position
	p.size = rect.size
	var style := StyleBoxFlat.new()
	style.bg_color = color
	style.border_color = Color(0.35, 0.55, 0.68, 0.8)
	style.set_border_width_all(1)
	style.set_corner_radius_all(8)
	p.add_theme_stylebox_override("panel", style)
	parent.add_child(p)
	return p

func _label(parent: Control, text_value: String, pos: Vector2, size: Vector2, font_size := 20, color := Color.WHITE) -> Label:
	var l := Label.new()
	l.text = text_value
	l.position = pos
	l.size = size
	l.add_theme_font_size_override("font_size", font_size)
	l.add_theme_color_override("font_color", color)
	l.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	parent.add_child(l)
	return l

func _button(parent: Control, text_value: String, rect: Rect2, callback: Callable, primary := false) -> Button:
	var b := Button.new()
	b.text = text_value
	b.position = rect.position
	b.size = rect.size
	b.add_theme_font_size_override("font_size", 17 if not primary else 24)
	var style := StyleBoxFlat.new()
	style.bg_color = GOLD if primary else Color(0.025, 0.07, 0.12, 0.94)
	style.border_color = Color(1.0, 0.86, 0.38) if primary else Color(0.16, 0.55, 0.75)
	style.set_border_width_all(2)
	style.set_corner_radius_all(7)
	b.add_theme_stylebox_override("normal", style)
	var hover := style.duplicate()
	hover.bg_color = Color(1.0, 0.82, 0.28) if primary else Color(0.06, 0.18, 0.28)
	b.add_theme_stylebox_override("hover", hover)
	b.add_theme_color_override("font_color", Color(0.05, 0.07, 0.09) if primary else Color.WHITE)
	b.pressed.connect(callback)
	parent.add_child(b)
	return b

func _build_interface() -> void:
	var layer := CanvasLayer.new()
	layer.layer = 5
	add_child(layer)
	var ui := Control.new()
	ui.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	layer.add_child(ui)
	_panel(ui, Rect2(12, 10, 510, 66))
	_label(ui, "YOSHRUN", Vector2(28, 12), Vector2(190, 32), 27, GOLD)
	_label(ui, "PLAYER  |  LV. 01", Vector2(30, 43), Vector2(220, 22), 14)
	_label(ui, "●  0 COINS      ◆  0 GEMS", Vector2(300, 22), Vector2(215, 32), 17, Color(0.95, 0.88, 0.58))
	_panel(ui, Rect2(12, 100, 190, 480))
	var nav := ["CHARACTERS", "STORE", "WEAPONS", "INVENTORY", "SUMMONS", "MISSIONS", "EVENTS"]
	for i in range(nav.size()):
		var item: String = nav[i]
		_button(ui, item, Rect2(22, 112 + i * 62, 170, 48), func(): _open_tab(item))
	_panel(ui, Rect2(1030, 96, 238, 212))
	_label(ui, "SELECT GAME MODE", Vector2(1044, 104), Vector2(210, 32), 17, GOLD)
	_button(ui, "MAZE ROYALE", Rect2(1044, 144, 210, 58), func(): _select_mode("MAZE ROYALE"))
	_button(ui, "MAZE CLASH  5v5", Rect2(1044, 220, 210, 58), func(): _select_mode("MAZE CLASH"))
	_panel(ui, Rect2(1030, 326, 238, 100))
	mode_label = _label(ui, selected_mode, Vector2(1044, 336), Vector2(210, 30), 18, GOLD)
	info_label = _label(ui, "SURVIVE. FIND THE EXIT.", Vector2(1044, 370), Vector2(210, 42), 13)
	_button(ui, "PLAY NOW  ▶", Rect2(1010, 610, 258, 86), _on_play_pressed, true)
	_panel(ui, Rect2(240, 650, 540, 48))
	_label(ui, "YOSHA STUDIOS     ESCAPE OR BE HUNTED", Vector2(255, 654), Vector2(510, 38), 15, Color(0.75, 0.85, 0.92))
	_label(ui, "GLOBAL VISION  •  MOBILE FIRST", Vector2(840, 665), Vector2(250, 28), 12, Color(0.7, 0.82, 0.9))

func _select_mode(mode_name: String) -> void:
	selected_mode = mode_name
	mode_label.text = mode_name
	info_label.text = "50 PLAYER SURVIVAL" if mode_name == "MAZE ROYALE" else "5 RUNNERS VS 5 HUNTERS"
	
func _open_tab(tab_name: String) -> void:
	selected_tab = tab_name
	info_label.text = tab_name + "  •  COMING ONLINE"
	mode_label.text = "YOSHRUN HUB"

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/maze.tscn")
