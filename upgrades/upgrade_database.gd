extends Node

const ICON_PATH = "res://upgrades/upgrade_images/"

const UPGRADES = {
	"magictome1": {
		"displayname": "Magic Tome",
		"details": "This magic tome lets you shoot more often",
		"level": "Level 1",
		"prerequisite": [],
		"type": "passive"
	},
	"magictome2": {
		"displayname": "Magic Tome",
		"details": "This magic tome lets you shoot more often",
		"level": "Level 2",
		"prerequisite": ["magictome1"],
		"type": "passive"
	},
	"magictome3": {
		"displayname": "Magic Tome",
		"details": "This magic tome lets you shoot more often",
		"level": "Level 3",
		"prerequisite": ["magictome2"],
		"type": "passive"
	},
	"magictome4": {
		"displayname": "Magic Tome",
		"details": "This magic tome lets you shoot more often",
		"level": "Level 4",
		"prerequisite": ["magictome3"],
		"type": "passive"
	},
	"magictome5": {
		"displayname": "Magic Tome",
		"details": "This magic tome lets you shoot more often",
		"level": "Level 5",
		"prerequisite": ["magictome4"],
		"type": "passive"
	},
	"health1": {
		"displayname": "Can of beans",
		"details": "The beans give you more max hp",
		"level": "Level 1",
		"prerequisite": [],
		"type": "passive"
	},
	"health2": {
		"displayname": "Can of beans",
		"details": "The beans give you more max hp",
		"level": "Level 2",
		"prerequisite": ["health1"],
		"type": "passive"
	},
	"health3": {
		"displayname": "Can of beans",
		"details": "The beans give you more max hp",
		"level": "Level 3",
		"prerequisite": ["health2"],
		"type": "passive"
	},
	"health4": {
		"displayname": "Can of beans",
		"details": "The beans give you more max hp",
		"level": "Level 4",
		"prerequisite": ["health3"],
		"type": "passive"
	},
	"health5": {
		"displayname": "Can of beans",
		"details": "The beans give you more max hp",
		"level": "Level 5",
		"prerequisite": ["health4"],
		"type": "passive"
	},
	"speed1": {
		"displayname": "Wings",
		"details": "These wings make you faster",
		"level": "Level 1",
		"prerequisite": [],
		"type": "passive"
	},
	"speed2": {
		"displayname": "Wings",
		"details": "These wings make you faster",
		"level": "Level 2",
		"prerequisite": ["speed1"],
		"type": "passive"
	},
	"speed3": {
		"displayname": "Wings",
		"details": "These wings make you faster",
		"level": "Level 3",
		"prerequisite": ["speed2"],
		"type": "passive"
	},
	"speed4": {
		"displayname": "Wings",
		"details": "These wings make you faster",
		"level": "Level 4",
		"prerequisite": ["speed3"],
		"type": "passive"
	},
	"speed5": {
		"displayname": "Wings",
		"details": "These wings make you faster",
		"level": "Level 5",
		"prerequisite": ["speed4"],
		"type": "passive"
	},
	"armor1": {
		"displayname": "Armor",
		"details": "With this armor you take less damage",
		"level": "Level 1",
		"prerequisite": [],
		"type": "passive"
	},
	"armor2": {
		"displayname": "Armor",
		"details": "With this armor you take less damage",
		"level": "Level 2",
		"prerequisite": ["armor1"],
		"type": "passive"
	},
	"armor3": {
		"displayname": "Armor",
		"details": "With this armor you take less damage",
		"level": "Level 3",
		"prerequisite": ["armor2"],
		"type": "passive"
	},
	"armor4": {
		"displayname": "Armor",
		"details": "With this armor you take less damage",
		"level": "Level 4",
		"prerequisite": ["armor3"],
		"type": "passive"
	},
	"armor5": {
		"displayname": "Armor",
		"details": "With this armor you take less damage",
		"level": "Level 5",
		"prerequisite": ["armor4"],
		"type": "passive"
	},
	"damage1": {
		"displayname": "Arming",
		"details": "You get more damage",
		"level": "Level 1",
		"prerequisite": [],
		"type": "passive"
	},
	"damage2": {
		"displayname": "Arming",
		"details": "You get more damage",
		"level": "Level 2",
		"prerequisite": ["damage1"],
		"type": "passive"
	},
	"damage3": {
		"displayname": "Arming",
		"details": "You get more damage",
		"level": "Level 3",
		"prerequisite": ["damage2"],
		"type": "passive"
	},
	"damage4": {
		"displayname": "Arming",
		"details": "You get more damage",
		"level": "Level 4",
		"prerequisite": ["damage3"],
		"type": "passive"
	},
	"damage5": {
		"displayname": "Arming",
		"details": "You get more damage",
		"level": "Level 5",
		"prerequisite": ["damage5"],
		"type": "passive"
	},
	"food": {
		"displayname": "Food",
		"details": "This food will heal you",
		"level": "",
		"prerequisite": [],
		"type": "item"
	}
}
