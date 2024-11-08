extends Node

var base_build_node : Node3D
var rooms : Dictionary = {}
var cur_room : Room

func create_room() -> Room:
	var room_res = load("res://lib/rooms/01.tscn")
	return room_res.instantiate()

func add_room(room: Room) -> void:
	if room.bid not in rooms:
		rooms[room.bid] = room

func add_edge(base_room: Room, addable_room: Room) -> void:
	add_room(base_room)
	add_room(addable_room)
	
	rooms[base_room.bid].next_rooms.append(addable_room)
	rooms[addable_room.bid].next_rooms.append(base_room)

func start_room_tree(build_node: Node3D) -> void:
	
	var seed_room = create_room()
	add_room(seed_room)
	
	cur_room = seed_room
	
	base_build_node = build_node
	base_build_node.add_child(seed_room)
	groow_rooms()
	
	#var a = create_room()
	#var b = create_room()
	#var c = create_room()
	#var d = create_room()
	#place_room(a, seed_room.doors_points[0], a.doors_points[0])
	#place_room(b, seed_room.doors_points[0], a.doors_points[1])
	#place_room(c, seed_room.doors_points[1], a.doors_points[0])
	#place_room(d, seed_room.doors_points[1], a.doors_points[1])
	#



func place_room(room: Room, base_door: Marker3D, connect_door: Marker3D):
	# Загружаем глобальные трансформации дверей
	base_build_node.add_child(room)
	
	room.transform.rotated(Vector3.UP, deg_to_rad(180) - connect_door.rotation.y)

	#room.look_at_from_position(connect_door.global_position, base_door.global_position, Vector3.UP)
	
	## Добавляем комнату в сцену
	var offset = base_door.global_position - connect_door.global_position
	room.global_position += offset

	print("Комната добавлена: %s на основе двери %s" % [room.bid, base_door])

func connect_room(room: Room,door: Marker3D):
	var new_room = create_room()
	add_edge(room, new_room)
	
	room.next_rooms.append(new_room)
	new_room.next_rooms.append(room)
	
	var select_room_door = room.doors_points.pick_random()
	var select_new_room_door = new_room.doors_points.pick_random()
	
	place_room(new_room, select_room_door, select_new_room_door)

func groow_rooms() -> void:
	var groow_rooms = rooms.duplicate()
	print(groow_rooms)
	for room_key in groow_rooms:
		print(groow_rooms)
		var room = groow_rooms[room_key]
		print("Найдена комната для расширения : %s" % room.bid)
		print("Найдены двери : %s" % len(room.doors_points))
		if len(room.next_rooms) != len(room.doors_points):
			print("Найдены свободные двери")
			for door in room.doors_points:
				if door not in room.close_dors:
					connect_room(room, door)

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass
