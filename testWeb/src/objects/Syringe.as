package objects
{
	import org.flixel.FlxSprite;

	public class Syringe extends FlxSprite
	{
		private const TILE_WIDTH:uint = 16;
		private const TILE_HEIGHT:uint = 16;
		private var angle1:int;
		[Embed(source="syringe_useSUPERTINY.png")] private static var ImgSpaceman:Class;
		
		public function Syringe(direction:int, xPos:int, yPos:int)
		{
			var x:int = xPos;
			var y:int = yPos;
			if(direction == 0){
				x = x+4;
			}
			else if(direction == 180){
				x = x+4;
				y = y+8;
			}
			else if (direction == 90){
				x = x+8;
				y = y+7;
			}
			else if(direction == -90){
				x = x-4;
				y = y+7;
			}
			super(x,y);
			super.loadGraphic(ImgSpaceman, true, true, 8, 2.5);
			//bounding box tweaks
			super.width = 8;
			super.height =2.5;
			super.offset.x = 1;
			super.offset.y = 1;
			
			//basic player physics
			super.drag.x = 200;
			super.drag.y = 200;
			//player.acceleration.y = 420;
			super.maxVelocity.x = 80;
			super.maxVelocity.y = 80;
			//animations
			//super.addAnimation("run", [1, 2, 3, 0], 12);
			angle1 = direction;
		}
		
		public function updatePos(rate:int){
			if(angle1 == 0){
				this.acceleration.y -= rate;
			}
			if(angle1 == 90){
				this.acceleration.x += rate
			}
			if(angle1 == 180){
				this.acceleration.y += rate
			}
			if(angle1 == -90){
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