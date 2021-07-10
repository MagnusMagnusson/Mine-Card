if(bank){
	var wood, stone, iron, diamond, attack;
	var xx,yy;
	xx = room_width - 17 * 64;
	yy = room_height - 380;
	var jump = 130;
	var yoffset = 32;
	var xoffset = 20;
	draw_set_font(bigFont)
	draw_set_valign(fa_middle)
	
	draw_sprite(s_icon, ICONS_RESOURCE.ATTACK,xx,yy);
	draw_text(xx+ xoffset + 64, yoffset + yy, bank.attack);
	xx+=jump;
	draw_sprite(s_icon, ICONS_RESOURCE.WOOD,xx,yy);
	draw_text(xx + xoffset+ 64 , yoffset + yy, bank.wood);
	xx+=jump;
	draw_sprite(s_icon, ICONS_RESOURCE.LEATHER,xx,yy);
	draw_text(xx + xoffset+ 64 , yoffset + yy, bank.leather);
	xx+=jump;
	draw_sprite(s_icon, ICONS_RESOURCE.STONE,xx,yy);
	draw_text(xx + 64 +xoffset ,yoffset + yy, bank.stone);
	xx+=jump;
	draw_sprite(s_icon, ICONS_RESOURCE.IRON,xx,yy);
	draw_text(xx + 64 + xoffset,yoffset + yy, bank.iron);
	xx+=jump;
	draw_sprite(s_icon, ICONS_RESOURCE.ENDERPEARL,xx,yy);
	draw_text(xx + 64 + xoffset, yoffset+yy, bank.endpearl);
	draw_set_valign(fa_top)
	xx+=jump;
	draw_sprite(s_icon, ICONS_RESOURCE.DIAMOND,xx,yy);
	draw_text(xx + 64 + xoffset, yoffset+yy, bank.diamond);
	draw_set_valign(fa_top)
}