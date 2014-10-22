package objects
{
	public class Patient extends Human
	{
		//patients don't attack
		private const TILE_WIDTH:uint = 100;
		private const TILE_HEIGHT:uint = 100;
		
		[Embed(source="walk_nurse_front.png")] private static var ImgSpaceman:Class;

		public function Patient(originX:Number, originY:Number)
		{
			super(originX, originY);
			super.loadGraphic(ImgSpaceman, true, true, TILE_WIDTH,TILE_HEIGHT);
			//super.isStunned = true;
		}
		
		
	}
}