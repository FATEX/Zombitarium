package objects
{
	import org.flixel.FlxSprite;
	
	public class Human extends FlxSprite
	{
		private const TILE_WIDTH:uint = 16;
		private const TILE_HEIGHT:uint = 16;
		[Embed(source="spaceman.png")] private static var ImgSpaceman:Class;
		
		//path array of flxpoints
		//detect() zombie type
		//update()
		//	boolean have detected someone , follow path or follow something else
		
		public var routes:Vector.<FlxSprite>;
		
		public function Human()
		{
			super(7*TILE_WIDTH, 11*TILE_HEIGHT);
			this.loadGraphic(ImgSpaceman, true, true, 16);
			
			//bounding box tweaks
			this.width = 14;
			this.height = 14;
			this.offset.x = 1;
			this.offset.y = 1;
			
			//basic player physics
			this.drag.x = 640;
			this.drag.y = 640;
			//player.acceleration.y = 420;
			this.maxVelocity.x = 80;
			this.maxVelocity.y = 80;
			
			//animations
			this.addAnimation("idle", [0]);
			this.addAnimation("run", [1, 2, 3, 0], 12);
			this.addAnimation("jump", [4]);
			this.color=0x066000;
			routes
		}
	}
	
	public function update()
	{
		routes
	}
}