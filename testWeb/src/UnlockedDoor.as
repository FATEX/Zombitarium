package
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	
	public class UnlockedDoor extends DoorObject
	{
		var doorOpenImg:FlxSprite;
		var pressed:Boolean = true;
		var isWin:Boolean = false;
		
		private const TILE_WIDTH:uint = 65;
		private const TILE_HEIGHT:uint = 65;
		
		[Embed(source="door_100.png")] static var ImgDoorClose:Class;
		[Embed(source="doorOpen_100.png")] static var ImgDoorOpen:Class;
		[Embed(source="doorWin_100.png")] private static var ImgDoorCloseWin:Class;
		[Embed(source="doorOpenL_100.png")] private static var ImgDoorOpenWin:Class;
		
		public function UnlockedDoor(tx,ty)
		{
			super(tx,ty);
			
		}
		public function updateDoor() 
		{
			if (doorOpen == false) {
				if(isWin){
					this.loadGraphic(ImgDoorCloseWin, false, false, TILE_WIDTH*1.5, TILE_HEIGHT*1.5);
				}else{
					this.loadGraphic(ImgDoorClose, false, false,  TILE_WIDTH*1.5, TILE_HEIGHT*1.5);
				}
				this.immovable = true;
			} else
			{
				if(isWin){
					this.loadGraphic(ImgDoorOpenWin, false, false, TILE_WIDTH*1.5, TILE_HEIGHT*1.5);
				}else{
					this.loadGraphic(ImgDoorOpen, false, false,  TILE_WIDTH*1.5, TILE_HEIGHT*1.5)
				}
				this.immovable = true;
			}
		}
		public function checkCollision(c, p, tx, ty, zombies:Vector.<Zombie>,player:Zombie, state:PlayState) { 
		
			if(doorOpen == false){ // if the door hasn't been opened yet
					//trace("check collision = "+ FlxG.overlap(p, this));
					if(FlxG.overlap(p, this) && FlxG.keys.E && pressed){ // check if the door and the player are touching
						pressed = false;
						doorOpen = true;
						PlayState.logger.recordEvent(PlayState.level+1,13,"pos=("+(int)(p.x/TILE_WIDTH)+","+(int)(p.y/TILE_HEIGHT)+")|action:open unlocked door");
						c.setTile(tx, ty, 0);
						c.setTile(tx, ty, 0);
						state.revealBoard();
						for(var i:int =0; i<zombies.length;i++){
							if(zombies[i]!=player){
								zombies[i].checkPath(c);
							}
						}
					} else if (FlxG.keys.E == false) {
						pressed = true;
					}
				}
			
			else
			{
				if (FlxG.keys.E && pressed && FlxG.overlap(p, this)) {
					pressed = false;
					doorOpen = false;
					PlayState.logger.recordEvent(PlayState.level+1,14,"pos=("+(int)(p.x/TILE_WIDTH)+","+(int)(p.y/TILE_HEIGHT)+")|action:close unlocked door");
					c.setTile(tx, ty, 1);
					state.revealBoard();
					for(var j:int =0; j<zombies.length;j++){
						zombies[j].checkPath(c);
					}
				} 
				else if (FlxG.keys.E == false) {
					pressed = true;
				}
				
			}

			
		}
	}
}