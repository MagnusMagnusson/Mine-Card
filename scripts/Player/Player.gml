function Player(gameStruct, position) constructor{
	
	hand = new Array();
	deck = new Array();
	discard = new Array();
	field = new Array();
	isHuman = false;
	isPlaying = false;
	pos = position;
	me = self;
	helper = undefined;
	
	bank = {
		hearts : STARTINGHEALTH,
		attack : 0,
		wood : 0,
		stone : 0,
		iron : 0,
		diamond : 0,
		obsidian : 0,
		endpearl : 0,
		blazerod : 0,	
		leather : 0,
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
		deck = setupDeck("startDeck", CARDSTATES.DECK);
		buyDecks[$ WORLDS.OVERWORLD ] = setupDeck("overworld", CARDSTATES.STORE);
		buyDecks[$ WORLDS.MINE ] = setupDeck("mine", CARDSTATES.STORE);
		buyDecks[$ WORLDS.DEEPMINE ] = setupDeck("deepmine", CARDSTATES.STORE);
		buyDecks[$ WORLDS.NETHER ] = setupDeck("nether", CARDSTATES.STORE);
		buyDecks[$ WORLDS.END ] = setupDeck("end", CARDSTATES.STORE);
		travel(WORLDS.OVERWORLD);
		if(instance_exists(o_renderer)){
			o_renderer.adjustDeck({player:me});
		}
	}
	
	static setupDeck = function(deckId, state){
		var d = global.database[$ deckId];
		var _deck = new Array();
		for(var i = 0; i < array_length(d); i++){
			var cardInfo = database_get(d[i]);
			var card = new Card(cardInfo, me, state);
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
			diamond : 0,
			obsidian : 0,
			endpearl : 0,
			blazerod : 0,		
			leather : 0,
		};
	}
	
	static getActiveDeck = function(){
		return self.activeBuyDeck;
	}
	
	static travel = function(location, callback){
		me.activeBuyDeck = me.buyDecks[$location];
		if(instance_exists(o_renderer)){
			o_renderer.adjustBuyRow({player:me});
		}
		if(callback){
			callback();
		}
	}
	
	static shuffle = function(){
		deck = discard.shuffle()
		discard = new Array();
		deck.forEach(function(c){c.state = CARDSTATES.DECK});
		if(instance_exists(o_renderer)){
			o_renderer.adjustDeck({player:me});
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
			var card = deck.last();
			deck.remove(-1)
			hand.add(card)
			card.state = CARDSTATES.HAND;
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
			var card = hand.last();
			hand.remove(-1)
			discard.add(card)
			card.state = CARDSTATES.DISCARD;
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
			card.state = CARDSTATES.FIELD;
			if(instance_exists(o_renderer)){
				o_renderer.adjustHand({player:me});
				o_renderer.adjustField({player:me});
			}
			
			card.activate();
			
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
			card.state = CARDSTATES.DISCARD;
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
	
	static endTurn = function(callback){
		clearBank();
		helper = callback;
		clearField();
		shiftBuyDeck();
		discardCard(hand.size,self.refreshHand);
	}
	
	static shiftBuyDeck = function(){
		if(activeBuyDeck.size > 0){
			var card = activeBuyDeck.get(0);
			activeBuyDeck.remove(0);
			activeBuyDeck.add(card);
			if(instance_exists(o_renderer)){
				o_renderer.adjustBuyRow({player:me});
			}
		}
	}
	
	static burnHand = function(){
		if(!isHuman || show_question("Are you sure you want to burn your hand. The cards in it will be permanently lost")){
			for(var i = 0; i < hand.size; i++){
				var card = hand.get(i);
				instance_destroy(card.guiCard);
				delete card;
			}
			hand.clear();
		}
	}
	
	static clearField = function(){
		var deadField = field.filter(function(c) {
			return c.strength == 0;
		});
		var aliveField = field.filter(function(c) {
			return c.strength > 0;
		});
		deadField.forEach(function(c){
			c.state = CARDSTATES.DISCARD;
		});
		discard = discard.concat(deadField);
		field = aliveField;
		
		if(instance_exists(o_renderer)){
			o_renderer.adjustField({player:me});
			o_renderer.adjustDiscard({player:me});
		}
	}
	
	static refreshHand = function(){
		draw(5, helper);
	}
	
	static affords = function(resourceArray){
		for(var i = 0; i < array_length(resourceArray); i++){
			var r,a;
			r = resourceArray[i].resource;
			a = resourceArray[i].amount;
			if(bank[$ r] < a){
				return false;
			}
		}
		return true;
	}
	
	static getHurt = function(dam){
		var opp = game.opponent(me);
		game.hurt(me, opp.bank.attack + dam);
		opp.bank.attack = 0;
	}
	
	static play = function() {
		throw "CHILDREN MUST IMPLEMENT ABSTRACT METHODS";
	};
}