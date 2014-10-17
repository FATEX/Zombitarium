package objects
{
	public class Patient extends Human
	{
		//patients don't attack
		
		[Embed(source="walk_nurse_front.png")] private static var ImgSpaceman:Class;

		public function Patient(originX:Number, originY:Number)
		{
			super(originX, originY);
			super.loadGraphic(ImgSpaceman, true, true, 16);
			//super.isStunned = true;
		}
		
		
	}
}