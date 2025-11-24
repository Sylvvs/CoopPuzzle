extends Node

const ICON_PATH = "res://sprites/Upgrade Sprites/"

const UPGRADES = {
	"magictome1": {
		"displayname": "Magic Tome",
		"details": "This magic tome lets you shoot more often",
		"level": "Level 1",
		"prerequisite": [],
		"type": "passive",
		"icon": ICON_PATH + "magictome.png"
	},
	"magictome2": {
		"displayname": "Magic Tome",
		"details": "This magic tome lets you shoot more often",
		"level": "Level 2",
		"prerequisite": ["magictome1"],
		"type": "passive",
		"icon": ICON_PATH + "magictome.png"
	},
	"magictome3": {
		"displayname": "Magic Tome",
		"details": "This magic tome lets you shoot more often",
		"level": "Level 3",
		"prerequisite": ["magictome2"],
		"type": "passive",
		"icon": ICON_PATH + "magictome.png"
	},
	"magictome4": {
		"displayname": "Magic Tome",
		"details": "This magic tome lets you shoot more often",
		"level": "Level 4",
		"prerequisite": ["magictome3"],
		"type": "passive",
		"icon": ICON_PATH + "magictome.png"
	},
	"magictome5": {
		"displayname": "Magic Tome",
		"details": "This magic tome lets you shoot more often",
		"level": "Level 5",
		"prerequisite": ["magictome4"],
		"type": "passive",
		"icon": ICON_PATH + "magictome.png"
	},
	"health1": {
		"displayname": "Heart",
		"details": "Your heart becomes bigger allowing you more max hp",
		"level": "Level 1",
		"prerequisite": [],
		"type": "passive",
		"icon": ICON_PATH + "health.png"
	},
	"health2": {
		"displayname": "Heart",
		"details": "Your heart becomes bigger allowing you more max hp",
		"level": "Level 2",
		"prerequisite": ["health1"],
		"type": "passive",
		"icon": ICON_PATH + "health.png"
	},
	"health3": {
		"displayname": "Heart",
		"details": "Your heart becomes bigger allowing you more max hp",
		"level": "Level 3",
		"prerequisite": ["health2"],
		"type": "passive",
		"icon": ICON_PATH + "health.png"
	},
	"health4": {
		"displayname": "Heart",
		"details": "Your heart becomes bigger allowing you more max hp",
		"level": "Level 4",
		"prerequisite": ["health3"],
		"type": "passive",
		"icon": ICON_PATH + "health.png"
	},
	"health5": {
		"displayname": "Heart",
		"details": "Your heart becomes bigger allowing you more max hp",
		"level": "Level 5",
		"prerequisite": ["health4"],
		"type": "passive",
		"icon": ICON_PATH + "health.png"
	},
	"speed1": {
		"displayname": "Speed",
		"details": "You become faster",
		"level": "Level 1",
		"prerequisite": [],
		"type": "passive",
		"icon": ICON_PATH + "speed.png"
	},
	"speed2": {
		"displayname": "Speed",
		"details": "You become faster",
		"level": "Level 2",
		"prerequisite": ["speed1"],
		"type": "passive",
		"icon": ICON_PATH + "speed.png"
	},
	"speed3": {
		"displayname": "Speed",
		"details": "You become faster",
		"level": "Level 3",
		"prerequisite": ["speed2"],
		"type": "passive",
		"icon": ICON_PATH + "speed.png"
	},
	"speed4": {
		"displayname": "Speed",
		"details": "You become faster",
		"level": "Level 4",
		"prerequisite": ["speed3"],
		"type": "passive",
		"icon": ICON_PATH + "speed.png"
	},
	"speed5": {
		"displayname": "Speed",
		"details": "You become faster",
		"level": "Level 5",
		"prerequisite": ["speed4"],
		"type": "passive",
		"icon": ICON_PATH + "speed.png"
	},
	"armor1": {
		"displayname": "Armor",
		"details": "With this armor you take less damage",
		"level": "Level 1",
		"prerequisite": [],
		"type": "passive",
		"icon": ICON_PATH + "armor.png"
	},
	"armor2": {
		"displayname": "Armor",
		"details": "With this armor you take less damage",
		"level": "Level 2",
		"prerequisite": ["armor1"],
		"type": "passive",
		"icon": ICON_PATH + "armor.png"
	},
	"armor3": {
		"displayname": "Armor",
		"details": "With this armor you take less damage",
		"level": "Level 3",
		"prerequisite": ["armor2"],
		"type": "passive",
		"icon": ICON_PATH + "armor.png"
	},
	"armor4": {
		"displayname": "Armor",
		"details": "With this armor you take less damage",
		"level": "Level 4",
		"prerequisite": ["armor3"],
		"type": "passive",
		"icon": ICON_PATH + "armor.png"
	},
	"armor5": {
		"displayname": "Armor",
		"details": "With this armor you take less damage",
		"level": "Level 5",
		"prerequisite": ["armor4"],
		"type": "passive",
		"icon": ICON_PATH + "armor.png"
	},
	"damage1": {
		"displayname": "Blood sword",
		"details": "You infuse your bullets with blood giving you more damage",
		"level": "Level 1",
		"prerequisite": [],
		"type": "passive",
		"icon": ICON_PATH + "damage.png"
	},
	"damage2": {
		"displayname": "Blood sword",
		"details": "You infuse your bullets with blood giving you more damage",
		"level": "Level 2",
		"prerequisite": ["damage1"],
		"type": "passive",
		"icon": ICON_PATH + "damage.png"
	},
	"damage3": {
		"displayname": "Blood sword",
		"details": "You infuse your bullets with blood giving you more damage",
		"level": "Level 3",
		"prerequisite": ["damage2"],
		"type": "passive",
		"icon": ICON_PATH + "damage.png"
	},
	"damage4": {
		"displayname": "Blood sword",
		"details": "You infuse your bullets with blood giving you more damage",
		"level": "Level 4",
		"prerequisite": ["damage3"],
		"type": "passive",
		"icon": ICON_PATH + "damage.png"
	},
	"damage5": {
		"displayname": "Blood sword",
		"details": "You infuse your bullets with blood giving you more damage",
		"level": "Level 5",
		"prerequisite": ["damage5"],
		"type": "passive",
		"icon": ICON_PATH + "damage.png"
	},
	"pierce1": {
		"displayname": "Pierce",
		"details": "You get one additional pierce",
		"level": "Level 1",
		"prerequisite": [],
		"type": "passive",
		"icon": ICON_PATH + "pierce.png"
	},
	"pierce2": {
		"displayname": "Pierce",
		"details": "You get one additional pierce",
		"level": "Level 2",
		"prerequisite": ["pierce1"],
		"type": "passive",
		"icon": ICON_PATH + "pierce.png"
	},
	"pierce3": {
		"displayname": "Pierce",
		"details": "You get one additional pierce",
		"level": "Level 3",
		"prerequisite": ["pierce2"],
		"type": "passive",
		"icon": ICON_PATH + "pierce.png"
	},
	"pierce4": {
		"displayname": "Pierce",
		"details": "You get one additional pierce",
		"level": "Level 4",
		"prerequisite": ["pierce3"],
		"type": "passive",
		"icon": ICON_PATH + "pierce.png"
	},
	"pierce5": {
		"displayname": "Pierce",
		"details": "You get one additional pierce",
		"level": "Level 5",
		"prerequisite": ["pierce4"],
		"type": "passive",
		"icon": ICON_PATH + "pierce.png"
	},
	"magnet1": {
		"displayname": "Black Hole",
		"details": "The black hole sucks in xp orbs from a greater range",
		"level": "Level 1",
		"prerequisite": [],
		"type": "passive",
		"icon": ICON_PATH + "black_hole.png"
	},
	"magnet2": {
		"displayname": "Black Hole",
		"details": "The black hole sucks in xp orbs from a greater range",
		"level": "Level 2",
		"prerequisite": ["magnet1"],
		"type": "passive",
		"icon": ICON_PATH + "black_hole.png"
	},
	"magnet3": {
		"displayname": "Black Hole",
		"details": "The black hole sucks in xp orbs from a greater range",
		"level": "Level 3",
		"prerequisite": ["magnet2"],
		"type": "passive",
		"icon": ICON_PATH + "black_hole.png"
	},
	"magnet4": {
		"displayname": "Black Hole",
		"details": "The black hole sucks in xp orbs from a greater range",
		"level": "Level 4",
		"prerequisite": ["magnet3"],
		"type": "passive",
		"icon": ICON_PATH + "black_hole.png"
	},
	"magnet5": {
		"displayname": "Black Hole",
		"details": "The black hole sucks in xp orbs from a greater range",
		"level": "Level 5",
		"prerequisite": ["magnet4"],
		"type": "passive",
		"icon": ICON_PATH + "black_hole.png"
	},
	"food": {
		"displayname": "Bandage",
		"details": "This bandage heals you",
		"level": "",
		"prerequisite": [],
		"type": "item",
		"icon": ICON_PATH + "food.png"
	}
}
