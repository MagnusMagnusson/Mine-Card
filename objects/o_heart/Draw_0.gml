draw_self()
draw_set_color(c_white);
draw_set_font(bigFont);

draw_set_halign(fa_center);
draw_set_valign(fa_middle);
if(player){
	draw_text(x + sprite_width/2 - 10, y + sprite_height / 2 , player.bank.hearts);
}
draw_set_halign(fa_left);
draw_set_valign(fa_top);