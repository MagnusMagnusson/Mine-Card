enum WORLDS {
	OVERWORLD,
	MINE,
	DEEPMINE,
	NETHER,
	END
}


enum ICONS_RESOURCE{
	WOOD = 6,
	ATTACK = 5,
	STONE = 4,
	LEATHER = 3,
	IRON = 2,
	HEART = 1,
	DIAMOND = 0,
}

function iconGet(resource){
	switch(resource){
		case "wood" : return ICONS_RESOURCE.WOOD;
		case "stone" : return ICONS_RESOURCE.STONE;
		case "iron" : return ICONS_RESOURCE.IRON;
		case "diamond": return ICONS_RESOURCE.DIAMOND;
		case "attack": return ICONS_RESOURCE.ATTACK;
		case "leather": return ICONS_RESOURCE.LEATHER;
	}
	return ICONS_RESOURCE.WOOD;
}

enum CARDSTATES {
	VOID,
	STORE,
	DISCARD,
	DECK,
	HAND,
	FIELD
}