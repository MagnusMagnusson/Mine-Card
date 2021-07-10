function Game() constructor{
	players = new Array();
	currentPlayerIndex = 0;
	me = self;
	static setup = function(){
		players.forEach(function(p){
			p.setupDecks();
		})
		var p1, p2;
		p1 = players.get(1);
		p2 = players.get(0);
		
		with(o_heart){
			if(y < room_height/2){
				player = p1;
			} else{
				player = p2;
			}
		}
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
		me.currentPlayerIndex = (me.currentPlayerIndex + 1) % me.players.size;
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
		player.isPlaying = false;
		player.endTurn();
		me.afterEndTurn();
	}
	
	static afterEndTurn = function(){
		me.nextPlayer();
		me.playerPlay();
	}
	
	static hurt = function(player, amount){
		player.bank.hearts -= amount;
		if(player.bank.hearts <= 0){
			if(!player.isHuman){
				show_message("YOU WIN!");
			} else{
				show_message("YOU'VE LOST!");
			}
			
			if(show_question("Play again?")){
				game_restart();
			} else{
				game_end();
			}
		}
	}
	
	static opponent = function(player){
		return players.get((player.pos + 1) % players.size);
	}
}