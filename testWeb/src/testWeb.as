package
{
	import flash.display.Sprite;
	
	import org.flixel.FlxGame; //Allows you to refer to flixel objects in your code

	[SWF(width="900", height="600", backgroundColor="#000000")] //Set the size and color of the Flash file


	public class testWeb extends FlxGame
	{
		public function testWeb() 
		{

			super(900, 600, MenuState, 1, 20, 20);
			if(!PlayState.isPageLoaded){
				PlayState.logger.recordPageLoad();
				PlayState.isPageLoaded = true;
				var myNum:Number = Math.floor(Math.random()*2) + 1;
				var value:Number = PlayState.logger.recordABTestValue(myNum);
				if(value == 1){
					PlayState.isABTesting = true;	
				}
				else{
					PlayState.isABTesting = false;
				}
				
			}

		}
	}
}