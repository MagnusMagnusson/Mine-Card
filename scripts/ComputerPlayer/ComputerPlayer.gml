function ComputerPlayer(gameStruct, position ) :  Player(gameStruct, position) constructor {

	isHuman = false;
	lastWorld = WORLDS.OVERWORLD;

	static play = function(){
		isPlaying = true;
		if(deck.size > 15 && hand.size < 3){
			burnHand();
			game.endTurn();
			return
		} else if(hand.size > 0){
			playCard(hand.get(0));
		} else{
			if(random(1) < 0.5){
				if(bank.attack > 0){
					var opp = game.opponent(me);
					opp.getHurt(0);
							
					o_computer_player.bot = me;
					o_computer_player.alarm[0] = room_speed / 2;
					return;
				} 
				
			} 
			var expensiveCard = undefined;
			var cardCost = 0;
			var world = undefined;
			for(var i = 0; i < 5; i++){
				var card = buyDecks[$ WORLDS.OVERWORLD].get(i);
				if(affords(card.cost)){
					if(card.cid == "woodAxe" || card.cid == "woodSword"){
						continue;
					}
					var c = card.convertedCost();
					if(c > cardCost){
						expensiveCard = card;
						cardCost = c;
						world = WORLDS.OVERWORLD;
					}
				}
			}
			for(var i = 0; i < 5; i++){
				var card = buyDecks[$ WORLDS.MINE].get(i);
				if(affords(card.cost)){
					var c = card.convertedCost() * 1.15;
					if( c > cardCost){
						expensiveCard = card;
						cardCost = c;
						world = WORLDS.MINE;
					}
				}
			}
			for(var i = 0; i < 5; i++){
				var card = buyDecks[$ WORLDS.DEEPMINE].get(i);
				if(affords(card.cost)){
					var c = card.convertedCost() * 1.25;
					if(c > cardCost){
						expensiveCard = card;
						cardCost = c;
						world = WORLDS.DEEPMINE;
					}
				}
			}			
			for(var i = 0; i < 5; i++){
				var card = buyDecks[$ WORLDS.NETHER].get(i);
				if(affords(card.cost)){
					var c = card.convertedCost() * 1.5;;
					if(c > cardCost){
						expensiveCard = card;
						cardCost = c;
						world = WORLDS.NETHER;
					}
				}
			}
			for(var i = 0; i < 1; i++){
				var card = buyDecks[$ WORLDS.END].get(i);
				if(affords(card.cost)){
					var c = card.convertedCost() * 2 ;
					show_message(c);
					if(c > cardCost){
						show_message(card.name);
						expensiveCard = card;
						cardCost = c;
						world = WORLDS.END;
					}
				}
			}
			
			if(expensiveCard){
				if(world != lastWorld){
					lastWorld = world;
					travel(world);
				} else{
					expensiveCard.play();
				}
			} else{
				if(bank.attack > 0){
					var opp = game.opponent(me);
					opp.getHurt(0);
				} else{
					game.endTurn();
					return;
				}
			}
		}
		
		
		o_computer_player.bot = me;
		o_computer_player.alarm[0] = room_speed / 2;
	}

}