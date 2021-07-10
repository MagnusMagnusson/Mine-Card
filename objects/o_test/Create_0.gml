randomize();
Database();
gameStruct = new Game();

gameStruct.addPlayer(new ComputerPlayer(gameStruct, 0));
gameStruct.addPlayer(new HumanPlayer(gameStruct, 1));
gameStruct.setup();
gameStruct.start();
