package
{
	import flash.display.Sprite;
	import org.flixel.*; //Allows you to refer to flixel objects in your code
	[SWF(width="1200", height="1000", backgroundColor="#000000")] //Set the size and color of the Flash file
	public class testWeb extends FlxGame
	{
		public function testWeb() 
		{
			super(1200, 1000, MenuState, 2, 20, 20);
		}
	}
}