package
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	
	public class UnlockedDoor extends FlxSprite
	{
		var doorOpen:Boolean = false;
		var doorOpenImg:FlxSprite;
		var pressed:Boolean = true;
		
		[Embed(source="door.png")] static var ImgDoorClose:Class;
		[Embed(source="doorOpen.png")] static var ImgDoorOpen:Class;
		
		public function UnlockedDoor(tx,ty)
		{
			super(tx,ty);
			
		}
		public function updateDoor() 
		{
			if (doorOpen == false) {
				this.loadGraphic(ImgDoorClose, false, false, 30, 15); 
				this.immovable = true;
			} else
			{
				this.loadGraphic(ImgDoorOpen, false, false, 30, 15)
				this.immovable = true;
			}
		}
		public function checkCollision(c, p, tx, ty) { 
		
			if(doorOpen == false){ // if the door hasn't been opened yet

					if(FlxG.overlap(p, this) && FlxG.keys.E && pressed){ // check if the door and the player are touching
						pressed = false;
						doorOpen = true;
						c.setTile(tx, ty, 0);
						c.setTile(tx, ty, 0);
						
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
				} 
				else if (FlxG.keys.E == false) {
					pressed = true;
				}
				
			}

			
		}
	}
}