function Player(gameStruct, position) constructor{
	
	hand = new Array();
	deck = new Array();
	discard = new Array();
	field = new Array();
	isHuman = false;
	pos = position;
	bank = {
		"health" : STARTINGHEALTH,
		"attack" : 0,
		"wood" : 0,
		"stone" : 0,
		"iron" : 0,
		"diamonds" : 0
		"obsidian" : 0
		"endpearl" : 0
		"blazerod" : 0		
	};
	game = gameStruct;
	
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
	activeBuyDeck = undefined;

	
	static clearBank = function(){
		bank = {
			"health" : bank.health,
			"attack" : 0,
			"wood" : 0,
			"stone" : 0,
			"iron" : 0,
			"diamonds" : 0
			"obsidian" : 0
			"endpearl" : 0
			"blazerod" : 0		
		};
	}
	
	static getActiveDeck = function(){
		return activeBuyDeck;
	}
	
	static travel= function(location, callback){
		activeBuyDeck = buyDecks[$location];
		if(instance_exists(o_renderer)){
			o_renderer.adjustBuyRow({"player":self});
		}
		if(callback){
			callback();
		}
	}
	
	static shuffle = function(){
		deck = shuffle(discard)
		discard.clear()
		if(instance_exists(o_renderer)){
			o_renderer.renderShuffle({"player":self});
		}
	}
	
	static draw = function(n, callback){
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
	
	static discardCard = function(n, callback){
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
	
	static playCard = function(card, callback){
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
	
	static buyCard = function(card, callback){
		var pos = -1;
		for(var i = 0; i < activeBuyDeck.size; i++){
			var c = activeBuyDeck.get(i);
			if(c.id == card.id){
				pos = i;
				break;
			}
		}
		if(pos >= 0){
			activeBuyDeck = activeBuyDeck.remove(pos);
			discard.add(card);
			if(instance_exists(o_renderer)){
				o_renderer.adjustBuyRow({"player":self});
				o_renderer.adjustDiscard({"player":self});
			}
			if(callback){
				callback();
			}			
		} else{
			throw ("Player.playCard(): Card not found");
		}
	}
	
	static endTurn = function(){
		discardCard(discard.size,undefined);
		draw(5, undefined);
		clearBank();
	}
	
	static play = function() ABSTRACT;
}