package objects
{
	import Key;
	
	public class Janitor extends Human
	{
		[Embed(source="walk_nurse_front.png")] private static var ImgSpaceman:Class;
		
		public function Janitor(originX:Number, originY:Number)
		{
			super(originX, originY);
			this.originX=originX;
			this.originY=originY;
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
			super.addAnimation("idle", [0]);
			super.addAnimation("run", [1, 2, 3, 0], 12);
			super.addAnimation("jump", [4]);
		}
		
		public function die() {
			if (this.alive == false) {
				
				
			}
		}
	}
}