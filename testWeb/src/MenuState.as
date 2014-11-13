package
{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	import org.flixel.FlxText;

	public class MenuState extends FlxState
	{
		
		override public function create():void
		{
			var t:FlxText;
			t = new FlxText(0,(FlxG.height/2-20),(FlxG.width),"Zombify");
			t.size = 64
			t.alignment = "center";
			add(t);
			t = new FlxText((FlxG.width/2-100),(FlxG.height-50),200,"click to play");
			t.size = 24;
			t.alignment = "center";
			add(t);
			
			FlxG.mouse.show();
		}

		override public function update():void
		{
			super.update();

			if(FlxG.mouse.justPressed())
				
				FlxG.switchState(new LevelState());
		}
	}
}
