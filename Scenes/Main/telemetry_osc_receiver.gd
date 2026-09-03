extends Node

@onready var player: Player = get_parent().get_node("Player")

func _ready() -> void:
	var osc_server := get_node("../TelemetryOSCServer") as OSCServer
	if osc_server:
		osc_server.message_received.connect(_on_osc_message_received)
	else:
		push_error("Telemetry OSC server node was not found")

func _on_osc_message_received(address: String, values, _time: String) -> void:
	var event_name := ""
	match address:
		"/player/musicking":
			event_name = "musicking"
		"/player/sonification":
			event_name = "sonification"
		_:
			return

	var value_text := ""
	if values is Array:
		value_text = str(values)
	else:
		value_text = str(values)

	player.log_external_telemetry_event(event_name, value_text)
	print("Telemetry OSC received: ", address, " ", value_text)
