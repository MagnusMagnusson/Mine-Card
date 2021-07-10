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
	owner = _owner;
	id  = name + randomId(16);
	
	static play = function(){
	}
	
}