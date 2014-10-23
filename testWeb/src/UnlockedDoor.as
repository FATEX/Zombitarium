package
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	
	public class UnlockedDoor extends FlxSprite
	{
		var doorOpen:Boolean = false;
		var doorOpenImg:FlxSprite;
		var pressed:Boolean = true;
		
		private const TILE_WIDTH:uint = 65;
		private const TILE_HEIGHT:uint = 65;
		
		[Embed(source="door_100.png")] static var ImgDoorClose:Class;
		[Embed(source="doorOpen_100.png")] static var ImgDoorOpen:Class;
		
		public function UnlockedDoor(tx,ty)
		{
			super(tx,ty);
			
		}
		public function updateDoor() 
		{
			if (doorOpen == false) {
				this.loadGraphic(ImgDoorClose, false, false,  TILE_WIDTH*1.5, TILE_HEIGHT*1.5); 
				this.immovable = true;
			} else
			{
				this.loadGraphic(ImgDoorOpen, false, false,  TILE_WIDTH*1.5, TILE_HEIGHT*1.5)
				this.immovable = true;
			}
		}
		public function checkCollision(c, p, tx, ty, zombies:Vector.<Zombie>,player:Zombie, state:PlayState) { 
		
			if(doorOpen == false){ // if the door hasn't been opened yet
					trace("check collision = "+ FlxG.overlap(p, this));
					if(FlxG.overlap(p, this) && FlxG.keys.E && pressed){ // check if the door and the player are touching
						pressed = false;
						doorOpen = true;
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