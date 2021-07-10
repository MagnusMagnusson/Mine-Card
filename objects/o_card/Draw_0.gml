draw_self()
draw_set_color(0);
draw_set_halign(fa_center);
draw_set_font(medFont);
if(!facedown){
	draw_text( x + sprite_width/2, y + 2, card.name);
	for(var i = 0; i < array_length(card.cost); i++){
			var a,r;
			a = card.cost[i].amount;
			r = card.cost[i].resource;
			draw_text(x +24+  50*i, y + 32, a);
			var spr = iconGet(r);
			draw_sprite_ext(s_icon, spr, x +32+ 50*i,y + 24,0.5,0.5,0,c_white,1);
		}
	for(var i = 0; i < array_length(card.resources); i++){
		var a,r;
		a = card.resources[i].amount;
		r = card.resources[i].resource;
		draw_text(x +24+  50*i, y + 3*32, a);
		var spr = iconGet(r);
		draw_sprite_ext(s_icon, spr, x +32+ 50*i,y + 4*24,0.5,0.5,0,c_white,1);
	}
	draw_text_ext(x + 2*32, y + 1.5*48, card.text, 16,sprite_width);
}

