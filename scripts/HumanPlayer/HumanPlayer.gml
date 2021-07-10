function HumanPlayer(gameStruct, position ) :  Player(gameStruct, position) constructor {

	isHuman = true;

	if(instance_exists(o_endTurn)){
		
		o_endTurn.player = self;
		o_endTurn.func = function(){
			if(o_endTurn.player.isHuman && o_endTurn.player.isPlaying){
				o_endTurn.player.game.endTurn();
			}
		}
	}

	static play = function(){
		isPlaying = true;
	}

}