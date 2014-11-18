package objects
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import org.flixel.FlxObject;
	import org.flixel.FlxPath;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxTilemap;
	import org.flixel.FlxU;
	public class Human extends FlxSprite
	{
		private const TILE_WIDTH:uint = 65;
		private const TILE_HEIGHT:uint = 65;
		[Embed(source="walk_human_100.png")] private static var ImgSpaceman:Class;
		[Embed(source="alert_anim_100.png")] private static var ImgAlert:Class;
		[Embed(source="janitor_live.png")] private static var ImgJanitor:Class;
		[Embed(source="stunned_anim.png")] private static var StunnedAnim:Class;

		
		//path array of flxpoints
		//detect() super type
		//update()
		//	boolean have detected someone , follow path or follow something else
		
		public var routePoints:Vector.<FlxPoint> = new Vector.<FlxPoint>();
		public var routeDirection:Vector.<FlxPath> = new Vector.<FlxPath>();
		public var myroute:FlxPath = new FlxPath();
		
		public var isFollowing:Boolean = false;
		public var onRoute:Boolean = false;
		public var isPathSet:Boolean;
		public var nextPath:FlxPath;
		
		public var originX:Number;
		public var originY:Number;
		public var isStunned:Boolean = false;
		private var isPaused:Boolean = false;
		private var isPaused2:Boolean = false;
		private var amountToTurn:Number;
		public var restingAngle:Number=0;
		public var alerted:FlxSprite;
		public var alertAdded:Boolean = false;
		public var stunAn:FlxSprite;
		public var stunAdded:Boolean = false;
		public var alertedOfEnemy:Boolean = false;
		private var facingToward:int =0;
		private var pos:int=0;
		private var checkNode:int=0;
		private var holdAngle:Number=0;
		private var startAngle:Number=0;
		private var addingAmount:Boolean=true;
		public function Human(originX:Number, originY:Number, overLoad:Boolean)
		{
			super(originX, originY);
			this.originX=originX;
			this.originY=originY;
			if (this is Janitor) {
				super.loadGraphic(ImgJanitor, true, true,TILE_WIDTH,TILE_HEIGHT);
			} else
			super.loadGraphic(ImgSpaceman, true, true,TILE_WIDTH,TILE_HEIGHT);
			this.isPathSet=false;
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
			if(overLoad){
			super.addAnimation("idle", [0]);
			super.addAnimation("run", [1, 2, 3, 0], 6);
			super.addAnimation("idleBack", [4]);
			super.addAnimation("runBack", [5,6,7,4],6);
			super.addAnimation("right",[8]);
			super.addAnimation("bottomLeft",[9]);
			super.addAnimation("topRight",[10]);
			}
			alerted = new FlxSprite(originX,originY);
			alerted.loadGraphic(ImgAlert,true,false,TILE_WIDTH,TILE_HEIGHT);
			alerted.addAnimation("alert",[0,1],12,true);
			this.stunAdded=false;
			this.stunAn = new FlxSprite(originX,originY);
			this.stunAn.loadGraphic(StunnedAnim,true,false,50,50);
			this.stunAn.addAnimation("stun",[0,1,2,3],6,true);
		}
		
		private function follow():void
		{
			if(isFollowing && nextPath!=null){
				if(onRoute == false)
					this.pauseHuman(); 
				super.followPath(nextPath,70/16*TILE_WIDTH,PATH_FORWARD,false);
				onRoute = true;
			}else{
				//onRoute = true;
				/*super.followPath(this.routeDirection[0],50/16*TILE_WIDTH,PATH_FORWARD,false);
				var hold:FlxPath =this.routeDirection[0];
				this.routeDirection.splice(0,1);
				this.routeDirection.push(hold);*/
				if(!this.isPaused2){
					this.pauseHuman2();
				}
				
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
			var t:Timer = new Timer(1000,1);
			t.addEventListener(TimerEvent.TIMER, onPause);
			t.start();
		}
		private function pauseHuman2():void{
			this.isPaused2 = true;
			var j:Timer = new Timer(20,50);
			j.addEventListener(TimerEvent.TIMER,rotate2);
			var t:Timer = new Timer(1000,1);
			t.addEventListener(TimerEvent.TIMER_COMPLETE, onPause2);
			t.start();
			var ang:Number=0;
			var checkNodeNum:int = 1;
			var difAng:Number=0;
			while(difAng<10 && difAng >=-10 && checkNodeNum<this.routeDirection[pos].nodes.length){
				ang = FlxU.getAngle(new FlxPoint(this.x+this.width/2,this.y+this.height/2),this.routeDirection[pos].nodes[checkNodeNum]);
				if(Math.abs(ang-this.pathAngle)%360>180){
					difAng=360-ang;
				}
				else{
					difAng=(Math.abs(ang-this.pathAngle)%360);
				}
				checkNodeNum++;
			}
			this.startAngle=this.pathAngle;
			if(checkNodeNum<this.routeDirection[pos].nodes.length){
				this.checkNode=checkNodeNum;
			}
			else{
				this.checkNode=0;
			}
			if(ang>=0 && this.pathAngle>=0){
				if(ang>this.pathAngle){
					addingAmount = true;
					this.amountToTurn = (ang-this.pathAngle)/40;
				}
				else{
					addingAmount = false;
					this.amountToTurn = (this.pathAngle-ang)/40;
				}
			}
			else if(ang<=0 && this.pathAngle<=0){
				if(ang<this.pathAngle){
					addingAmount = true;
					this.amountToTurn = (ang-this.pathAngle)/40;
				}
				else{
					addingAmount = false;
					this.amountToTurn = (this.pathAngle-ang)/40;
				}
			}
			else if(ang<=0 && this.pathAngle>=0){
				if(ang>=-90 && this.pathAngle<=90){
					addingAmount = false;
					this.amountToTurn = (this.pathAngle-ang)/40;
				}
				else{
					addingAmount = true;
					this.amountToTurn = (-ang-this.pathAngle)/40;
				}
			}
			else if(ang>=0 && this.pathAngle<=0){
				if(ang<=90 && this.pathAngle>=-90){
					addingAmount = true;
					this.amountToTurn = (ang-this.pathAngle)/40;
				}
				else{
					addingAmount = false;
					if(Math.abs(this.pathAngle)>Math.abs(ang)){
						this.amountToTurn = (-this.pathAngle-ang)/40;
					}
					else{
						this.amountToTurn = (ang+this.pathAngle)/40;
					}
				}
			}
			this.holdAngle=ang;
			
			
			j.start();

		}
		private function onPause2(t:TimerEvent):void{
			onResume2();
			
		}
		private function onResume2():void{
			try{
				if(this.routeDirection != null && this.routeDirection.length>0 && this.routeDirection[0]!=null){
					super.followPath(this.routeDirection[pos],50/16*TILE_WIDTH,PATH_FORWARD,false);
					pos++;
					pos=pos%this.routeDirection.length;
				}
				this.isPaused2 = false;
			}catch(e:Error){
				return;
			}
		}
		
		private function rotate2(t:TimerEvent):void{
			this.rot2();
		}
		private function rot2():void{
			try{
				if(this.addingAmount){
					this.pathAngle=this.pathAngle+this.amountToTurn;
				}
				else{
					this.pathAngle=this.pathAngle-this.amountToTurn;
				}
			}catch(e:Error){
				trace("someting bad");
				return;
			}
			//trace("ang: "+ang+" end: "+this.pathAngle);
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
		
		private function setRoute():void{
			this.isFollowing=false;
			follow();
		}
		public function getAngle():Number{
			return this.pathAngle;
		}
		public function goBack(collisionMap:FlxTilemap):void{
			
			var pp:FlxPath = collisionMap.findPath(new FlxPoint(super.x + super.width / 2, super.y + super.height / 2),new FlxPoint(this.originX,this.originY));
			if(pp!=null){
			super.followPath(pp,50/16*TILE_WIDTH,PATH_FORWARD,false);
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
			if(this.isStunned || this.isPaused ||this.isPaused2){
				this.moves=false;
			}else{
				this.moves=true;
				var pathBeingMade:FlxPath;
				if(!this.isPathSet && this.pathSpeed==0 && this.isFollowing==false && routePoints.length>0){
					for (var j:int=0; j<routePoints.length;j++){
						//make a vector of paths that will switch between. use route directions
						if(j==0){
							pathBeingMade = collisionMap.findPath(new FlxPoint(super.x + super.width / 2, super.y + super.height / 2), routePoints[j]);
						}
						else{
							pathBeingMade = collisionMap.findPath(routePoints[j-1], routePoints[j]);
						}
						this.routeDirection.push(pathBeingMade);
					}
					pathBeingMade = collisionMap.findPath(routePoints[this.routePoints.length-1], new FlxPoint(super.x + super.width / 2, super.y + super.height / 2));
					this.routeDirection.push(pathBeingMade);
/*					pathBeingMade = collisionMap.findPath(new FlxPoint(super.x + super.width / 2, super.y + super.height / 2), routePoints[0]);
					var i:Number;
					var j:int;
					//pathBeingMade.nodes = pathBeingMade.nodes.concat(collisionMap.findPath(routePoints[0], routePoints[1]));
					//pathBeingMade.nodes = pathBeingMade.nodes.concat(collisionMap.findPath(routePoints[1], routePoints[2]));
					for(i=1; i<routePoints.length;i++){
						pathBeingMade.nodes = pathBeingMade.nodes.concat(collisionMap.findPath((routePoints[i-1]),routePoints[i]).nodes);
					}
					pathBeingMade.nodes = pathBeingMade.nodes.concat(collisionMap.findPath((routePoints[i-1]),new FlxPoint(super.x + super.width / 2, super.y + super.height / 2)).nodes);
					*/
					setRoute();
					this.isPathSet=true;
				}
				
			}
			if(this.isPathSet){
				if(this.pathSpeed==0  && !this.isPaused2){
					pauseHuman2();
				}
			}
			if(this.pathSpeed==0  && !this.isPaused2){
				this.pathAngle=this.restingAngle;
				if(this.restingAngle <22 && this.restingAngle>=-22){
					this.play("idleBack");
					this.facing=FlxObject.RIGHT;
					facingToward=1;
				}
				else if(this.restingAngle <67 && this.restingAngle>=22){
					this.play("topRight");
					this.facing=FlxObject.RIGHT;
					facingToward=2;
				}
				else if(this.restingAngle <112 && this.restingAngle>=67){
					this.play("right");
					facingToward=4;
					this.facing=FlxObject.RIGHT;
				}
				else if(this.restingAngle <157 && this.restingAngle>=112){
					this.play("bottomLeft");
					this.facing=FlxObject.LEFT;
					facingToward=3;
				}
				else if( this.restingAngle>=157){
					this.play("idle");
					facingToward=0;
					this.facing=FlxObject.RIGHT;
				}
				else if(this.restingAngle <-22 && this.restingAngle>=-67){
					this.play("topRight");
					facingToward=5;
					this.facing=FlxObject.LEFT;
				}
				else if(this.restingAngle <-67 && this.restingAngle>=-112){
					this.play("right");
					facingToward=6;
					this.facing=FlxObject.LEFT;
				}
				else if(this.restingAngle <-157 && this.restingAngle>=-112){
					this.play("bottomLeft");
					facingToward=7;
					this.facing=FlxObject.RIGHT;
				}
				else{
					this.play("idle");
					facingToward=0;
					this.facing=FlxObject.RIGHT;
				}
				//this.angle=this.restingAngle;
			}
			if(this.pathAngle <22 && (this.pathAngle>=-22 ||this.pathAngle>=338)){
				this.play("runBack");
				this.facing=FlxObject.RIGHT;
				facingToward=1;
			}
			else if((this.pathAngle <67 && this.pathAngle>=22) ||(this.pathAngle <-293 && this.pathAngle>=338) ){
				this.play("topRight");
				this.facing=FlxObject.RIGHT;
				facingToward=2;
			}
			else if((this.pathAngle <112 && this.pathAngle>=67) ||(this.pathAngle <-248 && this.pathAngle>=-293)){
				this.play("right");
				facingToward=4;
				this.facing=FlxObject.RIGHT;
			}
			else if((this.pathAngle <157 && this.pathAngle>=112) || (this.pathAngle <-203 && this.pathAngle>=-248)){
				this.play("bottomLeft");
				this.facing=FlxObject.LEFT;
				facingToward=3;
			}
			else if(( this.pathAngle>=157 && this.pathAngle<=180)||( this.pathAngle>=-203 && this.pathAngle<=-180)){
				this.play("run");
				facingToward=0;
				this.facing=FlxObject.RIGHT;
			}
			else if((this.pathAngle <-22 && this.pathAngle>=-67) || (this.pathAngle <338 && this.pathAngle>=298)){
				this.play("topRight");
				facingToward=5;
				this.facing=FlxObject.LEFT;
			}
			else if((this.pathAngle <-67 && this.pathAngle>=-112) || (this.pathAngle <298 && this.pathAngle>=248)){
				this.play("right");
				facingToward=6;
				this.facing=FlxObject.LEFT;
			}
			else if((this.pathAngle <-112 && this.pathAngle>=-157)|| (this.pathAngle <248 && this.pathAngle>=207)){
				this.play("bottomLeft");
				facingToward=7;
				this.facing=FlxObject.RIGHT;
			}
			else{
				this.play("run");
				facingToward=0;
				this.facing=FlxObject.RIGHT;
			}

			if(this.pathSpeed==0){
				if(facingToward==0){
					this.play("idle");
					this.facing=FlxObject.RIGHT;
				}
				else if(facingToward==1){
					this.play("idleBack");
					this.facing=FlxObject.RIGHT;
				}
				else if(facingToward==2){
					this.play("topRight");
					this.facing=FlxObject.RIGHT;
				}
				else if(facingToward==3){
					this.play("bottomLeft");
					this.facing=FlxObject.LEFT;
				}
				else if(facingToward==4){
					this.play("right");
					this.facing=FlxObject.RIGHT;
				}
				else if(facingToward==5){
					this.play("topRight");
					this.facing=FlxObject.LEFT;
				}
				else if(facingToward==6){
					this.play("right");
					this.facing=FlxObject.LEFT;
				}
				else{
					this.play("bottomLeft");
					this.facing=FlxObject.RIGHT;
				}
				
			}
			
		}
		
		public function addRoutePoints(p:FlxPoint):void{
			routePoints.push(p);
		}
		
		
	}
}