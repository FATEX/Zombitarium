package
{
	import objects.Human;
	
	import org.flixel.FlxGame;
	import org.flixel.FlxPath;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxTilemap;
	
	public class Zombie extends FlxSprite
	{

		[Embed(source="walk_nurse_front_dead.png")] private static var ImgSpaceman:Class;

		public var xPos:int = 0;
		public var yPos:int = 0;
		//private var width:int = 0;
		//private var height:int = 0;
		private var xDrag: int = 0;
		private var yDrag: int = 0;
		private var xMaxVelocity: int = 0;
		private var yMaxVelocity: int = 0;
		private var humanFollowing:Human;
		private var checkAgain:Boolean = true;
		//private var color: int = 0;
 		public function Zombie(xPos:int, yPos:int, width:int, height:int, xDrag:int, yDrag:int, xMaxVelocity:int, yMaxVelocity:int)
		{
			super(xPos,yPos);
			this.loadGraphic(ImgSpaceman, true, true, 16,16);
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
		
		public function findNearestHuman(collisionMap:FlxTilemap, humanP:Vector.<Human>, zombieP:FlxPoint):FlxPath{
			var i:int = 0;
			var minLength:int = int.MAX_VALUE;
			var path:FlxPath = null;
			var nearestPath: FlxPath = null;
			for(var j:int = 0; j<humanP.length;j++){
				var path2:FlxPath = collisionMap.findPath(zombieP, new FlxPoint(humanP[j].x+humanP[j].width/2, humanP[j].y+humanP[j].height/2), false);
				if(path2!=null){
					path=path2;
					this.humanFollowing=humanP[j];
					break;
				}
			}
			/*
			//path = collisionMap.findPath(zombieP, new FlxPoint(humanP[1].x, humanP[1].y), false);
			while(i < humanP.length){
				path = collisionMap.findPath(zombieP, new FlxPoint(humanP[i].x+humanP[i].width/2, humanP[i].y+humanP[i].height/2));
				if(path!=null){
					nearestPath=path;
				}
				//if(path != null && minLength > collisionMap.getPathLength()){
					//minLength = collisionMap.getPathLength();
					//nearestPath = path;
				//}
				i++;
			}*/
			return path;
		}
		
		/*public function attackNearestHuman(collisionMap:FlxTilemap, zombieP:FlxPoint, humanP:FlxPoint):void{
			//return collisionMap.findPath(zombieP, humanP);
			this.followPath(collisionMap.findPath(zombieP, humanP),50, PATH_FORWARD, true);
		}*/
		
		public function attackNearestHuman(collisionMap:FlxTilemap, path:FlxPath):void{
			if(path!=null){
				this.followPath(path,50, PATH_FORWARD, true);
			}
		}
		public function checkPath(collisionMap:FlxTilemap):void{
			if(this.humanFollowing!=null && collisionMap.findPath(new FlxPoint(this.x+this.width/2,this.y+this.height/2),new FlxPoint(this.humanFollowing.x+this.humanFollowing.width/2,this.humanFollowing.y+this.humanFollowing.height/2))==null){
				this.humanFollowing=null;
				this.stopFollowingPath(true);
				this.pathSpeed=0;
				this.velocity=new FlxPoint(0,0);
			}	
			this.checkAgain=true;
				
		}
		
		public function zombieUpdate(collisionMap:FlxTilemap, humanP:Vector.<Human>, zombieP:FlxPoint):void{
			if(this.humanFollowing!=null && humanP!=null && humanP.indexOf(this.humanFollowing)==-1){
				this.stopFollowingPath(true);
				this.pathSpeed=0;
				this.velocity=new FlxPoint(0,0);
				this.humanFollowing=null;
				this.attackNearestHuman(collisionMap,this.findNearestHuman(collisionMap,humanP,zombieP));
			}
			if(this.pathSpeed==0 && this.checkAgain){
				var path:FlxPath = this.findNearestHuman(collisionMap,humanP,zombieP);
				if(path!=null)
					this.attackNearestHuman(collisionMap,path);
				else{
					this.checkAgain=false;
				}
			}
			/*if(this.humanFollowing!=null && collisionMap.findPath(zombieP,new FlxPoint(this.humanFollowing.x+this.humanFollowing.width/2,this.humanFollowing.y+this.humanFollowing.height/2))==null){
				this.humanFollowing=null;
				this.stopFollowingPath(true);
				this.pathSpeed=0;
				this.velocity=new FlxPoint(0,0);
				this.attackNearestHuman(collisionMap,this.findNearestHuman(collisionMap,humanP,zombieP));
			}	*/
			
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