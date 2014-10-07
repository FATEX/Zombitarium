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
				this.loadGraphic(ImgDoorClose, false, false, 30, 20); 
				this.immovable = true;
			} else
			{
				this.loadGraphic(ImgDoorOpen, false, false, 30, 20);
				this.immovable = true;
			}
		}
	}
}