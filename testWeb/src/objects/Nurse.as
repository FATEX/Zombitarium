package objects
{

	public class Nurse extends Human
	{
		//nurses grant disguises
		private const TILE_WIDTH:uint = 100;
		private const TILE_HEIGHT:uint = 100;
		
		[Embed(source="walk_nurse_front_100.png")] private static var ImgSpaceman:Class;
		
		public function Nurse(originX:Number, originY:Number)
		{
			super(originX, originY);
			super.loadGraphic(ImgSpaceman, true, true, TILE_WIDTH, TILE_HEIGHT);
		}
		
	}
}