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
	}
	
	static play = function(){
		if(guiCard.facedown){
			return;
		}
		switch(state){
			case CARDSTATES.STORE : {
				if(owner.isPlaying && owner.isHuman){
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
				if(!owner.isPlaying && !owner.isHuman){
					owner.discardCard(self, undefined);
				}
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