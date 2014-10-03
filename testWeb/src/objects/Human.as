package objects
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import fla;
	
	import org.flixel.FlxPath;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxTilemap;

	public class Human extends FlxSprite
	{
		private const TILE_WIDTH:uint = 16;
		private const TILE_HEIGHT:uint = 16;
		[Embed(source="spaceman.png")] private static var ImgSpaceman:Class;
		
		//path array of flxpoints
		//detect() super type
		//update()
		//	boolean have detected someone , follow path or follow something else
		
		public var routePoints:Vector.<FlxPoint> = new Vector.<FlxPoint>();
		public var myroute:FlxPath = new FlxPath();
		
		public var isFollowing:Boolean = false;
		public var isPathSet:Boolean = false;
		public var nextPath:FlxPath;
		
		public var originX:Number;
		public var originY:Number;
		public var isStunned = false;
		
		public function Human(originX:Number, originY:Number)
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
		
		private function follow():void
		{
			
				if(isFollowing){
					super.followPath(nextPath,70,PATH_FORWARD,true);
				}else{
					super.followPath(myroute,50,PATH_LOOP_FORWARD,true);	
				}
		}
		
		public function stunHuman():void{
			this.isStunned=true;
			var t:Timer = new Timer(1000);
			t.addEventListener(TimerEvent.TIMER, onDelay);
			t.start()
			
			
		}
		private function onDelay(te:TimerEvent):void {
			doCall();
		}
		private function doCall():void {
			this.isStunned=false;
		}
		public function setPath(p:FlxPoint, collisionMap:FlxTilemap):void{
				  this.isFollowing=true;
				  var pp:FlxPath =  collisionMap.findPath(new FlxPoint(super.x + super.width / 2, super.y + super.height / 2),p);
				  this.nextPath=pp;
				  follow();
		}
		
		private function setRoute(p:FlxPath):void{
			this.isFollowing=false;
			this.myroute=p;
			follow();
		}
		public function getAngle():Number{
			return this.angle;
		}
		public function goBack(collisionMap:FlxTilemap):void{
			
			var pp:FlxPath = collisionMap.findPath(new FlxPoint(super.x + super.width / 2, super.y + super.height / 2),new FlxPoint(this.originX,this.originY));
			super.followPath(pp,50,PATH_FORWARD,true);
			isFollowing=false;
			isPathSet=false;
		}
		
		public function humanUpdate(collisionMap:FlxTilemap):void{
			if(this.isStunned){
				this.moves=false;
			}
			else{
				this.moves=true;
			var ppppp:FlxPath;
			if(!this.isPathSet && this.pathSpeed==0 && this.isFollowing==false && routePoints.length>0){
				ppppp = collisionMap.findPath(new FlxPoint(super.x + super.width / 2, super.y + super.height / 2), routePoints[0]);
				var i:Number;
				//ppppp.nodes = ppppp.nodes.concat(collisionMap.findPath(routePoints[0], routePoints[1]));
				//ppppp.nodes = ppppp.nodes.concat(collisionMap.findPath(routePoints[1], routePoints[2]));
				for(i=1; i<routePoints.length;i++){
					ppppp.nodes = ppppp.nodes.concat(collisionMap.findPath((routePoints[i-1]),routePoints[i]).nodes);
				}
				ppppp.nodes = ppppp.nodes.concat(collisionMap.findPath((routePoints[i-1]),new FlxPoint(super.x + super.width / 2, super.y + super.height / 2)).nodes);
				setRoute(ppppp);
				this.isPathSet=true;
			}
			}
		}
		
		public function addRoutePoints(p:FlxPoint):void{
			routePoints.push(p);
		}
		
		
	}
}