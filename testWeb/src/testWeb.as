package
{
	import flash.display.Sprite;
	import org.flixel.*; //Allows you to refer to flixel objects in your code

	[SWF(width="900", height="600", backgroundColor="#000000")] //Set the size and color of the Flash file


	public class testWeb extends FlxGame
	{
		public function testWeb() 
		{

			super(900, 600, MenuState, 1, 20, 20);
			if(!PlayState.isPageLoaded){
				PlayState.logger.recordPageLoad();
				PlayState.isPageLoaded = true;
			}

		}
	}
}