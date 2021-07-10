function Game() constructor{
	players = new Array();
	currentPlayerIndex = 0;
	
	
	Game(){
	}
	
	function addPlayer(Player){
		self.players.add(Player);
	}
	
	function start(){
		var p1, p2;
		p1 = self.players.get(0);
		p2 = self.players.get(1);
		p1.draw(3, undefined);
		p2.draw(5, undefined);
		p1.travel(WORLDS.OVERWORLD);
		p2.travel(WORLDS.OVERWORLD);
		self.playerPlay();
	}
	
	function nextPlayer(){
		self.currentPlayerIndex = (self.currentPlayerIndex + 1) % self.players.size;
	}
	
	function currentPlayer(){
		return self.players[self.currentPlayerIndex];
	}
	
	function playerPlay(){
		var player = self.currentPlayer();
		player.play();
	}
	
	function endTurn(){
		var player = self.currentPlayer();
		player.endTurn(self.afterEndTurn);
	}
	
	function afterEndTurn(){
		self.nextPlayer();
		self.playerPlay();
	}
	
	function opponent(player){
		return self.players.get((player.id + 1) % self.players.size);
	}
}