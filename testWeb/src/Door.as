package
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;

	public class Door extends FlxSprite
	{
		var doorOpen:Boolean = false;
		var doorOpenImg:FlxSprite;
		var pressed:Boolean = true;
		var isWin:Boolean = false;
		
		private const TILE_WIDTH:uint = 65;
		private const TILE_HEIGHT:uint = 65;
		
		[Embed(source="doorL_100.png")] static var ImgDoorClose:Class;
		[Embed(source="doorOpenL_100.png")] static var ImgDoorOpen:Class;
		[Embed(source="doorWin_100.png")] private static var ImgDoorCloseWin:Class;
		[Embed(source="doorOpenWin_100.png")] private static var ImgDoorOpenWin:Class;
		
		public function Door(tx,ty)
		{
			super(tx,ty);
			this.height=TILE_HEIGHT;
			this.width=TILE_WIDTH;
		
		}
		public function updateDoor():void 
		{
			if (doorOpen == false) {
				if(isWin){
					this.loadGraphic(ImgDoorCloseWin, false, false, TILE_WIDTH*1.5, TILE_HEIGHT*1.5);
				}else{
					this.loadGraphic(ImgDoorClose, false, false, TILE_WIDTH*1.5, TILE_HEIGHT*1.5);
				}
				this.immovable = true;
			} else
			{
				if(isWin){
					this.loadGraphic(ImgDoorOpenWin, false, false, TILE_WIDTH*1.5, TILE_HEIGHT*1.5);
				}else{
					this.loadGraphic(ImgDoorOpen, false, false,  TILE_WIDTH*1.5, TILE_HEIGHT*1.5);
				}
				this.immovable = true;
			}
		}
	}
}