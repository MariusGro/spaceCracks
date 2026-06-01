extends HSlider

@export var audio_bus_name: String = "Master"

var audio_bus_id

func _ready() -> void:
	audio_bus_id = AudioServer.get_bus_index(audio_bus_name)


## Since HSlider already has the property 'value' I had to rename it.
func _on_value_changed(new_value: float) -> void:
	var db = linear_to_db(new_value)
	AudioServer.set_bus_volume_db(audio_bus_id, db)
