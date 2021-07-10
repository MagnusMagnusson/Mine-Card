function Game() constructor{
	players = new Array();
	currentPlayerIndex = 0;
	
	static addPlayer = function(Player){
		self.players.add(Player);
	}
	
	static star = function(){
		var p1, p2;
		p1 = self.players.get(0);
		p2 = self.players.get(1);
		p1.draw(3, undefined);
		p2.draw(5, undefined);
		p1.travel(WORLDS.OVERWORLD);
		p2.travel(WORLDS.OVERWORLD);
		self.playerPlay();
	}
	
	static nextPlayer = function(){
		self.currentPlayerIndex = (self.currentPlayerIndex + 1) % self.players.size;
	}
	
	static currentPlayer = function(){
		return self.players[self.currentPlayerIndex];
	}
	
	static playerPlay = function(){
		var player = self.currentPlayer();
		player.play();
	}
	
	static endTurn = function(){
		var player = self.currentPlayer();
		player.endTurn(self.afterEndTurn);
	}
	
	static afterEndTurn = function(){
		self.nextPlayer();
		self.playerPlay();
	}
	
	static opponent = function(player){
		return self.players.get((player.id + 1) % self.players.size);
	}
}