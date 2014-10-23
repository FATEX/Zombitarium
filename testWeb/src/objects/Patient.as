package objects
{
	public class Patient extends Human
	{
		//patients don't attack
		private const TILE_WIDTH:uint = 65;
		private const TILE_HEIGHT:uint = 65;
		
		[Embed(source="walk_patient_100.png")] private static var ImgSpaceman:Class;

		public function Patient(originX:Number, originY:Number)
		{
			super(originX, originY,true);
			super.loadGraphic(ImgSpaceman, true, true, TILE_WIDTH,TILE_HEIGHT);
			//super.isStunned = true;
		}
		
		
	}
}