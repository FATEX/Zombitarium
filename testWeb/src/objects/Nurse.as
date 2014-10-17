package objects
{
	public class Nurse extends Human
	{
		public function Nurse(originX:Number, originY:Number)
		{
			super(originX, originY);
			super.loadGraphic(ImgSpaceman, true, true, 16);
		}
	}
}