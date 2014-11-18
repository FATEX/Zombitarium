package
{
	import org.flixel.FlxSprite;
	
	public class DoorObject extends FlxSprite
	{
		public var doorOpen:Boolean=false;

		public function DoorObject(X:Number=0, Y:Number=0, SimpleGraphic:Class=null)
		{
			super(X, Y, SimpleGraphic);
		}
	}
}