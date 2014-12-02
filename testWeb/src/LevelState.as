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

	//import flixel.util.FlxColor;

	//import flash.events.addEventListener;
	
	public class LevelState extends FlxState
	{
		[Embed(source = "level_select.png")] private var ImgBG:Class;
		[Embed(source = "test1.png")] private var ImgBut1:Class;
		[Embed(source = "l2.png")] private var ImgBut2:Class;
		[Embed(source = "l3.png")] private var ImgBut3:Class;
		[Embed(source = "l4.png")] private var ImgBut4:Class;
		[Embed(source = "l5.png")] private var ImgBut5:Class;
		[Embed(source = "l6.png")] private var ImgBut6:Class;
		[Embed(source = "l7.png")] private var ImgBut7:Class;
		[Embed(source = "l8.png")] private var ImgBut8:Class;
		[Embed(source = "l9.png")] private var ImgBut9:Class;
		[Embed(source = "l10.png")] private var ImgBut10:Class;
		[Embed(source = "l11.png")] private var ImgBut11:Class;
		[Embed(source = "l12.png")] private var ImgBut12:Class;
		[Embed(source = "l13.png")] private var ImgBut13:Class;
		[Embed(source = "l14.png")] private var ImgBut14:Class;
		[Embed(source = "l15.png")] private var ImgBut15:Class;
		[Embed(source = "l16.png")] private var ImgBut16:Class;
		[Embed(source = "c.png")] private var ImgCredit:Class;
		
		
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
			var btnC = 0xfafafa;
			var one = 130;
			var two = 280;
			var three = 430;
			var four = 580;
			
//			var t:FlxText;
//			t = new FlxText(0,20,(FlxG.width),"Level Select");
//			t.size = 64
//			t.alignment = "center";
//			add(t);
//			

			
			level_0 = new FlxButton(one, 200, "", function():void
			{
				sound = (new MySound()) as Sound;
				if(PlayState.soundOn){
					myChannel = sound.play();
				}
				PlayState.level = 0;
				FlxG.fade(0xff000000, 0.5, on_fade_completed);
			});
			level_0.color = btnC;
			level_0.loadGraphic(ImgBut1);
			
			level_1 = new FlxButton(one, 270, "", function():void
			{
				PlayState.level = 1;
				sound = (new MySound()) as Sound;
				if(PlayState.soundOn){
					myChannel = sound.play();
				}
				FlxG.fade(0xff000000, 0.5, on_fade_completed);
			});
			level_1.color = btnC;
			level_1.loadGraphic(ImgBut2);
			
			level_2 = new FlxButton(one, 340, "", function():void
			{
				PlayState.level = 2;
				sound = (new MySound()) as Sound;
				if(PlayState.soundOn){
					myChannel = sound.play();
				}
				FlxG.fade(0xff000000, 0.5, on_fade_completed);
			});
			level_2.color = btnC;
			level_2.loadGraphic(ImgBut3);
			
			level_3 = new FlxButton(one, 410, "", function():void
			{
				PlayState.level = 3;
				sound = (new MySound()) as Sound;
				if(PlayState.soundOn){
					myChannel = sound.play();
				}
				FlxG.fade(0xff000000, 0.5, on_fade_completed);
			});
			level_3.color = btnC;
			level_3.loadGraphic(ImgBut4);
			
			level_4 = new FlxButton(two, 200, "", function():void
			{
				PlayState.level = 4;
				sound = (new MySound()) as Sound;
				if(PlayState.soundOn){
					myChannel = sound.play();
				}
				FlxG.fade(0xff000000, 0.5, on_fade_completed);
			});
			level_4.color = btnC;
			level_4.loadGraphic(ImgBut5);
			
			level_5 = new FlxButton(two, 270, "", function():void
			{
				PlayState.level = 5;
				sound = (new MySound()) as Sound;
				if(PlayState.soundOn){
					myChannel = sound.play();
				}
				FlxG.fade(0xff000000, 0.5, on_fade_completed);
			});
			level_5.color = btnC;
			level_5.loadGraphic(ImgBut6);
			
			level_6 = new FlxButton(two, 340, "", function():void
			{
				PlayState.level = 6;
				sound = (new MySound()) as Sound;
				if(PlayState.soundOn){
					myChannel = sound.play();
				}
				FlxG.fade(0xff000000, 0.5, on_fade_completed);
			});
			level_6.color = btnC;
			level_6.loadGraphic(ImgBut7);
			
			level_7 = new FlxButton(two, 410, "", function():void
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
			level_7.loadGraphic(ImgBut8);
			
			level_8 = new FlxButton(three, 200, "", function():void
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
			level_8.loadGraphic(ImgBut9);
			
			level_9 = new FlxButton(three, 270, "", function():void
			{
				PlayState.level = 9;
				sound = (new MySound()) as Sound;
				if(PlayState.soundOn){
					myChannel = sound.play();
				}
				FlxG.fade(0xff000000, 0.5, on_fade_completed);
			});
			level_9.color = btnC;
			level_9.loadGraphic(ImgBut10);
			
			level_10 = new FlxButton(three, 340, "", function():void
			{
				PlayState.level = 10;
				sound = (new MySound()) as Sound;
				if(PlayState.soundOn){
					myChannel = sound.play();
				}					
				FlxG.fade(0xff000000, 0.5, on_fade_completed);
			});
			level_10.color = btnC;
			level_10.loadGraphic(ImgBut11);
			
			level_11 = new FlxButton(three, 410, "", function():void
			{
				PlayState.level = 11;
				sound = (new MySound()) as Sound;
				if(PlayState.soundOn){
					myChannel = sound.play();
				}
				FlxG.fade(0xff000000, 0.5, on_fade_completed);
			});
			level_11.color = btnC;
			level_11.loadGraphic(ImgBut12);
			
			level_12 = new FlxButton(four, 200, "", function():void
			{
				PlayState.level = 12;
				sound = (new MySound()) as Sound;
				if(PlayState.soundOn){
					myChannel = sound.play();
				}
				FlxG.fade(0xff000000, 0.5, on_fade_completed);
			});
			level_12.color = btnC;
			level_12.loadGraphic(ImgBut13);
			
			level_13 = new FlxButton(four, 270, "", function():void
			{
				PlayState.level = 13;
				sound = (new MySound()) as Sound;
				if(PlayState.soundOn){
					myChannel = sound.play();
				}
				FlxG.fade(0xff000000, 0.5, on_fade_completed);
			});
			level_13.color = btnC;
			level_13.loadGraphic(ImgBut14);
			
			level_14 = new FlxButton(four, 340, "", function():void
			{
				PlayState.level = 14;
				sound = (new MySound()) as Sound;
				if(PlayState.soundOn){
					myChannel = sound.play();
				}
				FlxG.fade(0xff000000, 0.5, on_fade_completed);
			});
			level_14.color = btnC;
			level_14.loadGraphic(ImgBut15);
			
			level_15 = new FlxButton(four, 410, "", function():void
			{
				PlayState.level = 15;
				sound = (new MySound()) as Sound;
				if(PlayState.soundOn){
					myChannel = sound.play();
				}
				FlxG.fade(0xff000000, 0.5, on_fade_completed);
			});
			level_15.color = btnC;
			level_15.loadGraphic(ImgBut16);
						

			cred = new FlxButton(340, 500, "", function():void
			{
				sound = (new MySound()) as Sound;
				myChannel = sound.play();
				FlxG.fade(0xff000000, 0.5, to_credits);
			});
			cred.color = 0xcef5ae;
			cred.loadGraphic(ImgCredit);
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
			
			
		}
	}
}