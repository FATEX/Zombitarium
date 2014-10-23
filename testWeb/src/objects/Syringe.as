package objects
{
	import org.flixel.FlxSprite;

	public class Syringe extends FlxSprite
	{

		private const TILE_WIDTH:uint = 100;
		private const TILE_HEIGHT:uint = 100;
		private var angle1:Number;
		private var playerThrowing:Boolean = false;
		[Embed(source="syringe_use.png")] private static var ImgSpaceman:Class;
		
		public function Syringe(direction:int, xPos:int, yPos:int, xVect:Number,yVect:Number)
		{
			var x:int = xPos;
			var y:int = yPos;
			if(direction == 0){
				x = x - (TILE_WIDTH*7/8)/4;
			}
			else if(direction == 180){
				x = x - (TILE_WIDTH*7/8)/4;
				y = y+(TILE_WIDTH*7/8);
			}
			else if (direction == 90){
				x = x+TILE_WIDTH*7/8;
				y = y+(TILE_WIDTH*7/8)/4;
			}
			else if(direction == -90){
				x = x-(TILE_WIDTH*7/8)/2;
				y = y+(TILE_WIDTH*7/8)/4;
			}
			super(x,y);
			super.loadGraphic(ImgSpaceman, true, true, 44, 9);
			//bounding box tweaks
			super.width = 8;
			super.height =2.5;
			super.offset.x = 1;
			super.offset.y = 1;
			
			//basic player physics
			super.drag.x = 0;
			super.drag.y = 0;
			//player.acceleration.y = 420;
			super.maxVelocity.x = 800;
			super.maxVelocity.y = 800;
			this.acceleration.x=0;
			this.acceleration.y=0;
			if(xVect!=0 && yVect!=0){
				this.velocity.x=xVect;
				this.velocity.y=yVect;
			}
			else{
				this.playerThrowing=true;
			}
			//animations
			//super.addAnimation("run", [1, 2, 3, 0], 12);
			angle1 = direction;
		}
		
		public function updatePos(rate:int){
			//angle1 = angle1 +90;
			angle1 = angle1*0.0174532925;
			if(this.playerThrowing){
				this.acceleration.x += Math.sin(angle1)*rate;
				this.acceleration.y -= Math.cos(angle1)*rate;
			}
			//angle1 = angle1+90;
			/*if(angle1<0 && angle1 >=-90){
				this.acceleration.x += rate*Math.sin(angle1);
				this.acceleration.y -= rate*Math.cos(angle1);
			}
			if(angle1<=-90 && angle1 >-180){
				this.acceleration.x += rate*Math.sin(angle1);
				this.acceleration.y -= rate*Math.cos(angle1);
			}
			if(angle1>=0 && angle1 < 90){
				this.acceleration.x += rate*Math.sin(angle1);
				this.acceleration.y -= rate*Math.cos(angle1);
			}
			if(angle1>=90 && angle1 < 180){
				this.acceleration.x += rate*Math.sin(angle1);
				this.acceleration.y -= rate*Math.cos(angle1);
			}*/
			
			//this.acceleration.y += 100*Math.cos(angle1);
			/*if(angle1 == 0){
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
			}*/
			
		}
		
		public function explode():void{
			//Play Animation here
		}
		public function destory():void{
			super.destroy();
		}
		
	}
}