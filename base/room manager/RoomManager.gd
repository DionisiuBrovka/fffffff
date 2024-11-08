extends Node

var room_exits_massiv : Array[Marker3D] = []

func startRoomTree(start_node: Node3D) -> void:
	var room_res = load("res://lib/rooms/01.tscn")
	var room = room_res.instantiate()
	start_node.add_child(room)
	
	room_exits_massiv.append_array(room.doors_points)
	print(room_exits_massiv)
	
	for exit in room_exits_massiv:
		var add_room = room_res.instantiate()
		start_node.add_child(add_room)
		var offset = room.doors_points.pick_random().global_transform.origin - add_room.doors_points.pick_random().global_transform.origin
		add_room.global_transform.origin += offset
		
		print(offset)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
