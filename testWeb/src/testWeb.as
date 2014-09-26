package
{
	import flash.display.Sprite;
	import org.flixel.*; //Allows you to refer to flixel objects in your code
	[SWF(width="640", height="480", backgroundColor="#000000")] //Set the size and color of the Flash file
	public class testWeb extends FlxGame
	{
		public function testWeb() 
		{
			super(640, 480, MenuState, 1, 20, 20);
		}
	}
}