extends Control

const LOBY = preload("res://scenes/loby.tscn")

func _on_host_button_pressed() -> void:
	%Server.create_tcp_server()
	
	get_parent().add_child(LOBY.instantiate())
	queue_free()

func _on_join_button_pressed() -> void:
	%Client.create_tcp_client()
	
	get_parent().add_child(LOBY.instantiate())
	queue_free()
