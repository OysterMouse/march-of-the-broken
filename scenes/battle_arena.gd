@tool
class_name BattleArena
extends Node2D

@onready var label: Label = $BottomUI/UI/Character/Control/Name/Label
@onready var character_portrait: TextureRect = $BottomUI/UI/Character/Control/Portrait/CharacterPortrait

func _on_warrior_mouse_entered():
	var warrior = $Warrior as Unit
	if warrior and warrior.unit_data:
		label.text = warrior.unit_data.unit_name
		character_portrait.texture = warrior.unit_data.icon
	else:
		label.text = "Unknown Unit"

func _on_crusader_mouse_entered():
	var crusader = $Crusader as Unit
	if crusader and crusader.unit_data:
		label.text = crusader.unit_data.unit_name
		character_portrait.texture = crusader.unit_data.icon
	else:
		label.text = "Unknown Unit"

func _on_warrior_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		_on_warrior_mouse_entered()


func _on_crusader_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		_on_crusader_mouse_entered()



func _on_monk_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		var monk = $Monk as Unit
		if monk and monk.unit_data:
			label.text = monk.unit_data.unit_name
			character_portrait.texture = monk.unit_data.icon
			if monk.unit_data.flip_icon:
				character_portrait.flip_h = true
		else:
			label.text = "Unknown Unit"


func _on_paladin_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		var paladin = $Paladin as Unit
		if paladin and paladin.unit_data:
			label.text = paladin.unit_data.unit_name
			character_portrait.texture = paladin.unit_data.icon
			if paladin.unit_data.flip_icon:
				character_portrait.flip_h = true
		else:
			label.text = "Unknown Unit"
