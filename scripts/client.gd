extends Node
class_name ClientNode

var tcp_client: StreamPeerTCP

func create_tcp_client() -> void:
	tcp_client = StreamPeerTCP.new()
	
	print_debug("Client created")
	
	var err := tcp_client.connect_to_host("localhost", 8888)
	
	if err == OK:
		print_debug("Client connected to server")
	else:
		printerr("Connecting error: ", err)
	
	tcp_client.poll()

func process_data() -> void:
	if tcp_client.get_available_bytes():
		var packed: Dictionary = tcp_client.get_var()
		
		if packed.type == Network.PacketType.SEND_ID:
			Network.multiplayer_id = packed.content.id
			print(Network.multiplayer_id)

func _process(_delta: float) -> void:
	if tcp_client and tcp_client.poll() == OK:
		process_data()
