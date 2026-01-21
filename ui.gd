extends Control
# Darkest Dungeon-style UI
var is_player_turn = true

func _ready():
	setup_ui_layout()
	update_character_stats()

func setup_ui_layout():
	# Set the control to fill the screen
	anchor_left = 0
	anchor_top = 0
	anchor_right = 1
	anchor_bottom = 1
	
	# Top Panel - Character/Party Status
	var top_panel = Panel.new()
	top_panel.set_anchors_preset(Control.PRESET_TOP_WIDE)
	top_panel.custom_minimum_size = Vector2(0, 120)
	top_panel.modulate = Color(0.1, 0.08, 0.12, 0.9)
	add_child(top_panel)
	
	# Add character names and health bars
	var char_container = HBoxContainer.new()
	char_container.anchor_left = 0.05
	char_container.anchor_top = 0.01
	char_container.anchor_right = 0.95
	char_container.anchor_bottom = 0.12
	char_container.alignment = BoxContainer.ALIGNMENT_CENTER
	char_container.add_theme_constant_override("separation", 30)
	add_child(char_container)
	
	# Character status slots
	for i in range(4):
		var char_slot = create_character_slot("Hero %d" % (i+1), 80, 50 - (i * 10))
		char_container.add_child(char_slot)
	
	# Left Panel - Actions/Abilities
	var left_panel = Panel.new()
	left_panel.set_anchors_preset(Control.PRESET_LEFT_WIDE)
	left_panel.anchor_right = 0.15
	left_panel.modulate = Color(0.12, 0.1, 0.15, 0.85)
	add_child(left_panel)
	
	var left_label = Label.new()
	left_label.text = "EFFECTS"
	left_label.anchor_left = 0.02
	left_label.anchor_top = 0.02
	left_label.anchor_right = 0.98
	left_label.custom_minimum_size = Vector2(0, 30)
	left_label.add_theme_font_size_override("font_size", 16)
	add_theme_color_override("font_color", Color(0.8, 0.7, 0.5))
	add_child(left_label)
	
	# Right Panel - Enemies
	var right_panel = Panel.new()
	right_panel.set_anchors_preset(Control.PRESET_RIGHT_WIDE)
	right_panel.anchor_left = 0.85
	right_panel.modulate = Color(0.15, 0.1, 0.1, 0.85)
	add_child(right_panel)
	
	var right_label = Label.new()
	right_label.text = "ENEMIES"
	right_label.anchor_left = 0.85
	right_label.anchor_top = 0.02
	right_label.anchor_right = 0.98
	right_label.custom_minimum_size = Vector2(0, 30)
	right_label.add_theme_font_size_override("font_size", 16)
	right_label.add_theme_color_override("font_color", Color(0.8, 0.2, 0.2))
	add_child(right_label)
	
	# Create enemy slots
	var enemy_container = VBoxContainer.new()
	enemy_container.anchor_left = 0.86
	enemy_container.anchor_top = 0.08
	enemy_container.anchor_right = 0.99
	enemy_container.anchor_bottom = 0.85
	enemy_container.add_theme_constant_override("separation", 15)
	add_child(enemy_container)
	
	for i in range(3):
		var enemy_slot = create_enemy_slot("Enemy %d" % (i+1), 100 - (i * 15))
		enemy_container.add_child(enemy_slot)
	
	# Bottom Panel - Action Buttons
	var bottom_panel = Panel.new()
	bottom_panel.set_anchors_preset(Control.PRESET_BOTTOM_WIDE)
	bottom_panel.custom_minimum_size = Vector2(0, 140)
	bottom_panel.modulate = Color(0.1, 0.08, 0.12, 0.95)
	add_child(bottom_panel)
	
	# Action buttons container
	var button_container = GridContainer.new()
	button_container.anchor_left = 0.15
	button_container.anchor_top = 0.84
	button_container.anchor_right = 0.85
	button_container.anchor_bottom = 1.0
	button_container.columns = 4
	button_container.add_theme_constant_override("h_separation", 10)
	button_container.add_theme_constant_override("v_separation", 10)
	add_child(button_container)
	
	var actions = ["ATTACK", "DEFEND", "SKILL", "ITEM"]
	for action in actions:
		var action_btn = create_action_button(action)
		button_container.add_child(action_btn)
	
	# Center Info Panel
	var info_panel = Panel.new()
	info_panel.anchor_left = 0.15
	info_panel.anchor_top = 0.12
	info_panel.anchor_right = 0.85
	info_panel.anchor_bottom = 0.84
	info_panel.modulate = Color(0.08, 0.08, 0.1, 0.7)
	add_child(info_panel)
	
	var turn_label = Label.new()
	turn_label.text = "YOUR TURN"
	turn_label.anchor_left = 0.4
	turn_label.anchor_top = 0.4
	turn_label.anchor_right = 0.6
	turn_label.anchor_bottom = 0.6
	turn_label.add_theme_font_size_override("font_size", 32)
	turn_label.add_theme_color_override("font_color", Color(0.8, 0.6, 0.3))
	add_child(turn_label)

func create_character_slot(name: String, hp: int, stress: int) -> VBoxContainer:
	var slot = VBoxContainer.new()
	slot.custom_minimum_size = Vector2(120, 110)
	
	var bg = Panel.new()
	bg.modulate = Color(0.2, 0.15, 0.25, 0.8)
	slot.add_child(bg)
	
	var name_label = Label.new()
	name_label.text = name
	name_label.add_theme_font_size_override("font_size", 12)
	name_label.add_theme_color_override("font_color", Color(0.9, 0.8, 0.6))
	slot.add_child(name_label)
	
	# HP Bar
	var hp_container = VBoxContainer.new()
	var hp_label = Label.new()
	hp_label.text = "HP: %d" % hp
	hp_label.add_theme_font_size_override("font_size", 10)
	hp_label.add_theme_color_override("font_color", Color(0.7, 0.7, 0.7))
	hp_container.add_child(hp_label)
	
	var hp_bar = ProgressBar.new()
	hp_bar.value = hp
	hp_bar.max_value = 100
	hp_bar.custom_minimum_size = Vector2(100, 8)
	hp_bar.modulate = Color(0.8, 0.2, 0.2, 0.9)
	hp_container.add_child(hp_bar)
	slot.add_child(hp_container)
	
	# Stress Bar
	var stress_label = Label.new()
	stress_label.text = "STR: %d" % stress
	stress_label.add_theme_font_size_override("font_size", 10)
	stress_label.add_theme_color_override("font_color", Color(0.7, 0.7, 0.7))
	slot.add_child(stress_label)
	
	var stress_bar = ProgressBar.new()
	stress_bar.value = stress
	stress_bar.max_value = 100
	stress_bar.custom_minimum_size = Vector2(100, 8)
	stress_bar.modulate = Color(0.8, 0.6, 0.2, 0.9)
	slot.add_child(stress_bar)
	
	return slot

func create_enemy_slot(name: String, hp: int) -> VBoxContainer:
	var slot = VBoxContainer.new()
	
	var name_label = Label.new()
	name_label.text = name
	name_label.add_theme_font_size_override("font_size", 11)
	name_label.add_theme_color_override("font_color", Color(0.9, 0.4, 0.4))
	slot.add_child(name_label)
	
	var hp_bar = ProgressBar.new()
	hp_bar.value = hp
	hp_bar.max_value = 100
	hp_bar.custom_minimum_size = Vector2(80, 12)
	hp_bar.modulate = Color(0.9, 0.2, 0.2, 0.9)
	slot.add_child(hp_bar)
	
	return slot

func create_action_button(label: String) -> Button:
	var btn = Button.new()
	btn.text = label
	btn.custom_minimum_size = Vector2(140, 45)
	btn.add_theme_font_size_override("font_size", 14)
	btn.add_theme_color_override("font_color", Color(0.8, 0.7, 0.5))
	btn.modulate = Color(0.3, 0.25, 0.35, 0.9)
	btn.pressed.connect(_on_action_pressed.bind(label))
	
	return btn

func update_character_stats():
	# Update character information
	pass

func _on_action_pressed(action: String):
	print("Action pressed: ", action)
	# Handle action logic here
	pass