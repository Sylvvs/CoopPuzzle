extends Node

const ICON_PATH = "res://upgrades/upgrade_images/"

const UPGRADES = {
	"magictome1": {
		"displayname": "Magic Tome",
		"details": "This magic tome lets you shoot more often",
		"level": "Level 1",
		"prerequisite": [],
	},
	"magictome2": {
		"displayname": "Magic Tome",
		"details": "This magic tome lets you shoot more often",
		"level": "Level 2",
		"prerequisite": ["magictome1"],
	},
	"food": {
		"displayname": "Food",
		"details": "This food will heal you",
		"level": "N/A",
		"prerequisite": [],
	}
}
