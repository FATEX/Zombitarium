package
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;

	public class Door extends FlxSprite
	{
		var doorOpen:Boolean = false;
		var doorOpenImg:FlxSprite;
		var pressed:Boolean = true;
		
		[Embed(source="door.png")] static var ImgDoorClose:Class;
		[Embed(source="doorOpen.png")] static var ImgDoorOpen:Class;
		
		public function Door(tx,ty)
		{
			super(tx,ty);
		
		}
		public function updateDoor() 
		{
			if (doorOpen == false) {
<<<<<<< HEAD
				this.loadGraphic(ImgDoorClose, false, false, 30,16); 
				this.immovable = true;
			} else
			{
				this.loadGraphic(ImgDoorOpen, false, false, 30,16)
=======
				this.loadGraphic(ImgDoorClose, false, false, 30, 15); 
				this.immovable = true;
			} else
			{
				this.loadGraphic(ImgDoorOpen, false, false, 30, 15)
>>>>>>> 20ef755910f3b3ad704880e58b99ac612803fc93
				this.immovable = true;
			}
		}
	}
}