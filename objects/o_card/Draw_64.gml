if(hoverCounter > room_speed && !facedown){
	draw_set_font(bigFont);
	var scale = 3;
	var nx, ny;
	nx =( room_width / 2) - 4.5*sprite_width;
	ny = (room_height / 2) - 3* sprite_height
	draw_sprite_ext(sprite_index, 0, nx, ny, 3,3,0,c_white, 1);
	draw_set_color(0);
	draw_set_halign(fa_center);
	draw_text( nx + scale*sprite_width/2, ny + scale*2, card.name);
	for(var i = 0; i < array_length(card.cost); i++){
		var a,r;
		a = card.cost[i].amount;
		r = card.cost[i].resource;
		draw_text(nx +scale*24+  3*50*i, ny + scale*32, a);
		var spr = iconGet(r);
		draw_sprite_ext(s_icon, spr,nx +scale*32+ scale*50*i,ny + scale*24,1.5,1.5,0,c_white,1);
		

	}
	
	for(var i = 0; i < array_length(card.resources); i++){
		var a,r;
		a = card.resources[i].amount;
		r = card.resources[i].resource;
		draw_text(nx +scale*24+  3*50*i, ny + scale*32, a);
		var spr = iconGet(r);
		draw_sprite_ext(s_icon, spr,nx +scale*32+ scale*50*i,ny + 4*scale*24,1.5,1.5,0,c_white,1);
		

	}
	
	draw_text_ext(nx + 2*scale*32, ny + 1.5*scale*48, card.text, 16*scale, 0.5*sprite_width*4.5);
}