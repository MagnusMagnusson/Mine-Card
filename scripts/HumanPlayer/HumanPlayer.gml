function HumanPlayer(gameStruct, position ) :  Player(gameStruct, position) constructor {

	isHuman = true;

	static play = function(){
		isPlaying = true;
	}

}