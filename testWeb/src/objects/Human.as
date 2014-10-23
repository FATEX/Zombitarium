package objects
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import org.flixel.FlxPath;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxTilemap;

	public class Human extends FlxSprite
	{
		private const TILE_WIDTH:uint = 65;
		private const TILE_HEIGHT:uint = 65;
		[Embed(source="walk_human_100.png")] private static var ImgSpaceman:Class;
		[Embed(source="alert_anim_100.png")] private static var ImgAlert:Class;
		
		
		//path array of flxpoints
		//detect() super type
		//update()
		//	boolean have detected someone , follow path or follow something else
		
		public var routePoints:Vector.<FlxPoint> = new Vector.<FlxPoint>();
		public var myroute:FlxPath = new FlxPath();
		
		public var isFollowing:Boolean = false;
		public var onRoute:Boolean = false;
		public var isPathSet:Boolean = false;
		public var nextPath:FlxPath;
		
		public var originX:Number;
		public var originY:Number;
		public var isStunned:Boolean = false;
		private var isPaused:Boolean = false;
		public var restingAngle:Number=0;
		public var alerted:FlxSprite;
		public var alertAdded:Boolean = false;
		private var facting:int =0;
		
		public function Human(originX:Number, originY:Number)
		{
			super(originX, originY);
			this.originX=originX;
			this.originY=originY;
			super.loadGraphic(ImgSpaceman, true, true,TILE_WIDTH,TILE_HEIGHT);
			
			//bounding box tweaks
			super.width = TILE_WIDTH*7/8;
			super.height = TILE_HEIGHT*7/8;
			super.offset.x = 1;
			super.offset.y = 1;
			
			//basic player physics
			super.drag.x = 640/16*TILE_WIDTH;
			super.drag.y = 640/16*TILE_WIDTH;
			//player.acceleration.y = 420;
			super.maxVelocity.x = 80/16*TILE_WIDTH;
			super.maxVelocity.y = 80/16*TILE_WIDTH;
			this.x=originX -this.width/2;
			this.y=originY-this.height/2;
			
			//animations
			super.addAnimation("idle", [0]);
			super.addAnimation("run", [1, 2, 3, 0], 6);
			super.addAnimation("idleBack", [4]);
			super.addAnimation("runBack", [5,6,7,4],6);
			alerted = new FlxSprite(originX,originY);
			alerted.loadGraphic(ImgAlert,true,false,TILE_WIDTH,TILE_HEIGHT);
			alerted.addAnimation("alert",[0,1],12,true);
		}
		
		private function follow():void
		{
			if(isFollowing && nextPath!=null){
				if(onRoute == false) this.pauseHuman(); 
				super.followPath(nextPath,70/16*TILE_WIDTH,PATH_FORWARD,true);
				onRoute = true;
			}else{
				//onRoute = true;
				super.followPath(myroute,50/16*TILE_WIDTH,PATH_LOOP_FORWARD,true);
			}
		}
		
		public function stunHuman():void{
			this.isStunned=true;
			var t:Timer = new Timer(1000);
			t.addEventListener(TimerEvent.TIMER, onDelay);
			t.start();
		}
		private function onDelay(te:TimerEvent):void {
			doCall();
		}
		private function doCall():void {
			this.isStunned=false;
		}
		
		private function pauseHuman():void{
			this.isPaused = true;
			var t:Timer = new Timer(1000);
			t.addEventListener(TimerEvent.TIMER, onPause);
			t.start();
		}
		private function onPause(t:TimerEvent):void{
			onResume();
		}
		private function onResume():void{
			this.isPaused = false;
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
			return this.pathAngle;
		}
		public function goBack(collisionMap:FlxTilemap):void{
			
			var pp:FlxPath = collisionMap.findPath(new FlxPoint(super.x + super.width / 2, super.y + super.height / 2),new FlxPoint(this.originX,this.originY));
			if(pp!=null){
			super.followPath(pp,50/16*TILE_WIDTH,PATH_FORWARD,true);
			}
			isFollowing=false;
			isPathSet=false;
		}
		public function setAngle(ang:Number):void{
			this.pathAngle=ang;
			this.restingAngle=ang;
		}
		public function humanUpdate(collisionMap:FlxTilemap):void{
			//if(onRoute == false)this.pauseHuman();
			//onRoute = true;
			if(this.isStunned || this.isPaused){
				this.moves=false;
			}else{
				this.moves=true;
				var pathBeingMade:FlxPath;
				if(!this.isPathSet && this.pathSpeed==0 && this.isFollowing==false && routePoints.length>0){
					pathBeingMade = collisionMap.findPath(new FlxPoint(super.x + super.width / 2, super.y + super.height / 2), routePoints[0]);
					var i:Number;
					var j:int;
					//pathBeingMade.nodes = pathBeingMade.nodes.concat(collisionMap.findPath(routePoints[0], routePoints[1]));
					//pathBeingMade.nodes = pathBeingMade.nodes.concat(collisionMap.findPath(routePoints[1], routePoints[2]));
					for(i=1; i<routePoints.length;i++){
						pathBeingMade.nodes = pathBeingMade.nodes.concat(collisionMap.findPath((routePoints[i-1]),routePoints[i]).nodes);
					}
					pathBeingMade.nodes = pathBeingMade.nodes.concat(collisionMap.findPath((routePoints[i-1]),new FlxPoint(super.x + super.width / 2, super.y + super.height / 2)).nodes);
					setRoute(pathBeingMade);
					this.isPathSet=true;
				}
			}
			if(this.pathAngle <90 && this.pathAngle>-90){
				this.play("runBack");
				facing=1;
			}
			else{
				this.play("run");
				facing=0;
			}
			if(this.pathSpeed==0){
				if(facing==0){
					this.play("idle");
				}
				else{
					this.play("idleBack");
				}
				this.pathAngle=this.restingAngle;
				this.angle=this.restingAngle;
			}
			
		}
		
		public function addRoutePoints(p:FlxPoint):void{
			routePoints.push(p);
		}
		
		
	}
}