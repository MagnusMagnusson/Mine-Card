global.database = {
	cards : [],
	cardMap : {},
};

function Database(){
	global.database = load_options("cards.json");
	if(!global.database){
		return false;
	}
	global.database.cardMap = {};
	for(var i = 0; i < array_length(global.database.cards); i++){
		var card = global.database.cards[i];
		global.database.cardMap[$ card.cid] = card;
	}
	return true;
}

function database_get(card_id){
	return global.database.cardMap[$ card_id];
}


function load_options(file){
    var existing_buffer = buffer_load(file);
    if (existing_buffer != -1) {
        var json = buffer_read(existing_buffer, buffer_string);
        buffer_delete(existing_buffer)
        return json_parse(json);
    } else{
		return false;
	}
}

function save_options(file, options){
	var json = json_stringify(options);
	var buffer = buffer_create(1, buffer_grow, 1);
    buffer_write(buffer, buffer_string, json);
    buffer_save(buffer, file);
    buffer_delete(buffer);
}