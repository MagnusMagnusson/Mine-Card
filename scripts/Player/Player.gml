function Player() constructor{
	
	hand = new Array();
	deck = new Array();
	discard = new Array();
	field = new Array();
	pos = 0;
	bank = {
		"health" : STARTINGHEALTH
	};
	game = undefined;
	
	var over, mine, deepmine, nether, ender;
	over = WORLDS.OVERWORLD;
	mine = WORLDS.MINE;
	deepmine = WORLDS.DEEPMINE;
	nether = WORLDS.NETHER;
	ender = WORLDS.END;
	
	buyDecks = {
		over : new Array(),
		mine : new Array(),
		deepmine : new Array(),
		nether : new Array(),
		ender : new Array(),
	};

	Player(game, pos){
		self.game = game;
		self.pos = pos;
	}
	
	function shuffle(){
		deck = shuffle(discard)
		discard.clear()
		if(instance_exists(o_renderer)){
			o_renderer.renderShuffle({"player":self});
		}
	}
	
	function draw(n, callback){
		if( n > 0 ){
			if(deck.size == 0){
				shuffle();
			}
			var card = deck.pop();
			hand.add(card)
			if(instance_exists(o_renderer)){
				o_renderer.adjustHand({"player":self});
			}
			draw(n - 1, callback);
		} else{
			if(callback){
				callback();
			}
		}
	}
	
	function discardCard(n, callback){
		if( n > 0 && hand.size > 0 ){
			var card = hand.pop();
			discard.add(card)
			if(instance_exists(o_renderer)){
				o_renderer.adjustHand({"player":self});
				o_renderer.adjustDiscard({"player":self});
			}
			discardCard(n - 1, callback);
		} else{
			if(callback){
				callback();
			}
		}
	}
	
	function playCard(card, callback){
		var pos = -1;
		for(var i = 0; i < hand.size; i++){
			var c = hand.get(i);
			if(c.id == card.id){
				pos = i;
				break;
			}
		}
		if(pos >= 0){
			hand = hand.remove(pos);
			field.add(card);
			if(instance_exists(o_renderer)){
				o_renderer.adjustHand({"player":self});
				o_renderer.adjustField({"player":self});
			}
			card.play();
			if(callback){
				callback();
			}			
		} else{
			throw ("Player.playCard(): Card not found");
		}
	}
	
	function play() ABSTRACT;
	
}