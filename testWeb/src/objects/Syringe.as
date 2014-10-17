package objects
{
	import org.flixel.FlxSprite;

	public class Syringe extends FlxSprite
	{
		private const TILE_WIDTH:uint = 16;
		private const TILE_HEIGHT:uint = 16;
		private var angle:int;
		[Embed(source="spaceman.png")] private static var ImgSpaceman:Class;
		
		public function Syringe(direction:int, xPos:int, yPos:int)
		{
			super(xPos,yPos);
			super.loadGraphic(ImgSpaceman, true, true, 16);
			//bounding box tweaks
			super.width = 14;
			super.height = 14;
			super.offset.x = 1;
			super.offset.y = 1;
			
			//basic player physics
			super.drag.x = 640;
			super.drag.y = 640;
			//player.acceleration.y = 420;
			super.maxVelocity.x = 80;
			super.maxVelocity.y = 80;
			
			//animations
			super.addAnimation("run", [1, 2, 3, 0], 12);
			angle = direction;
		}
		
		public function updatePos(rate:int){
			if(angle == 0){
				this.acceleration.y -= rate;
			}
			if(angle == 90){
				this.acceleration.x += rate
			}
			if(angle == 180){
				this.acceleration.y += rate
			}
			if(angle == -90){
				this.acceleration.x -= rate
			}
			
		}
		
		public function explode():void{
			//Play Animation here
		}
		public function destory():void{
			super.destroy();
		}
		
	}
}