package objects
{

	public class Nurse extends Human
	{
		//nurses grant disguises
		
		[Embed(source="walk_nurse_front.png")] private static var ImgSpaceman:Class;
		
		public function Nurse(originX:Number, originY:Number)
		{
			super(originX, originY);
			super.loadGraphic(ImgSpaceman, true, true, 16);
		}
		
	}
}