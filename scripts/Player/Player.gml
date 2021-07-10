function Player(gameStruct, position) constructor{
	
	hand = new Array();
	deck = new Array();
	discard = new Array();
	field = new Array();
	isHuman = false;
	isPlaying = false;
	pos = position;
	me = self;
	
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
	
	activeBuyDeck = new Array();
	
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

	static setupDecks = function(){
		deck = setupDeck("startDeck");
		buyDecks[$ WORLDS.OVERWORLD ] = setupDeck("overworld");
		travel(WORLDS.OVERWORLD);
		if(instance_exists(o_renderer)){
			o_renderer.adjustDeck({player:me});
		}
	}
	
	static setupDeck = function(deckId){
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
		return self.activeBuyDeck;
	}
	
	static travel= function(location, callback){
		self.activeBuyDeck = buyDecks[$location];
		if(instance_exists(o_renderer)){
			o_renderer.adjustBuyRow({player:me});
		}
		if(callback){
			callback();
		}
	}
	
	static shuffle = function(){
		deck = shuffle(discard)
		discard.clear()
		if(instance_exists(o_renderer)){
			o_renderer.renderShuffle({player:me});
		}
	}
	
	static draw = function(n, callback){
		if( n > 0 ){
			if(deck.size == 0){
				show_message("ZERO")
				if(discard.size > 0){
					show_message("shuffling")
					shuffle();
				} else{
					draw(-1, callback);
					return;
				}
			}
			var card = deck.last();
			deck.remove(-1)
			hand.add(card)
			draw(n - 1, callback);
		} else{			
			if(instance_exists(o_renderer)){
				o_renderer.adjustHand({player:me});
			}
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
				o_renderer.adjustHand({player:me});
				o_renderer.adjustDiscard({player:me});
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
				o_renderer.adjustHand({player:me});
				o_renderer.adjustField({player:me});
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
				o_renderer.adjustBuyRow({player:me});
				o_renderer.adjustDiscard({player:me});
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