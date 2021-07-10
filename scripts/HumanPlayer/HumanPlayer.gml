function HumanPlayer(gameStruct, position ) :  Player(gameStruct, position) constructor {

	isHuman = true;

	static play = function(){
		show_message("HOOMAN IS PLAYING!");
	}

}