

gameStruct = new Game();

gameStruct.addPlayer(new HumanPlayer(gameStruct, 0));
gameStruct.addPlayer(new HumanPlayer(gameStruct, 1));

gameStruct.start();

card = new Card({
	name : "name",
	text : "text",
	resources : {
		stone : 3
	},
	strength : 0,
	cost : {
		wood:2
	},
	onPlay : "draw",
}, 0);