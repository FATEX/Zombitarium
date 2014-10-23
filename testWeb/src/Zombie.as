package
{
	import objects.Human;
	
	import org.flixel.FlxGame;
	import org.flixel.FlxPath;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxTilemap;
	
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	public class Zombie extends FlxSprite
	{
		private const TILE_WIDTH:uint = 100;
		private const TILE_HEIGHT:uint =100;

		[Embed(source="walk_nurse_front_dead_100.png")] private static var ImgSpaceman:Class;
		[Embed(source="walk_zombie_front_100.png")] private static var ImgPlayer:Class;
		[Embed(source="walk_nurse_front_100.png")] private static var ImgNurse:Class;

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
		
		public var isDisguised:Boolean = false;
		//private var color: int = 0;
 		public function Zombie(xPos:int, yPos:int, width:int, height:int, xDrag:int, yDrag:int, xMaxVelocity:int, yMaxVelocity:int)
		{
			super(xPos,yPos);
			this.loadGraphic(ImgSpaceman, true, true, TILE_WIDTH,TILE_HEIGHT);
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
				if(humanP[i].alive){
					var path2:FlxPath = collisionMap.findPath(zombieP, new FlxPoint(humanP[j].x+humanP[j].width/2, humanP[j].y+humanP[j].height/2), false);
					if(path2!=null && path2.nodes.length<minLength){
						path=path2;
						this.humanFollowing=humanP[j];
						minLength = path2.nodes.length;
					}
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
				this.followPath(path,50/16*TILE_WIDTH, PATH_FORWARD, true);
			}
		}
		public function checkPath(collisionMap:FlxTilemap):void{
			/*if(this.humanFollowing!=null){
				var pathChecker:FlxPath =collisionMap.findPath(new FlxPoint(this.x+this.width/2,this.y+this.height/2),new FlxPoint(this.humanFollowing.x+this.humanFollowing.width/2,this.humanFollowing.y+this.humanFollowing.height/2));
				if(pathChecker==null){
					this.humanFollowing=null;
					this.stopFollowingPath(true);
					this.pathSpeed=0;
					this.velocity=new FlxPoint(0,0);
				}
				if(pathChecker!=null){
					path = pathChecker;
					this.stopFollowingPath(true);
					this.attackNearestHuman(collisionMap,path);
				}
			}*/
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
			if(this.humanFollowing!=null && humanP!=null && humanP.indexOf(this.humanFollowing)!=-1){
				this.stopFollowingPath(true);
				this.pathSpeed=0;
				this.velocity=new FlxPoint(0,0);
				path = collisionMap.findPath(zombieP, new FlxPoint(humanFollowing.x+humanFollowing.width/2, humanFollowing.y+humanFollowing.height/2), false);
				this.attackNearestHuman(collisionMap,path);
			}
			if(this.checkAgain){
				this.stopFollowingPath(true);
				this.pathSpeed=0;
				this.velocity=new FlxPoint(0,0);
				this.humanFollowing=null;
				var path:FlxPath = this.findNearestHuman(collisionMap,humanP,zombieP);
				if(path!=null){
					this.attackNearestHuman(collisionMap,path);
					this.checkAgain=false;
				}
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
			this.loadGraphic(image, true, true, TILE_WIDTH,TILE_HEIGHT);
		}
		
		public function dieAnimation():void{
			this.destroy();
		}
		
		public function disguiseOFF():void{
			if(isDisguised){
				isDisguised=false;
				this.loadGraphic(ImgPlayer, true, true, TILE_WIDTH,TILE_HEIGHT);
			}
		}
		
		public function disguiseON():void{
			super.loadGraphic(ImgNurse, true, true, TILE_WIDTH,TILE_HEIGHT);
			this.isDisguised = true;
			var t:Timer = new Timer(5000);
			t.addEventListener(TimerEvent.TIMER, onDelay);
			t.start()
		}
		
		private function onDelay(te:TimerEvent):void {
			disguiseOFF();
		}
	}
}