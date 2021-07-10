var halfY = sprite_get_height(s_card)/2

LOCATIONS = [
	{
		discard : [room_width - 128,  room_height -  128 - halfY],
		deck : [room_width - 128 - 258, room_height - 128 - halfY],
		buyrow : [128, room_height / 2 - halfY + 92],
		hand : [128,128-halfY] ,
	},
	{
		discard : [room_width - 128,  128 - halfY],
		deck : [room_width - 128 - 258, 128 - halfY],
		buyrow : [128, room_height / 2  - halfY - 92],
		hand : [128,room_height - 128 - halfY],
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
		card.facedown = true;
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
	var j = 6;
	for(var i = 0; i < deck.size; i++){
		var card = deck.get(i).guiCard;
		if(j > 0){
			j--;
			card.facedown = false;
			card.xTarget = (card.sprite_width + 64) * j + LOCATIONS[e.player.pos].buyrow[0];
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

adjustDeck= function(e){
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