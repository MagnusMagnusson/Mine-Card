enum WORLDS {
	OVERWORLD,
	MINE,
	DEEPMINE,
	NETHER,
	END
}


enum ICONS_RESOURCE{
	WOOD = 4,
	ATTACK = 3,
	STONE = 2,
	IRON = 1,
	DIAMOND = 0,
}

function iconGet(resource){
	switch(resource){
		case "wood" : return ICONS_RESOURCE.WOOD;
		case "stone" : return ICONS_RESOURCE.STONE;
		case "iron" : return ICONS_RESOURCE.IRON;
		case "diamond": return ICONS_RESOURCE.DIAMOND;
		case "attack": return ICONS_RESOURCE.ATTACK;
	}
	return ICONS_RESOURCE.WOOD;
}