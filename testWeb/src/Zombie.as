package
{
	import org.flixel.FlxGame;
	import org.flixel.FlxPath;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxTilemap;

	[SWF(width="400", height="300", backgroundColor="#000000")]
	[Frame(factoryClass="Przombier")]
	
	public class Zombie extends FlxSprite
	{
		[Embed(source="spaceman.png")] private static var ImgSpaceman:Class;
		private var x:int = 0;
		private var y:int = 0;
		private var width:int = 0;
		private var height:int = 0;
		private var xDrag: int = 0;
		private var yDrag: int = 0;
		private var xMaxVelocity: int = 0;
		private var yMaxVelocity: int = 0;
		//private var color: int = 0;
 		public function Zombie(x:int, y:int, width:int, height:int, xDrag:int, yDrag:int, xMaxVelocity:int, yMaxVelocity:int)
		{
			super(x,y);
			this.loadGraphic(ImgSpaceman, true, true, 16);
			//this.loadGraphic();
			this.x = x;
			this.y = y;
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
		
		public function attackNearestHuman(collisionMap:FlxTilemap, zombieP:FlxPoint, humanP:FlxPoint):FlxPath{
			return collisionMap.findPath(zombieP, humanP);
		}
		
		public function setColor(c:int):void{
			//super().color = c;
			this.color = c;
		}
		
		public function setImage(image:Class):void{
			this.loadGraphic(image, true, true, 16);
		}
		
		public function dieAnimation():void{
			
		}
	}
}