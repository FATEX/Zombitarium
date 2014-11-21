package
{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxSprite;
	import flash.media.SoundMixer;
	import org.flixel.FlxButton;
	
	public class LoseState extends FlxState
	{
		[Embed(source = "lose_screen.png")] private var ImgBG:Class;
		[Embed(source = "bgm.mp3")]private var MySoundbg : Class; 
		private var soundbg : Sound; // not MySound! 
		private var myChannelbg:SoundChannel = new SoundChannel();
		private var bg: FlxSprite;
		private var levelBtn:FlxButton;
		
		override public function create():void
		{
			bg = new FlxSprite(0, 0, ImgBG);
			add(bg);
			
			soundbg = (new MySoundbg()) as Sound;
			if(PlayState.soundOn){
				myChannelbg = soundbg.play();
			}
			FlxG.mouse.show();
			
			levelBtn = new FlxButton(350, 500, "Level Select", function():void
			{
				FlxG.switchState(new LevelState());
			});
			levelBtn.color = 0xa3d370;
			add(levelBtn);
		}
		
		override public function update():void
		{
			if(FlxG.keys.justPressed("R"))
				resetGame();
			
			super.update();
		}
		
		private function resetGame():void{
			FlxG.switchState(new PlayState());
			SoundMixer.stopAll();
			
		}
		
	}
}
