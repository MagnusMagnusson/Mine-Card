function HumanPlayer(gameStruct, position ) :  Player(gameStruct, position) constructor {

	isHuman = true;
	var me = self;
	with(o_button){
		player = me;
	}

	static play = function(){
		isPlaying = true;
	}

}