gameStruct = new Game();

gameStruct.addPlayer( new Player(gameStruct, 0));
gameStruct.addPlayer(new HumanPlayer(gameStruct, 1));

gameStruct.start();