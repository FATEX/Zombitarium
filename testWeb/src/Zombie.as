package
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import objects.Human;
	
	import org.flixel.FlxGame;
	import org.flixel.FlxObject;
	import org.flixel.FlxPath;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxTilemap;
	
	public class Zombie extends FlxSprite
	{
		private const TILE_WIDTH:uint = 65;
		private const TILE_HEIGHT:uint = 65;

		[Embed(source="nurse_dead.png")] private static var ImgSpaceman:Class;
		[Embed(source="zombie_combined.png")] private static var ImgPlayer:Class;
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
		private var xTile:int=0;
		private var yTile:int=0;
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
			super.addAnimation("idle", [0]);
			super.addAnimation("run", [1, 2, 3, 0], 6);
			super.addAnimation("idleBack", [4]);
			super.addAnimation("runBack", [5,6,7,4],6);
			super.addAnimation("right",[8]);
			super.addAnimation("bottomLeft",[9]);
			super.addAnimation("topRight",[10]);
			this.xTile = xPos/TILE_WIDTH;
			this.yTile = yPos/TILE_HEIGHT;
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
				this.followPath(path,50/16*TILE_WIDTH, PATH_FORWARD, false);
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
			if(this.humanFollowing!=null && humanP!=null && humanP.indexOf(this.humanFollowing)!=-1 && this.x/TILE_WIDTH != this.xTile && this.y/TILE_HEIGHT != this.yTile){
				this.stopFollowingPath(true);
				this.pathSpeed=0;
				this.velocity=new FlxPoint(0,0);
				path = collisionMap.findPath(zombieP, new FlxPoint(humanFollowing.x+humanFollowing.width/2, humanFollowing.y+humanFollowing.height/2), false);
				this.attackNearestHuman(collisionMap,path);
				this.xTile=this.x/TILE_WIDTH;
				this.yTile = this.y/TILE_HEIGHT;
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
			if(this.pathAngle <22 && this.pathAngle>=-22){
				this.play("runBack");
				this.facing=FlxObject.RIGHT;
			}
			else if(this.pathAngle <67 && this.pathAngle>=22){
				this.play("topRight");
				this.facing=FlxObject.RIGHT;
			}
			else if(this.pathAngle <112 && this.pathAngle>=67){
				this.play("right");
				this.facing=FlxObject.RIGHT;
			}
			else if(this.pathAngle <157 && this.pathAngle>=112){
				this.play("bottomLeft");
				this.facing=FlxObject.LEFT;
			}
			else if( this.pathAngle>=157){
				this.play("run");
				this.facing=FlxObject.RIGHT;
			}
			else if(this.pathAngle <-22 && this.pathAngle>=-67){
				this.play("topRight");
				this.facing=FlxObject.LEFT;
			}
			else if(this.pathAngle <-67 && this.pathAngle>=-112){
				this.play("right");
				this.facing=FlxObject.LEFT;
			}
			else if(this.pathAngle <-157 && this.pathAngle>=-112){
				this.play("bottomLeft");
				this.facing=FlxObject.RIGHT;
			}
			else{
				this.play("run");
				this.facing=FlxObject.RIGHT;
			}
			if(this.pathSpeed==0){
				this.play("idle");
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
			this.width =  TILE_WIDTH*5/8;
			this.height = TILE_HEIGHT*7/8;
			this.offset.x = this.width/4;
			this.offset.y = 1;
		}
		
		public function dieAnimation():void{
			this.destroy();
		}
		
		public function disguiseOFF():void{
			if(isDisguised){
				try{
				isDisguised=false;
				this.loadGraphic(ImgPlayer, true, true, TILE_WIDTH,TILE_HEIGHT);
				
				this.width =  TILE_WIDTH*5/8;
				this.height = TILE_HEIGHT*7/8;
				this.offset.x = this.width/4;
				this.offset.y = 1;
				}
				catch(error:Error){
					
				}
			}
		}
		
		public function disguiseON():void{
			var hold:FlxPoint = new FlxPoint(this.x,this.y);
			super.loadGraphic(ImgNurse, true, true, TILE_WIDTH,TILE_HEIGHT);
			this.width =  TILE_WIDTH*5/8;
			this.height = TILE_HEIGHT*7/8;
			this.offset.x = this.width/4;
			this.offset.y = 1;
			this.isDisguised = true;
			var t:Timer = new Timer(5000);
			t.addEventListener(TimerEvent.TIMER, onDelay);
			t.start();
			
		}
		
		private function onDelay(te:TimerEvent):void {
			if(this.alive && this.exists){
				disguiseOFF();
			}
		}
	}
}