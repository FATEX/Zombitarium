package
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxTilemap;

	public class Key extends FlxSprite
	{
		private var keyCollected:Boolean = false;
		private var pressed:Boolean = true;
		public var collectable:Boolean = false;
		private var collisionMap:FlxTilemap;
		
		[Embed(source="key_100.png")] private static var ImgKey:Class;
		
		private const TILE_WIDTH:uint = 65;
		private const TILE_HEIGHT:uint = 65;
		
	
		
		public function Key(c, d:Door, p:FlxSprite, tx, ty) {

		
			super(tx,ty);
			this.loadGraphic(ImgKey, false, false, TILE_WIDTH, TILE_HEIGHT);
			this.immovable = true;
		}


		public function checkCollision(c, d, p, tx, ty, zombies:Vector.<Zombie>, state:PlayState):void { 
			
			if(keyCollected == false && collectable){ // if we still haven't collected the key

				if(FlxG.collide(p, this)){ // and if the player collides with the key
					this.visible = false; // hide the key from view
					keyCollected = true; // set our Boolean to true
				}
			}
		
			if(d.doorOpen == false){ // if the door hasn't been opened yet
				if(keyCollected == true){ // and if the player has already collected the key
					if(FlxG.overlap(p, d) && FlxG.keys.E && pressed){ // check if the door and the player are touching
						pressed = false;
						d.doorOpen = true;
						state.logger.recordEvent(PlayState.level,6,"pos=("+(int)(p.x/TILE_WIDTH)+","+(int)(p.y/TILE_HEIGHT)+")|action:open door");
						c.setTile(tx, ty, 0);
						c.setTile(tx, ty, 0);
						state.revealBoard()
						for(var i:int =0; i<zombies.length;i++){
							zombies[i].checkPath(c);
						}
						
					} else if (FlxG.keys.E == false) {
						pressed = true;
					}
				}
			}
			else
			{
				if (FlxG.keys.E && pressed && FlxG.overlap(p, d)) {
					pressed = false;
					d.doorOpen = false;
					state.logger.recordEvent(PlayState.level,7,"pos=("+(int)(p.x/TILE_WIDTH)+","+(int)(p.y/TILE_HEIGHT)+")|action:close door");
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