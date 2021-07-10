function Player(gameStruct, position) constructor{
	
	hand = new Array();
	deck = new Array();
	discard = new Array();
	field = new Array();
	isHuman = false;
	isPlaying = false;
	pos = position;
	
	bank = {
		hearts : STARTINGHEALTH,
		attack : 0,
		wood : 0,
		stone : 0,
		iron : 0,
		diamonds : 0,
		obsidian : 0,
		endpearl : 0,
		blazerod : 0,		
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

	static setupDecks = function(){
		deck = setupDeck("startDeck");
		buyDecks[$ WORLDS.OVERWORLD ] = setupDeck("overworld");
		if(instance_exists(o_renderer)){
			o_renderer.adjustBuyRow({player:self});
			o_renderer.adjustDeck({player:self});
		}
	}
	
	static setupDeck = function(deckId){
		show_debug_message(deckId);
		var d = global.database[$ deckId];
		var _deck = new Array();
		for(var i = 0; i < array_length(d); i++){
			var cardInfo = database_get(d[i]);
			var card = new Card(cardInfo, self);
			_deck.add(card);
		}
		_deck.shuffle()
		return _deck;
	}
	
	static clearBank = function(){
		bank = {
			hearts : bank.hearts,
			attack : 0,
			wood : 0,
			stone : 0,
			iron : 0,
			diamonds : 0,
			obsidian : 0,
			endpearl : 0,
			blazerod : 0,		
		};
	}
	
	static getActiveDeck = function(){
		return activeBuyDeck;
	}
	
	static travel= function(location, callback){
		activeBuyDeck = buyDecks[$location];
		if(instance_exists(o_renderer)){
			o_renderer.adjustBuyRow({player:self});
		}
		if(callback){
			callback();
		}
	}
	
	static shuffle = function(){
		deck = shuffle(discard)
		discard.clear()
		if(instance_exists(o_renderer)){
			o_renderer.renderShuffle({player:self});
		}
	}
	
	static draw = function(n, callback){
		if( n > 0 ){
			if(deck.size == 0){
				if(discard.size > 0){
					shuffle();
				} else{
					draw(-1, callback);
					return;
				}
			}
			var card = deck.pop();
			hand.add(card)
			if(instance_exists(o_renderer)){
				o_renderer.adjustHand({ player:self});
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
				o_renderer.adjustHand({ player:self});
				o_renderer.adjustDiscard({ player:self});
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
				o_renderer.adjustHand({ player:self});
				o_renderer.adjustField({ player:self});
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
				o_renderer.adjustBuyRow({ player:self});
				o_renderer.adjustDiscard({ player:self});
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
	
	static play = function() {
		throw "CHILDREN MUST IMPLEMENT ABSTRACT METHODS";
	};
}