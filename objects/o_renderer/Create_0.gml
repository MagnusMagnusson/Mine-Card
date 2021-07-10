var halfY = sprite_get_height(s_card)/2

LOCATIONS = [
	{
		discard : [room_width - 128-32,  room_height -  128 - halfY],
		deck : [room_width - 128 - 258, room_height - 128 - halfY],
		buyrow : [room_width - 128-32, room_height / 2 - halfY + 92],
		hand : [128,room_height - 128 - halfY] ,
		field:  [128, room_height / 2 - halfY + 2*92],
	},
	{
		discard : [room_width - 128-32,  128 - halfY],
		deck : [room_width - 128 - 258, 128 - halfY],
		buyrow : [room_width - 128-32, room_height / 2  - halfY - 92],
		hand : [128, 128 - halfY],
		field : [128, room_height / 2  - halfY - 2 * 92],
	}
]

renderShuffle = function(e){
	if(e[$"callback"]){
		e.callback();
	}
}

adjustHand = function(e){
	var player = e.player
	var hand = player.hand
	for(var i = 0; i < hand.size; i++){
		var card = hand.get(i).guiCard;
		card.facedown = !player.isHuman;
		card.xTarget = (card.sprite_width + 64) * i + LOCATIONS[e.player.pos].hand[0];
		card.yTarget = LOCATIONS[e.player.pos].hand[1];	
		
	}
	if(e[$"callback"]){
		e.callback();
	}	
}

adjustDiscard = function(e){
	var discard = e.player.discard;
	for(var i = 0; i < discard.size; i++){
		var card = discard.get(i).guiCard;
		card.facedown = false;
		card.xTarget = LOCATIONS[e.player.pos].discard[0];
		card.yTarget = LOCATIONS[e.player.pos].discard[1];
	}
	if(e[$"callback"]){
		e.callback();
	}	
	
}

adjustBuyRow = function(e){
	var player = e.player
	var deck = player.getActiveDeck()
	var j = 5;
	with(o_card){
		if(self.card && self.card.owner.pos == player.pos && self.card.state == CARDSTATES.STORE){
			xTarget = room_width * 2; 
		}
	}
	for(var i = 0; i < deck.size; i++){
		var card = deck.get(i).guiCard;
		if(j > 0){
			j--;
			card.facedown = false;
			card.xTarget =  LOCATIONS[e.player.pos].buyrow[0] - (card.sprite_width + 64) * (1+j) ;
			card.yTarget = LOCATIONS[e.player.pos].buyrow[1];	
		} else{
			card.facedown = true;
			card.xTarget = LOCATIONS[e.player.pos].buyrow[0];
			card.yTarget = LOCATIONS[e.player.pos].buyrow[1];
		}
	}
	if(e[$"callback"]){
		e.callback();
	}	
}

adjustDeck = function(e){
	var deck = e.player.deck;
	for(var i = 0; i < deck.size; i++){
		var card = deck.get(i).guiCard;
		card.facedown = true;
		card.xTarget = LOCATIONS[e.player.pos].deck[0];
		card.yTarget = LOCATIONS[e.player.pos].deck[1];
	}
	
	if(e[$"callback"]){
		e.callback();
	}	
}


adjustField = function(e){
	var field = e.player.field;
	for(var i = 0; i < field.size; i++){
		var card = field.get(i).guiCard;
		card.facedown = false;
		card.xTarget = LOCATIONS[e.player.pos].field[0] + i*0.75*(sprite_get_width(s_card));
		card.yTarget = LOCATIONS[e.player.pos].field[1];
		card.depth = 100 - i;
	}
	
	if(e[$"callback"]){
		e.callback();
	}	
}

bank = undefined;
