# Store, saves and loads game settings in an int-style file
extends Node

const SAVE_PATH = "res://config.cfg"

var _config_file = ConfigFile.new()
var settings =  {
	
	"audio": {
		"mute": Globals.get("Settings/mute")
	},
	"debug": {
		"vector_color": Color(1.0,1.0,0.0),
		"area_color": Color(0.0,1.0,0.2,0.5)
	}
}

func _ready():
	save_settings()
	load_settings()
	
func save_settings():
	for section in _settings.keys():
		for key in _settings[section].keys():
			_config_file.set_value(section, key, _settings[section][key])
			
	_config_file.save(SAVE_PATH)