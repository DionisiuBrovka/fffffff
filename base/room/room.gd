extends Node3D
class_name Room

@export var doors_points: Array[Marker3D]
@export var room_area: Area3D

var bid : String
var next_rooms : Array[Room] = []
var close_dors : Array[Marker3D] = []

func random_russian_letter():
	var letters = "АБВГДЕЖЗИКЛМНОПРСТУФХЦЧШЩЭЮЯ"
	return letters[randi() % letters.length()]

func generate_code():
	var part1 = random_russian_letter() + random_russian_letter() + random_russian_letter()
	var part2 = str(randi() % 100)
	var part3 = random_russian_letter() + random_russian_letter()
	var part4 = str(randi() % 1000)

	return "%s-%s-%s(%s)" % [part1, part2, part3, part4]

func _init():
	bid = generate_code()
	print("Создана комната : %s" % bid)

#==============================================================================
func _ready() -> void:
	pass 

func _process(delta: float) -> void:
	pass
