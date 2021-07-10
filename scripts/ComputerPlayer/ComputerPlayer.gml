function ComputerPlayer(gameStruct, position ) :  Player(gameStruct, position) constructor {

	isHuman = false;

	static play = function(){
		isPlaying = true;
		game.endTurn();
	}

}