function randomId(n){
	var str = "";
	var options = "1234567890_qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM";
	repeat(n){
		str += string_char_at(options,irandom(string_length(options)));
	}
	return str;
}

function Card(cardObject, _owner, cardState) constructor{
	name = cardObject.name;
	text = cardObject.text;
	resources = cardObject.resources;
	strength = cardObject.strength;
	cost = cardObject.cost;
	onPlay = cardObject.onPlay;
	cid = cardObject.cid;
	owner = _owner;
	state = cardState
	guiCard = instance_create_layer(0,0,layer_get_id("card_layer"), o_card);
	with(guiCard){
		card = other
	}
	id  = self.name + randomId(16);
	
	static activate = function(){
		for(var i = 0; i < array_length(resources); i++){
			var r,a;
			r = resources[i].resource;
			a = resources[i].amount;
			try{		
				owner.bank[$ r] = owner.bank[$ r] + a;
			} catch(e){
				show_debug_message(e);
			}
		}
		for(var i = 0; i < array_length(onPlay); i++){
			var p = onPlay[i];
			switch(p){
				case "draw":{
					owner.draw(1,undefined);
					break;
				}
				case "discard":{
					var opp = owner.game.opponent(owner);
					opp.discardCard(1, undefined);
					break;
				}
				case "win":{
					var opp = owner.game.opponent(owner);
					opp.getHurt(999999);
				}
			}
		}
	}
	
	static convertedCost = function(){
		var c = 0;
		for(var i = 0; i < array_length(cost); i++){
			c += cost[i].amount;
		}
		return c;
	}
	
	static play = function(){
		if(guiCard.facedown || !owner.isPlaying){
			return;
		}
		switch(state){
			case CARDSTATES.STORE : {
				if(owner.isPlaying){
					if(owner.affords(cost)){
						show_debug_message(cost);
						show_debug_message(owner.bank);
						for(var i = 0; i < array_length(cost); i++){
							var r,a;
							r = cost[i].resource;
							a = cost[i].amount;
							try{
								owner.bank[$ r] = owner.bank[$ r] - a;
							} catch(e){
								show_debug_message(e);
							}
						}
						owner.buyCard(self, undefined);
					}
				}
				break;
			}
			case CARDSTATES.FIELD : {
				break;
			}
			case CARDSTATES.HAND : {
				if(owner.isPlaying && owner.isHuman){
					owner.playCard(self, undefined);
				}
			}				
		}
	}
	
}