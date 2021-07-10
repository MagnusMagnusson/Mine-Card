if(player.isHuman && player.isPlaying){
	switch(tag){
		case "endTurn": player.game.endTurn();  break;
		case "overworld" : player.travel(WORLDS.OVERWORLD); break;
		case "mine" : player.travel(WORLDS.MINE); break;
		case "deepmine" : player.travel(WORLDS.DEEPMINE); break;
		case "nether" : player.travel(WORLDS.NETHER); break;
		case "end" : player.travel(WORLDS.END); break;
		case "burn" : player.burnHand(); break;
	}
}