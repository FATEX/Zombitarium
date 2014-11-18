package
{
	import flash.events.MouseEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	
	import org.flixel.FlxButton;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import flixel.util.FlxColor;

	//import flash.events.addEventListener;
	
	public class LevelState extends FlxState
	{
		[Embed(source = "lvlIMG.png")] private var ImgBG:Class;
		[Embed(source = "click.mp3")]private var MySound : Class; 		 
		private var sound : Sound; // not MySound! 
		private var myChannel:SoundChannel = new SoundChannel();
		private var btnFirst:Boolean = true;
		private var bg: FlxSprite;
		
		
		private var level_0;
		private var level_1;
		private var level_2;
		private var level_3;
		private var level_4;
		private var level_5;
		private var level_6;
		private var level_7;
		private var level_8;
		private var level_9;
		private var level_10;
		private var level_11;
		private var level_12;
		private var level_13;
		private var level_14;
		private var level_15;
		private var level_16;
		private var level_17;
		private var level_18;
		private var cred;
		
		
		override public function create():void
		{
			bg = new FlxSprite(0, 0, ImgBG);
			add(bg);
			var btnC = 0xa3d370;
			
//			var t:FlxText;
//			t = new FlxText(0,20,(FlxG.width),"Level Select");
//			t.size = 64
//			t.alignment = "center";
//			add(t);
//			

			
			level_0 = new FlxButton(170, 200, "1", function():void
			{
				sound = (new MySound()) as Sound;
				if(PlayState.soundOn){
					myChannel = sound.play();
				}
				PlayState.level = 0;
				FlxG.fade(0xff000000, 0.5, on_fade_completed);
			});
			level_0.color = btnC;
			
			level_1 = new FlxButton(170, 230, "2", function():void
			{
				PlayState.level = 1;
				sound = (new MySound()) as Sound;
				if(PlayState.soundOn){
					myChannel = sound.play();
				}
				FlxG.fade(0xff000000, 0.5, on_fade_completed);
			});
			level_1.color = btnC;
			
			level_2 = new FlxButton(170, 260, "3", function():void
			{
				PlayState.level = 2;
				sound = (new MySound()) as Sound;
				if(PlayState.soundOn){
					myChannel = sound.play();
				}
				FlxG.fade(0xff000000, 0.5, on_fade_completed);
			});
			level_2.color = btnC;
			
			level_3 = new FlxButton(170, 290, "4", function():void
			{
				PlayState.level = 3;
				sound = (new MySound()) as Sound;
				if(PlayState.soundOn){
					myChannel = sound.play();
				}
				FlxG.fade(0xff000000, 0.5, on_fade_completed);
			});
			level_3.color = btnC;
			
			level_4 = new FlxButton(170, 320, "5", function():void
			{
				PlayState.level = 4;
				sound = (new MySound()) as Sound;
				if(PlayState.soundOn){
					myChannel = sound.play();
				}
				FlxG.fade(0xff000000, 0.5, on_fade_completed);
			});
			level_4.color = btnC;
			
			level_5 = new FlxButton(170, 350, "6", function():void
			{
				PlayState.level = 5;
				sound = (new MySound()) as Sound;
				if(PlayState.soundOn){
					myChannel = sound.play();
				}
				FlxG.fade(0xff000000, 0.5, on_fade_completed);
			});
			level_5.color = btnC;
			
			level_6 = new FlxButton(370, 200, "7", function():void
			{
				PlayState.level = 6;
				sound = (new MySound()) as Sound;
				if(PlayState.soundOn){
					myChannel = sound.play();
				}
				FlxG.fade(0xff000000, 0.5, on_fade_completed);
			});
			level_6.color = btnC;
			
			level_7 = new FlxButton(370, 230, "8", function():void
			{
				PlayState.level = 7;
				sound = (new MySound()) as Sound;
				if(PlayState.soundOn){
					myChannel = sound.play();
				}
				SoundMixer.stopAll();
				FlxG.fade(0xff000000, 0.5, on_fade_completed);
			});
			level_7.color = btnC;
			
			level_8 = new FlxButton(370, 260, "9", function():void
			{
				PlayState.level = 8;
				sound = (new MySound()) as Sound;
				if(PlayState.soundOn){
					myChannel = sound.play();
				}
				SoundMixer.stopAll();
				FlxG.fade(0xff000000, 0.5, on_fade_completed);

			});
			level_8.color = btnC;
			
			level_9 = new FlxButton(370, 290, "10", function():void
			{
				PlayState.level = 9;
				sound = (new MySound()) as Sound;
				if(PlayState.soundOn){
					myChannel = sound.play();
				}
				FlxG.fade(0xff000000, 0.5, on_fade_completed);
			});
			level_9.color = btnC;
			
			level_10 = new FlxButton(370, 320, "11", function():void
			{
				PlayState.level = 10;
				sound = (new MySound()) as Sound;
				if(PlayState.soundOn){
					myChannel = sound.play();
				}					
				FlxG.fade(0xff000000, 0.5, on_fade_completed);
			});
			level_10.color = btnC;
			
			level_11 = new FlxButton(370, 350, "12", function():void
			{
				PlayState.level = 11;
				sound = (new MySound()) as Sound;
				if(PlayState.soundOn){
					myChannel = sound.play();
				}
				FlxG.fade(0xff000000, 0.5, on_fade_completed);
			});
			level_11.color = btnC;
			
			level_12 = new FlxButton(570, 200, "13", function():void
			{
				PlayState.level = 12;
				sound = (new MySound()) as Sound;
				if(PlayState.soundOn){
					myChannel = sound.play();
				}
				FlxG.fade(0xff000000, 0.5, on_fade_completed);
			});
			level_12.color = btnC;
			
			level_13 = new FlxButton(570, 230, "14", function():void
			{
				PlayState.level = 13;
				sound = (new MySound()) as Sound;
				if(PlayState.soundOn){
					myChannel = sound.play();
				}
				FlxG.fade(0xff000000, 0.5, on_fade_completed);
			});
			level_13.color = btnC;
			
			level_14 = new FlxButton(570, 260, "15", function():void
			{
				PlayState.level = 14;
				sound = (new MySound()) as Sound;
				if(PlayState.soundOn){
					myChannel = sound.play();
				}
				FlxG.fade(0xff000000, 0.5, on_fade_completed);
			});
			level_14.color = btnC;
			
			level_15 = new FlxButton(570, 290, "16", function():void
			{
				PlayState.level = 15;
				sound = (new MySound()) as Sound;
				if(PlayState.soundOn){
					myChannel = sound.play();
				}
				FlxG.fade(0xff000000, 0.5, on_fade_completed);
			});
			level_15.color = btnC;
			
<<<<<<< HEAD
//			level_16 = new FlxButton(570, 320, "17", function():void
//			{
//				PlayState.level = 16;
//				sound = (new MySound()) as Sound;
//				myChannel = sound.play();
//				FlxG.fade(0xff000000, 0.5, on_fade_completed);
//			});
//			level_16.color = btnC;
//			
//			level_17 = new FlxButton(570, 350, "18", function():void
//			{
//				PlayState.level = 17;
//				//txt = "18";
//				sound = (new MySound()) as Sound;
//				myChannel = sound.play();
//				FlxG.fade(0xff000000, 0.5, on_fade_completed);
//			});
//			level_17.color = btnC;
			

			cred = new FlxButton(370, 500, "CREDITS", function():void
			{
				sound = (new MySound()) as Sound;
				myChannel = sound.play();
				FlxG.fade(0xff000000, 0.5, to_credits);
			});
			cred.color = 0xcef5ae;
			
			FlxG.mouse.show();
		}
		
		public function on_fade_completed():void
		{
			// playing the game itself
			FlxG.switchState(new PlayState());
			SoundMixer.stopAll();
		}
		
		public function to_credits():void
		{
			// playing the game itself
			FlxG.switchState(new CreditState());
			//SoundMixer.stopAll();
		}
		
		
		override public function update():void
		{
			super.update();
			
			add(level_0);
			add(level_1);
			add(level_2);
			add(level_3);
			add(level_4);
			add(level_5);
			add(level_6);
			add(level_7);
			add(level_8);
			add(level_9);
			add(level_10);
			add(level_11);
			add(level_12);
			add(level_13);
			add(level_14);
			add(level_15);
			add(level_16);
			add(level_17);
			add(level_18);
			add(cred);
			
			if (btnFirst == false) {
				SoundMixer.stopAll();
			}
			
		}
	}
}