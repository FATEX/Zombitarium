package
{
	import org.flixel.FlxGame;
	import org.flixel.FlxPath;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxTilemap;
	
	public class Zombie extends FlxSprite
	{
		[Embed(source="spaceman.png")] private static var ImgSpaceman:Class;
		private var xPos:int = 0;
		private var yPos:int = 0;
		private var width:int = 0;
		private var height:int = 0;
		private var xDrag: int = 0;
		private var yDrag: int = 0;
		private var xMaxVelocity: int = 0;
		private var yMaxVelocity: int = 0;
		//private var color: int = 0;
 		public function Zombie(xPos:int, yPos:int, width:int, height:int, xDrag:int, yDrag:int, xMaxVelocity:int, yMaxVelocity:int)
		{
			super(xPos,yPos);
			this.loadGraphic(ImgSpaceman, true, true, 16);
			//this.loadGraphic();
			this.xPos = xPos;
			this.yPos = yPos;
			this.width = width;
			this.height = height;
			this.xDrag = xDrag;
			this.yDrag = yDrag;
			this.xMaxVelocity = xMaxVelocity;
			this.yMaxVelocity = yMaxVelocity;
		}
		
		public function findNearestHuman(collisionMap:FlxTilemap, humanP:Array, zombieP:FlxPoint):int{
			var i:int = 0;
			var nearestPath:int = 10000;
			while(i < humanP.length){
				collisionMap.findPath(zombieP, humanP[i]);
				if(nearestPath > collisionMap.getPathLength())
					nearestPath = collisionMap.getPathLength();
			}
			return nearestPath;
		}
		
		public function attackNearestHuman(collisionMap:FlxTilemap, zombieP:FlxPoint, humanP:FlxPoint):void{
			//return collisionMap.findPath(zombieP, humanP);
			this.followPath(collisionMap.findPath(zombieP, humanP),50, PATH_FORWARD, true);
		}
		
		public function setColor(c:int):void{
			//super().color = c;
			this.color = c;
		}
		
		public function setImage(image:Class):void{
			this.loadGraphic(image, true, true, 16);
		}
		
		public function dieAnimation():void{
			this.destroy();
		}
	}
}