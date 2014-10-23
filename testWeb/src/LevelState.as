package
{
	import org.flixel.FlxButton;
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	
	public class LevelState extends FlxState
	{
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
		
		override public function create():void
		{
			var t:FlxText;
			t = new FlxText(0,20,(FlxG.width),"Level Select");
			t.size = 64
			t.alignment = "center";
			add(t);
			
			level_0 = new FlxButton(300, 200, "1", function():void
			{
				PlayState.level = 0;
				FlxG.switchState(new PlayState());
			});
			
			level_1 = new FlxButton(300, 230, "2", function():void
			{
				PlayState.level = 1;
				FlxG.switchState(new PlayState());
			});
			
			level_2 = new FlxButton(300, 260, "3", function():void
			{
				PlayState.level = 2;
				FlxG.switchState(new PlayState());
			});
			
			level_3 = new FlxButton(300, 290, "4", function():void
			{
				PlayState.level = 3;
				FlxG.switchState(new PlayState());
			});
			
			level_4 = new FlxButton(300, 320, "5", function():void
			{
				PlayState.level = 4;
				FlxG.switchState(new PlayState());
			});
			
			level_5 = new FlxButton(500, 200, "6", function():void
			{
				PlayState.level = 5;
				FlxG.switchState(new PlayState());
			});
			
			level_6 = new FlxButton(500, 230, "7", function():void
			{
				PlayState.level = 6;
				FlxG.switchState(new PlayState());
			});
			
			level_7 = new FlxButton(500, 260, "8", function():void
			{
				PlayState.level = 7;
				FlxG.switchState(new PlayState());
			});
			
			level_8 = new FlxButton(500, 290, "9", function():void
			{
				PlayState.level = 8;
				FlxG.switchState(new PlayState());
			});
			
			level_9 = new FlxButton(500, 320, "10", function():void
			{
				PlayState.level = 9;
				FlxG.switchState(new PlayState());
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
			
		}
	}
}