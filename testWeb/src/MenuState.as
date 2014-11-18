package
{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	import org.flixel.FlxText;

	public class MenuState extends FlxState
	{
		[Embed(source = "bgm.mp3")]private var MySoundbg : Class; 		 
		private var soundbg : Sound; // not MySound! 
		private var myChannelbg:SoundChannel = new SoundChannel();
		
		override public function create():void
		{
			var t:FlxText;
			t = new FlxText(0,(FlxG.height/2-20),(FlxG.width),"Zombify");
			t.size = 64
			t.alignment = "center";
			add(t);
			t = new FlxText(0,(FlxG.height/2+100),(FlxG.width),"PRESS SPACE TO START");
			t.size = 24;
			t.alignment = "center";
			add(t);
			soundbg = (new MySoundbg()) as Sound;
			if(PlayState.soundOn){
				myChannelbg = soundbg.play();
			}
			FlxG.mouse.show();
		}

		override public function update():void
		{
			

			if(FlxG.keys.pressed("SPACE"))
				FlxG.fade(0xff000000, 1, on_fade_completed);
				//FlxG.switchState(new LevelState());
			super.update();
		}
		public function on_fade_completed():void
		{
			// playing the game itself
			FlxG.switchState(new LevelState());
		}
	}
}
