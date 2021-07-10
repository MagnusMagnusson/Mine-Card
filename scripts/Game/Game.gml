function Game() constructor{
	players = new Array();
	currentPlayerIndex = 0;
	me = self;
	static setup = function(){
		players.forEach(function(p){
			p.setupDecks();
		})
	}
	
	static addPlayer = function(player){
		players.add(player);
	}
	
	static start = function(){
		var p1, p2;
		currentPlayerIndex = choose(0,1);
		p1 = currentPlayer();
		p2 = opponent(p1);
		
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
		return self.players.get(self.currentPlayerIndex);
	}
	
	static playerPlay = function(){
		var player = self.currentPlayer();
		if(instance_exists(o_renderer)){
			o_renderer.bank = player.bank;
		}
		player.play();
	}
	
	static endTurn = function(){
		var player = currentPlayer();
		player.endTurn();
		me.afterEndTurn();
	}
	
	static afterEndTurn = function(){
		me.nextPlayer();
		me.playerPlay();
	}
	
	static opponent = function(player){
		return players.get((player.pos + 1) % players.size);
	}
}