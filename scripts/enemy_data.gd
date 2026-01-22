class_name EnemyData
extends Resource

@export var enemy_name: String = "New Enemy"
@export var health: int = 100
@export var damage: int = 10
@export var defense: int = 5
@export var speed: float = 1.0
@export var abilities: Array[String] = []
@export var description: String = "A new enemy."
@export var icon: Texture2D
@export var flip_icon: bool = false