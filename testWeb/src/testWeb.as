package
{
	import flash.display.Sprite;
	import org.flixel.*; //Allows you to refer to flixel objects in your code
	[SWF(width="820", height="630", backgroundColor="#000000")] //Set the size and color of the Flash file
	public class testWeb extends FlxGame
	{
		public function testWeb() 
		{
			super(820, 630, MenuState, 4, 20, 20);
		}
	}
}