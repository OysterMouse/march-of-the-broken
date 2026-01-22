@tool
class_name BattleArena
extends Node2D

@onready var label: Label = $BottomUI/UI/Character/Control/Name/Label
@onready var character_portrait: TextureRect = $BottomUI/UI/Character/Control/Portrait/CharacterPortrait
@onready var health_label: Label = $BottomUI/UI/Character/Control/Stats/Health/Label
@onready var defense_label: Label = $BottomUI/UI/Character/Control/Stats/Defense/Label
@onready var damage_label: Label = $BottomUI/UI/Character/Control/Stats/Damage/Label

var units: Array[Unit] = []

func _ready():
	# Collect all Unit children and connect their signals
	for child in get_children():
		if child is Unit:
			units.append(child)
			# Connect input event signal to handle unit selection
			if child.input_event.is_connected(_on_unit_selected):
				child.input_event.disconnect(_on_unit_selected)
			child.input_event.connect(_on_unit_selected.bindv([child]))

func _on_unit_selected(viewport: Node, event: InputEvent, shape_idx: int, unit: Unit) -> void:
	if event is InputEventMouseButton and event.pressed:
		update_ui_for_unit(unit)

func update_ui_for_unit(unit: Unit) -> void:
	if unit and unit.unit_data:
		label.text = unit.unit_data.unit_name
		character_portrait.texture = unit.unit_data.icon
		character_portrait.flip_h = unit.unit_data.flip_icon if unit.unit_data.has_meta("flip_icon") else false
		
		# Update stats labels
		health_label.text = "%d/%d" % [unit.unit_data.health, unit.unit_data.health]
		defense_label.text = str(unit.unit_data.defense)
		damage_label.text = str(unit.unit_data.damage)
	else:
		label.text = "Unknown Unit"
		health_label.text = "0/0"
		defense_label.text = "0"
		damage_label.text = "0"
