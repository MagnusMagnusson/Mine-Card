enum WORLDS {
	OVERWORLD,
	MINE,
	DEEPMINE,
	NETHER,
	END
}


enum ICONS_RESOURCE{
	WOOD = 7,
	ATTACK = 6,
	STONE = 5,
	LEATHER = 4,
	IRON = 3,
	HEART = 2,
	ENDERPEARL = 1,
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
		case "endpearl": return ICONS_RESOURCE.ENDERPEARL;
		case "hearts": return ICONS_RESOURCE.HEART;
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