extends Node
class_name ServerNode

var tcp_server: TCPServer

var peers := {}

var rng := RandomNumberGenerator.new()

func _ready() -> void:
	rng.randomize()

func create_tcp_server() -> void:
	tcp_server = TCPServer.new()
	%Client.create_tcp_client()
	
	tcp_server.listen(8888)
	print_debug("Server created")
	

func update_connection() -> void:
	if tcp_server.is_connection_available():
		var peer: StreamPeerTCP = tcp_server.take_connection()
		
		if peers.is_empty():
			peers[1] = peer
		
		if peers.find_key(peer) == null:
			var peer_id := rng.randi() % 1000000
			peers[peer_id] = peer
			
			peer.put_var({
				"type": Network.PacketType.SEND_ID,
				"content": {
					"id": peer_id
				}
			})

func _process(_delta: float) -> void:
	if tcp_server:
		update_connection()
