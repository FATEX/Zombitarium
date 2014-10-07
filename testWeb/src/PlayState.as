package
{
	import flash.display.BlendMode;
	import flash.utils.ByteArray;
	
	import objects.Human;
	
	import org.flixel.FlxButton;
	import org.flixel.FlxCamera;
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	import org.flixel.FlxPath;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSave;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxTilemap;
	import org.flixel.FlxU;

	public class PlayState extends FlxState
	{
		// Tileset that works with AUTO mode (best for thin walls)
		[Embed(source = 'auto_tiles.png')]private static var auto_tiles:Class;
		
		// Tileset that works with ALT mode (best for thicker walls)
		[Embed(source = 'alt_tiles.png')]private static var alt_tiles:Class;
		
		// Tileset that works with OFF mode (do what you want mode)
		[Embed(source = 'empty_tiles.png')]private static var empty_tiles:Class;
		[Embed(source = 'win.jpg')]private static var winImg:Class;
		[Embed(source = 'game-over.jpg')]private static var loseImg:Class;
		
		// Default tilemaps. Embedding text files is a little weird.
		[Embed(source = 'default_auto.txt', mimeType = 'application/octet-stream')]private static var default_auto:Class;
		[Embed(source = 'default_alt.txt', mimeType = 'application/octet-stream')]private static var default_alt:Class;
		[Embed(source = 'default_empty.txt', mimeType = 'application/octet-stream')]private static var default_empty:Class;
		[Embed(source = 'default_characters.txt', mimeType = 'application/octet-stream')]private static var default_characters:Class;
		[Embed(source = 'default_characters_level_middle.txt', mimeType = 'application/octet-stream')]private static var default_characters2:Class;
		[Embed(source = 'hard_level_characters.txt', mimeType = 'application/octet-stream')]private static var default_chars_hard:Class;

		
		[Embed(source = 'level_middle.txt', mimeType = 'application/octet-stream')]private static var default_middle:Class;
		[Embed(source = 'level_hard.txt', mimeType = 'application/octet-stream')]private static var default_hard:Class;


		[Embed(source="walk_zombie_front.png")] private static var ImgSpaceman:Class;

		[Embed(source="key.png")] private static var ImgKey:Class;
		[Embed(source="door.png")] private static var ImgDoor:Class;
		[Embed(source="doorOpen.png")] private static var ImgDoorOpen:Class;
		
		// Some static constants for the size of the tilemap tiles
		private const TILE_WIDTH:uint = 16;
		private const TILE_HEIGHT:uint = 16;
		
		// The FlxTilemap we're using
		private var collisionMap:FlxTilemap;
		
		// Box to show the user where they're placing stuff
		private var highlightBox:FlxObject;
		
		// Player modified from "Mode" demo

		private var player:Zombie;
		private var humans:Vector.<Human>;
		private var zombies:Vector.<Zombie>;
		
		private var winPic:FlxSprite = new FlxSprite(10,10);
		private var losePic:FlxSprite = new FlxSprite(10,10);

		private var isFollowing:Boolean;
		private var isChasing:Boolean=false;
		private var xPos:int;
		// Some interface buttons and text
		private var autoAltBtn:FlxButton;
		private var resetBtn:FlxButton;
		private var quitBtn:FlxButton;
		private var nextLevelBtn:FlxButton;
		private var helperTxt:FlxText;
		private var destination:FlxPoint;

		private var keys:Vector.<Key>;
		private var doors:Vector.<Door>;
		private var unlockedDoors:Vector.<UnlockedDoor>;
		
		private var level:int = 0;
		
		private var infected:Zombie;
		private var area:FlxSprite;
		
		//constants For detection
		private var distanceCanSee:int = 50;
		private var coneWidth:Number = 45;
		override public function create():void
		{
			FlxG.framerate = 50;
			FlxG.flashFramerate = 50;
			//Load _datamap to _map and add to PlayState
			zombies = new Vector.<Zombie>();
			// Creates a new tilemap with no arguments
			collisionMap = new FlxTilemap();
			isFollowing = true;
			xPos=17;
			/*
			 * FlxTilemaps are created using strings of comma seperated values (csv)
			 * This string ends up looking something like this:
			 *
			 * 0,0,0,0,0,0,0,0,0,0,
			 * 0,0,0,0,0,0,0,0,0,0,
			 * 0,0,0,0,0,0,1,1,1,0,
			 * 0,0,1,1,1,0,0,0,0,0,
			 * ...
			 *
			 * Each '0' stands for an empty tile, and each '1' stands for
			 * a solid tile
			 *
			 * When using the auto map generation, the '1's are converted into the corresponding frame
			 * in the tileset.
			 */
			
			// Initializes the map using the generated string, the tile images, and the tile size
			collisionMap.loadMap(new default_auto(), auto_tiles, TILE_WIDTH, TILE_HEIGHT, FlxTilemap.AUTO);
			add(collisionMap);
			
			highlightBox = new FlxObject(0, 0, TILE_WIDTH, TILE_HEIGHT);
			destination = new FlxPoint(0,0);
			setupPlayer();
			characterLoader();
			

			
			
			// When switching between modes here, the map is reloaded with it's own data, so the positions of tiles are kept the same
			// Notice that different tilesets are used when the auto mode is switched
//			autoAltBtn = new FlxButton(4, FlxG.height - 24, "AUTO", function():void
//
//			{
//				switch(collisionMap.auto)
//				{
//					case FlxTilemap.AUTO:
//						collisionMap.loadMap(FlxTilemap.arrayToCSV(collisionMap.getData(true), collisionMap.widthInTiles),
//							alt_tiles, TILE_WIDTH, TILE_HEIGHT, FlxTilemap.ALT);
//						autoAltBtn.label.text = "ALT";
//						break;
//					
//					case FlxTilemap.ALT:
//						collisionMap.loadMap(FlxTilemap.arrayToCSV(collisionMap.getData(true), collisionMap.widthInTiles),
//							empty_tiles, TILE_WIDTH, TILE_HEIGHT, FlxTilemap.OFF);
//						autoAltBtn.label.text = "OFF";
//						break;
//					
//					case FlxTilemap.OFF:
//						collisionMap.loadMap(FlxTilemap.arrayToCSV(collisionMap.getData(true), collisionMap.widthInTiles),
//							auto_tiles, TILE_WIDTH, TILE_HEIGHT, FlxTilemap.AUTO);
//						autoAltBtn.label.text = "AUTO";
//						break;
//				}
//				
//			});
			

			resetBtn = new FlxButton(-100, 42, "Reset", function():void
			{
				if(level==0){
					remove(collisionMap);
					collisionMap = new FlxTilemap();
					collisionMap.loadMap(new default_auto(), auto_tiles, TILE_WIDTH, TILE_HEIGHT, FlxTilemap.AUTO);
					add(collisionMap);
					remove(player,true);
					for(var i:int=0; i<zombies.length;i++){
						remove(zombies[i]);
					}
					for(var j:int=0; j<humans.length;j++){
						remove(humans[j]);
					}
					for each(var d:Door in doors){
						remove(d);
					}
					
					for each(var ud:UnlockedDoor in unlockedDoors){
						remove(ud);
					}
					
					for each(var k:Key in keys){
						remove(k);
					}
					zombies = new Vector.<Zombie>();
					humans = new Vector.<Human>();
					doors = new Vector.<Door>;
					unlockedDoors = new Vector.<UnlockedDoor>();
					keys = new Vector.<Key>();
					
					setupPlayer();
					characterLoader();
	
					add(player);
					addCam();
					
				}
				if (level == 1) 
				{
					remove(collisionMap);
					collisionMap = new FlxTilemap();
					collisionMap.loadMap(new default_middle(), auto_tiles, TILE_WIDTH, TILE_HEIGHT, FlxTilemap.AUTO);
					add(collisionMap);
					remove(player,true);
					for(var i:int=0; i<zombies.length;i++){
						remove(zombies[i]);
					}
					for(var j:int=0; j<humans.length;j++){
						remove(humans[j]);
					}
					for each(var d:Door in doors){
						remove(d);
					}
					
					for each(var ud:UnlockedDoor in unlockedDoors){
						remove(ud);
					}
					
					for each(var k:Key in keys){
						remove(k);
					}
					zombies = new Vector.<Zombie>();
					humans = new Vector.<Human>();
					doors = new Vector.<Door>;
					unlockedDoors = new Vector.<UnlockedDoor>();
					keys = new Vector.<Key>();
					
					setupPlayer();
					characterLoader();

					add(player);
					addCam();
					
					
				} else if (level == 2)
				{
					remove(collisionMap);
					collisionMap = new FlxTilemap();
					collisionMap.loadMap(new default_hard(), auto_tiles, TILE_WIDTH, TILE_HEIGHT, FlxTilemap.AUTO);
					add(collisionMap);
					remove(player,true);
					for(var i:int=0; i<zombies.length;i++){
						remove(zombies[i]);
					}
					for(var j:int=0; j<humans.length;j++){
						remove(humans[j]);
					}
					for each(var d:Door in doors){
						remove(d);
					}
					
					for each(var ud:UnlockedDoor in unlockedDoors){
						remove(ud);
					}
					
					for each(var k:Key in keys){
						remove(k);
					}
					zombies = new Vector.<Zombie>();
					humans = new Vector.<Human>();
					doors = new Vector.<Door>;
					unlockedDoors = new Vector.<UnlockedDoor>();
					keys = new Vector.<Key>();
					
					setupPlayer();
					characterLoader();
		
					addCam();
				}
			});
			add(resetBtn);
			
			nextLevelBtn = new FlxButton(-100, 130, "Next Level", function():void
			{
				level++;
				level = level%3;
				if(level==0){
					remove(collisionMap);
					collisionMap = new FlxTilemap();
					collisionMap.loadMap(new default_auto(), auto_tiles, TILE_WIDTH, TILE_HEIGHT, FlxTilemap.AUTO);
					add(collisionMap);
					remove(player,true);
					for(var i:int=0; i<zombies.length;i++){
						remove(zombies[i]);
					}
					for(var j:int=0; j<humans.length;j++){
						remove(humans[j]);
					}
					for each(var d:Door in doors){
						remove(d);
					}
					
					for each(var ud:UnlockedDoor in unlockedDoors){
						remove(ud);
					}
					
					for each(var k:Key in keys){
						remove(k);
					}
					zombies = new Vector.<Zombie>();
					humans = new Vector.<Human>();
					doors = new Vector.<Door>;
					unlockedDoors = new Vector.<UnlockedDoor>();
					keys = new Vector.<Key>();
					
					setupPlayer();
					characterLoader();
					addCam();
				}
				if (level == 1) 
				{
					remove(collisionMap);
					collisionMap = new FlxTilemap();
					collisionMap.loadMap(new default_middle(), auto_tiles, TILE_WIDTH, TILE_HEIGHT, FlxTilemap.AUTO);
					add(collisionMap);
					remove(player,true);
					for(var i:int=0; i<zombies.length;i++){
						remove(zombies[i]);
					}
					for(var j:int=0; j<humans.length;j++){
						remove(humans[j]);
					}
					for each(var d:Door in doors){
						remove(d);
					}
					
					for each(var ud:UnlockedDoor in unlockedDoors){
						remove(ud);
					}
					
					for each(var k:Key in keys){
						remove(k);
					}
					zombies = new Vector.<Zombie>();
					humans = new Vector.<Human>();
					doors = new Vector.<Door>;
					unlockedDoors = new Vector.<UnlockedDoor>();
					keys = new Vector.<Key>();
					
					setupPlayer();
					characterLoader();
					addCam();					
				} else if (level == 2)
				{
					collisionMap.loadMap(new default_hard(), auto_tiles, TILE_WIDTH, TILE_HEIGHT, FlxTilemap.AUTO);
					add(collisionMap);
					remove(player,true);
					for(var i:int=0; i<zombies.length;i++){
						remove(zombies[i]);
					}
					for(var j:int=0; j<humans.length;j++){
						remove(humans[j]);
					}
					for each(var d:Door in doors){
						remove(d);
					}
					
					for each(var ud:UnlockedDoor in unlockedDoors){
						remove(ud);
					}
					
					for each(var k:Key in keys){
						remove(k);
					}
					zombies = new Vector.<Zombie>();
					humans = new Vector.<Human>();
					doors = new Vector.<Door>;
					unlockedDoors = new Vector.<UnlockedDoor>();
					keys = new Vector.<Key>();
					
					setupPlayer();
					characterLoader();
					addCam();
				}
			});
			add(nextLevelBtn);

			
			quitBtn = new FlxButton(-1000, 30, "Quit",
				function():void { FlxG.fade(0xff000000, 0.22, function():void { FlxG.switchState(new MenuState()); } ); } );
			add(quitBtn);
			
			add(player);
			addCam();
			//helperTxt = new FlxText(FlxG.width/2 - resetBtn.width, 55, 150/2, "Arrow keys to move\nPress E to open doors");
			//add(helperTxt);
	
		}
		
		private function addCam():void {
			var cam:FlxCamera = new FlxCamera(0,0, FlxG.width/4, FlxG.height/4, 4); // we put the first one in the top left corner
			cam.follow(player);
			// this sets the limits of where the camera goes so that it doesn't show what's outside of the tilemap
			cam.setBounds(0,0,collisionMap.width, collisionMap.height);
			//cam.color = 0xFFFFFF; 
			FlxG.addCamera(cam);
			
			cam = new FlxCamera(2, 2, quitBtn.width, quitBtn.height);
			cam.follow(quitBtn);
			FlxG.addCamera(cam);
			
			cam = new FlxCamera(2, 42, resetBtn.width, resetBtn.height);
			cam.follow(resetBtn);
			FlxG.addCamera(cam);
			
			cam = new FlxCamera(2, 82, nextLevelBtn.width, nextLevelBtn.height);
			cam.follow(nextLevelBtn);
			FlxG.addCamera(cam);
		}
		
		
		private function characterLoader():void{
			humans = new Vector.<Human>();
			doors = new Vector.<Door>();
			keys = new Vector.<Key>();
			unlockedDoors = new Vector.<UnlockedDoor>();
			var btarray:ByteArray;
			if(level==0){
				btarray = new default_characters();
			}
			else if(level==1){
				btarray = new default_characters2();
			}
			else if(level==2){
				btarray = new default_chars_hard();
			}
		
			var wholeLevel:String = btarray.readMultiByte(btarray.bytesAvailable, btarray.endian);
			var arLines:Array = wholeLevel.split("\n");
			var x:int;
			var y:int;
			var type:String;
			var lineArray:Array;
			var h:Human=new Human(0,0);
			var door:Door = new Door(0,0);
			var key:Key = new Key(collisionMap, door, player,0,0);
			var unlockedDoor:UnlockedDoor = new UnlockedDoor(0,0);
			for each (var singleLine:String in arLines)
			{
				lineArray = singleLine.split(",");
				//player.x=(lineArray.length-1)*TILE_WIDTH;
				//player.y=(lineArray.length-1)*TILE_HEIGHT;
				
				type = lineArray[0];
				x = int(lineArray[1]);
				y = int(lineArray[2]);
				if(type=="H"){
					h=new Human(x*TILE_WIDTH+h.width/2,y*TILE_HEIGHT+h.height/2);
					humans.push(h);
				}
				if(type=="R"){
					h.addRoutePoints(new FlxPoint(x*TILE_WIDTH+h.width/2,y*TILE_HEIGHT+h.height/2));
				}
				if(type=="D"){
					h.setAngle(x);
					
				}
				if(type=="P"){
					player.x=x*TILE_WIDTH;
					player.y=y*TILE_HEIGHT;
					
				}
				if(type=="LDOOR"){
					door = new Door(x*TILE_WIDTH-door.width/2,y*TILE_HEIGHT-door.height/8);
					doors.push(door);
				}
				if(type=="KEY"){
					key = new Key(collisionMap, door, player, x*TILE_WIDTH,y*TILE_HEIGHT+key.height/2);
					keys.push(key);
				}
				if(type=="UDOOR"){
					unlockedDoor = new UnlockedDoor(x*TILE_WIDTH-unlockedDoor.width/2,y*TILE_HEIGHT-unlockedDoor.height/8);
					unlockedDoors.push(unlockedDoor);
				}
			}
			for each(var g:Door in doors){
				add(g);
			}
			
			for each(var ug:UnlockedDoor in unlockedDoors){
				add(ug);
			}
			
			for each(var s:Key in keys){
				add(s);
			}
			for each(var hum:Human in humans){
				add(hum);
//				hum.followPath(collisionMap.findPath(new FlxPoint(hum.x+hum.width/2,hum.y+hum.height/2),new FlxPoint(hum.x+hum.width/2,hum.y+hum.height/2)));
			}
		}
		
		override public function update():void
		{
			// Tilemaps can be collided just like any other FlxObject, and flixel
			// automatically collides each individual tile with the object.
			FlxG.collide(player, collisionMap);
			//FlxG.collide(infected, collisionMap);
			
			highlightBox.x = Math.floor(FlxG.mouse.x / TILE_WIDTH) * TILE_WIDTH;
			highlightBox.y = Math.floor(FlxG.mouse.y / TILE_HEIGHT) * TILE_HEIGHT;
			
			
			updatePlayer();
			for(var i:int=0; i<humans.length;i++){
				for (var j:int=0;j<zombies.length;j++){
					try{
					humans[i].humanUpdate(collisionMap);
					
					if(zombies[j].alive && humans[i].alive){
						FlxG.collide(zombies[j],humans[i],collided);
					}
					
					if(zombies[j].alive && humans[i].alive){
						if(detect(humans[i],zombies[j])){
							humans[i].setPath(new FlxPoint(zombies[j].x + zombies[j].width / 2, zombies[j].y + zombies[j].height / 2),collisionMap);
							humans[i].color=0xFFD700;
						}
						else if(humans[i].pathSpeed==0){
							humans[i].goBack(collisionMap);
						}
						else if(humans[i].isFollowing){
							if(FlxG.collide(humans[i],collisionMap)){
								humans[i].goBack(collisionMap);
							}
						}
						else{
							humans[i].color=0x800000;
						}
					}
					}catch(e:Error){
						break;
					}
				}
			}
			for(var w:int=0; w<zombies.length;w++){
				if(zombies[w]!= player){
					zombies[w].zombieUpdate(collisionMap,humans,new FlxPoint(zombies[w].x+zombies[w].width/2,zombies[w].y+zombies[w].height/2));
				}
			}
			
			
			super.update();
		}
		public function collided(obj1:FlxObject,obj2:FlxObject):void{
			var man:Human;
			var zom:Zombie;
			if(obj1 is Human){
				if(obj2 is Zombie){
					man = Human(obj1);
					zom = Zombie(obj2);
				}
				else{
					return;
				}
			}
			else if(obj1 is Zombie){
				if(obj2 is Human){
					zom = Zombie(obj1);
					man = Human(obj2);
				}
				else{
					return;
				}
			}
			else{
				return;
			}
		if(this.detect(man,zom)){
			remove(zom,true);
			man.goBack(collisionMap);
			zom.alive=false;
			if(man.isStunned){
				infected = new Zombie(man.x,man.y,man.width,man.health,man.drag.x,man.drag.y,man.maxVelocity.x,man.maxVelocity.y);
				//t = new FlxText(0,20,FlxG.width,"positionx" + infected.x + "positiony"+infected.y);
				//FlxG.collide(infected, collisionMap);
				var pos2:int = humans.indexOf(man);
				//humans[pos].x=1000000000;
				humans.splice(pos2,1);
				
				add(infected);
				var path2:FlxPath =infected.findNearestHuman(collisionMap,humans,new FlxPoint(infected.x+infected.width/2,infected.y+infected.height/2));
				
				//t = new FlxText(0,20,FlxG.width,"PATH: "+path);
				//add(t);
				infected.attackNearestHuman(collisionMap, path2);
				zombies.push(infected);
				remove(man,true);
				man.alive=false;
			}
			else{
				man.stunHuman();
			}
			}
		else{
			var t:FlxText;
			
			infected = new Zombie(man.x,man.y,man.width,man.health,man.drag.x,man.drag.y,man.maxVelocity.x,man.maxVelocity.y);
			//t = new FlxText(0,20,FlxG.width,"positionx" + infected.x + "positiony"+infected.y);
			//FlxG.collide(infected, collisionMap);
			var pos:int = humans.indexOf(man);
			//humans[pos].x=1000000000;
			humans.splice(pos,1);
			
			add(infected);
			var path:FlxPath =infected.findNearestHuman(collisionMap,humans,new FlxPoint(infected.x+infected.width/2,infected.y+infected.height/2));
			
			//t = new FlxText(0,20,FlxG.width,"PATH: "+path);
			//add(t);
			infected.attackNearestHuman(collisionMap, path);
			zombies.push(infected);
			remove(man,true);
			man.alive=false;
		}
			
		}
		public override function draw():void
		{
			super.draw();
			highlightBox.drawDebug();
		}
		
		private function setupPlayer():void
		{
			
			//zombie.addRoutePoints(new FlxPoint(24*TILE_WIDTH - zombie.width/2, 11*TILE_HEIGHT-zombie.height/2));
			//zombie.addRoutePoints(new FlxPoint(zombie.x,zombie.y));
			player = new Zombie(20, 20,14,14,640,640,80,80);
			player.loadGraphic(ImgSpaceman, true, true, 16);
			//bounding box tweaks
			player.width = 14;
			player.height = 14;
			player.offset.x = 1;
			player.offset.y = 1;
			
			//basic player physics
			player.drag.x = 640;
			player.drag.y = 640;
			//player.acceleration.y = 420;
			player.maxVelocity.x = 80;
			player.maxVelocity.y = 80;
			
			//animations
			player.addAnimation("idle", [0]);
			player.addAnimation("run", [0, 1, 2, 3], 12);
			zombies.push(player);


			//add(player);

		}
		

		private function updatePlayer():void
		{
			wrap(player);

			if (player.alive == false) {
				//losePic.loadGraphic(loseImg,false, false);
				//add(losePic);
			}
			
			for (var i:Number=0;i<doors.length;i++){
				keys[i].checkCollision(collisionMap, doors[i], player, Math.round((doors[i].x+doors[i].width/2)/TILE_WIDTH), Math.round((doors[i].y+doors[i].height/8)/TILE_HEIGHT),zombies);
				doors[i].updateDoor();
			}
			
			for each(var ud:UnlockedDoor in unlockedDoors){
				//trace(Math.abs((ud.y+ud.height/4)/TILE_HEIGHT));
				ud.checkCollision(collisionMap, player, Math.round((ud.x+ud.width/2)/TILE_WIDTH), Math.round((ud.y+ud.height/8)/TILE_HEIGHT),zombies);
				ud.updateDoor();
			}
			

			//MOVEMENT
			player.acceleration.x = 0;
			player.acceleration.y = 0;
			if(FlxG.keys.LEFT)
			{
				player.facing = FlxObject.LEFT;
				player.acceleration.x -= player.drag.x;
			}
			else if(FlxG.keys.RIGHT)
			{
				player.facing = FlxObject.RIGHT;
				player.acceleration.x += player.drag.x;
			}
			if(FlxG.keys.UP)
			{
				player.facing = FlxObject.UP;
				player.acceleration.y -= player.drag.y;
			}
			else if(FlxG.keys.DOWN)
			{
				player.facing = FlxObject.DOWN;
				player.acceleration.y += player.drag.y;
			}
			

			//ANIMATION
			 if(player.velocity.x == 0 && player.velocity.y == 0)
			{
				player.play("idle");
			}
			else
			{
				player.play("run");
			}
		
		}

		private function detect(looker:Human,lookee:FlxObject):Boolean
		{
			if(collisionMap.ray(new FlxPoint(looker.x + looker.width / 2, looker.y + looker.height / 2),new FlxPoint(lookee.x + lookee.width / 2, lookee.y + lookee.height / 2))){
				if(FlxU.getDistance(new FlxPoint(looker.x + looker.width / 2, looker.y + looker.height / 2),new FlxPoint(lookee.x + lookee.width / 2, lookee.y + lookee.height / 2))<=this.distanceCanSee){
					var angle:Number = FlxU.getAngle(new FlxPoint(looker.x + looker.width / 2, looker.y + looker.height / 2),new FlxPoint(lookee.x + lookee.width / 2, lookee.y + lookee.height / 2));
					if(angle>=looker.getAngle()-this.coneWidth && angle<=looker.getAngle()+this.coneWidth){
						return true;
					}
					//else if(looker.pathSpeed==0){
						//return true;
					//}
				}
			}
			return false;
			
		}
		
		private function wrap(obj:FlxObject):void
		{
			obj.x = (obj.x + obj.width / 2 + FlxG.width) % FlxG.width - obj.width / 2;
			obj.y = (obj.y + obj.height / 2) % FlxG.height - obj.height / 2;
		}
	}
} 
