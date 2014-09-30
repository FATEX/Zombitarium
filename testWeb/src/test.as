package
{
	import flash.display.Sprite;
	import org.flixel.*; //Allows you to refer to flixel objects in your code
	[SWF(width="800", height="600", backgroundColor="#000000")] //Set the size and color of the Flash file
	
	public class test extends FlxGame
	{
		public function test() 
		{
			super(800,600,MenuState,2);;
		}
	}
}