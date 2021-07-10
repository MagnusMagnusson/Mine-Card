if(x != xTarget){
	if(abs(x - xTarget) < 3){
		x = xTarget;
	} else{
		x -= 3*(x-xTarget) / room_speed;
	}
}

if(y != yTarget){
	if(abs(y - yTarget) < 3){
		y = yTarget;
	} else{
		y -= 3*(y-yTarget) / room_speed;
	}
}


if(isHovering){
	hoverCounter++;
} else{
	hoverCounter = 0;
}