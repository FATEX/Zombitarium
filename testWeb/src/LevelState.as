package
{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	
	import org.flixel.FlxButton;
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	
	public class LevelState extends FlxState
	{
		[Embed(source = "click.mp3")]private var MySound : Class; 		 
		private var sound : Sound; // not MySound! 
		private var myChannel:SoundChannel = new SoundChannel();
		
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
		
		
		override public function create():void
		{
			var t:FlxText;
			t = new FlxText(0,20,(FlxG.width),"Level Select");
			t.size = 64
			t.alignment = "center";
			add(t);
			
			level_0 = new FlxButton(200, 200, "1", function():void
			{
				PlayState.level = 0;
				FlxG.switchState(new PlayState());
				sound = (new MySound()) as Sound;
				myChannel = sound.play();
			});
			
			level_1 = new FlxButton(200, 230, "2", function():void
			{
				PlayState.level = 1;
				FlxG.switchState(new PlayState());
				sound = (new MySound()) as Sound;
				myChannel = sound.play();
			});
			
			level_2 = new FlxButton(200, 260, "3", function():void
			{
				PlayState.level = 2;
				FlxG.switchState(new PlayState());
				sound = (new MySound()) as Sound;
				myChannel = sound.play();
			});
			
			level_3 = new FlxButton(200, 290, "4", function():void
			{
				PlayState.level = 3;
				FlxG.switchState(new PlayState());
				sound = (new MySound()) as Sound;
				myChannel = sound.play();
			});
			
			level_4 = new FlxButton(200, 320, "5", function():void
			{
				PlayState.level = 4;
				FlxG.switchState(new PlayState());
				sound = (new MySound()) as Sound;
				myChannel = sound.play();
			});
			
			level_5 = new FlxButton(200, 350, "6", function():void
			{
				PlayState.level = 5;
				FlxG.switchState(new PlayState());
				sound = (new MySound()) as Sound;
				myChannel = sound.play();
			});
			
			level_6 = new FlxButton(400, 200, "7", function():void
			{
				PlayState.level = 6;
				FlxG.switchState(new PlayState());
				sound = (new MySound()) as Sound;
				myChannel = sound.play();
			});
			
			level_7 = new FlxButton(400, 230, "8", function():void
			{
				PlayState.level = 7;
				FlxG.switchState(new PlayState());
				sound = (new MySound()) as Sound;
				myChannel = sound.play();
			});
			
			level_8 = new FlxButton(400, 260, "9", function():void
			{
				PlayState.level = 8;
				FlxG.switchState(new PlayState());
				sound = (new MySound()) as Sound;
				myChannel = sound.play();
			});
			
			level_9 = new FlxButton(400, 290, "10", function():void
			{
				PlayState.level = 9;
				FlxG.switchState(new PlayState());
				sound = (new MySound()) as Sound;
				myChannel = sound.play();
			});
			level_10 = new FlxButton(400, 320, "11", function():void
			{
				PlayState.level = 10;
				FlxG.switchState(new PlayState());
				sound = (new MySound()) as Sound;
				myChannel = sound.play();
			});
			
			level_11 = new FlxButton(400, 350, "12", function():void
			{
				PlayState.level = 11;
				FlxG.switchState(new PlayState());
				sound = (new MySound()) as Sound;
				myChannel = sound.play();
			});
			
			level_12 = new FlxButton(600, 200, "13", function():void
			{
				PlayState.level = 12;
				FlxG.switchState(new PlayState());
				sound = (new MySound()) as Sound;
				myChannel = sound.play();
			});
			
			level_13 = new FlxButton(600, 230, "14", function():void
			{
				PlayState.level = 13;
				FlxG.switchState(new PlayState());
				sound = (new MySound()) as Sound;
				myChannel = sound.play();
			});
			
			level_14 = new FlxButton(600, 260, "15", function():void
			{
				PlayState.level = 14;
				FlxG.switchState(new PlayState());
				sound = (new MySound()) as Sound;
				myChannel = sound.play();
			});
			level_15 = new FlxButton(600, 290, "16", function():void
			{
				PlayState.level = 15;
				FlxG.switchState(new PlayState());
				sound = (new MySound()) as Sound;
				myChannel = sound.play();
			});
			
			level_16 = new FlxButton(600, 320, "17", function():void
			{
				PlayState.level = 16;
				FlxG.switchState(new PlayState());
				sound = (new MySound()) as Sound;
				myChannel = sound.play();
			});
			
			level_17 = new FlxButton(600, 350, "18", function():void
			{
				PlayState.level = 17;
				FlxG.switchState(new PlayState());
				sound = (new MySound()) as Sound;
				myChannel = sound.play();
			});
		
			
			FlxG.mouse.show();
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
			
		}
	}
}