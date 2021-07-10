function randomId(n){
	var str = "";
	var options = "1234567890_qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM";
	repeat(n){
		str += string_char_at(options,irandom(string_length(options)));
	}
	return str;
}

function Card(cardObject, _owner) constructor{
	name = cardObject.name;
	text = cardObject.text;
	resources = cardObject.resources;
	strength = cardObject.strength;
	cost = cardObject.cost;
	onPlay = cardObject.onPlay;
	cid = cardObject.cid;
	owner = _owner;
	guiCard = instance_create_layer(0,0,layer_get_id("card_layer"), o_card);
	id  = name + randomId(16);
	
	static play = function(){
	}
	
}