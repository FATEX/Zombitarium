package
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;

	public class Door extends FlxSprite
	{
		var doorOpen:Boolean = false;
		var doorOpenImg:FlxSprite;
		var pressed:Boolean = true;
		
		private const TILE_WIDTH:uint = 100;
		private const TILE_HEIGHT:uint =100;
		
		[Embed(source="door_100.png")] static var ImgDoorClose:Class;
		[Embed(source="doorOpen_100.png")] static var ImgDoorOpen:Class;
		
		public function Door(tx,ty)
		{
			super(tx,ty);
			this.height=TILE_HEIGHT;
			this.width=TILE_WIDTH;
		
		}
		public function updateDoor() 
		{
			if (doorOpen == false) {
				this.loadGraphic(ImgDoorClose, false, false, TILE_WIDTH*1.5, TILE_HEIGHT*1.5); 
				this.immovable = true;
			} else
			{
				this.loadGraphic(ImgDoorOpen, false, false,  TILE_WIDTH*1.5, TILE_HEIGHT*1.5);
				this.immovable = true;
			}
		}
	}
}