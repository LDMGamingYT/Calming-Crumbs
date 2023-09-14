extends Node

var config = ConfigFile.new()
var configPath = "user://save.ini"

func _ready():
	config.save_encrypted_pass(configPath, "calmingcrumbs")
	config.load_encrypted_pass(configPath, "calmingcrumbs")

func saveValue(section, key, value):
	config.set_value(section, key, value)
	config.save_encrypted_pass(configPath, "calmingcrumbs")

func getValue(section, key, default):
	return config.get_value(section, key, default)
