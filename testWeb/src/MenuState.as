package
{
	import org.flixel.*;

	public class MenuState extends FlxState
	{
		override public function create():void
		{
			var t:FlxText;
			t = new FlxText(0,(FlxG.height/2-20)/2,(FlxG.width)/2,"Zombify");
			t.size = 32;
			t.alignment = "center";
			add(t);
			t = new FlxText((FlxG.width/2-100)/2,(FlxG.height-50)/2,200,"click to play");
			t.size = 16;
			t.alignment = "center";
			add(t);
			
			FlxG.mouse.show();
		}

		override public function update():void
		{
			super.update();

			if(FlxG.mouse.justPressed())
				FlxG.switchState(new PlayState());
		}
	}
}
