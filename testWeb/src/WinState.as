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
	
	public class WinState extends FlxState
	{
		[Embed(source = "win_screen.png")] private var ImgBG:Class;
		[Embed(source = "bLevels.png")] private var BtnLevels:Class;
		[Embed(source = "bReplay.png")] private var BtnReplay:Class;

		[Embed(source = "bgm.mp3")]private var MySoundbg : Class; 
		private var soundbg : Sound; // not MySound! 
		private var myChannelbg:SoundChannel = new SoundChannel();
		private var bg: FlxSprite;
		private var levelBtn:FlxButton;
		private var replayBtn:FlxButton;
		
		override public function create():void
		{
			
			bg = new FlxSprite(0, 0, ImgBG);
			add(bg);
//			
//			soundbg = (new MySoundbg()) as Sound;
//			if(PlayState.soundOn){
//				myChannelbg = soundbg.play();
//			}
			FlxG.mouse.show();
			
			levelBtn = new FlxButton(400, 500, "Level Select", function():void
			{
				FlxG.switchState(new LevelState());
			});
			levelBtn.color = 0xa3d370;
			levelBtn.loadGraphic(BtnLevels);
			add(levelBtn);
			
			replayBtn = new FlxButton(300, 500, "Replay", function():void
			{
				FlxG.switchState(new PlayState());
				SoundMixer.stopAll();
			});
			replayBtn.color = 0xa3d370;
			replayBtn.loadGraphic(BtnReplay);
			add(replayBtn);
		}
		
		override public function update():void
		{
			if(FlxG.keys.justPressed("R"))
				resetGame();

			super.update();
		}
		
		private function resetGame():void{
			PlayState.level++; 
			PlayState.level = PlayState.level%16;
			FlxG.switchState(new PlayState());
			SoundMixer.stopAll();
			
		}
		
	}
}
