package
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxTilemap;

	public class Key extends FlxSprite
	{
		private var keyCollected:Boolean = false;
		private var pressed:Boolean = true;
		private var collisionMap:FlxTilemap;
		
		[Embed(source="key.png")] private static var ImgKey:Class;
		
	
		
		public function Key(c, d:Door, p:FlxSprite, tx, ty) {

		
			super(tx,ty);
			this.loadGraphic(ImgKey, false, false, 16);
		}
		public function checkCollision(c, d, p, tx, ty) { 
			if(keyCollected == false){ // if we still haven't collected the key
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
						c.setTile(tx, ty, 0);
						c.setTile(tx, ty, 0);
						
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
					c.setTile(tx, ty, 1);		
				} 
				else if (FlxG.keys.E == false) {
					pressed = true;
				}
				
			}
			
			
			
		}
		
	
		
		
	}
}