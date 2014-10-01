package
{
	import org.flixel.*;
	[SWF(width="820", height="630", backgroundColor="#000000")]
	[Frame(factoryClass="Preloader")]

	public class Main extends FlxGame
	{
		public function Main()
		{
			super(820, 630, MenuState, 2, 20, 20);
		}
	}
}
