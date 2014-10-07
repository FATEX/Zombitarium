package
{
	import flash.display.Sprite;
	import org.flixel.*; //Allows you to refer to flixel objects in your code
	[SWF(width="1500", height="1500", backgroundColor="#000000")] //Set the size and color of the Flash file

	public class testWeb extends FlxGame
	{
		public function testWeb() 
		{
			super(1500, 1500, MenuState, 2, 20, 20);

		}
	}
}