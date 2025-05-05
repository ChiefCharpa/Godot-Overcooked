extends Node3D
var peer = ENetMultiplayerPeer.new()
@export var player_scene: PackedScene

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("Host"):
		print("host")
		hosting()
	if Input.is_action_just_pressed("Join"):
		joining()
		print("jon")

func hosting():
	peer.create_server(135)
	multiplayer.multiplayer_peer = peer
	multiplayer.peer_connected.connect(_add_player)
	_add_player()

func _add_player(id = 1):
	var player = player_scene.instantiate()
	player.name = str(id)

	# Set the spawn position for the player
	var spawn_position = Vector3(-2, 2, 3)  # Adjust this to the desired spawn location
	player.transform.origin = spawn_position

	call_deferred("add_child", player)
	
func joining():
	peer.create_client("localhost", 135)
	multiplayer.multiplayer_peer = peer
