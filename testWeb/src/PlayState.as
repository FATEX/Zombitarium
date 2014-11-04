package
{
	import flash.text.TextField;
	import flash.utils.ByteArray;
	
	import objects.Doctor;
	import objects.Human;
	import objects.Janitor;
	import objects.Nurse;
	import objects.Patient;
	import objects.Syringe;
	
	import org.flixel.FlxButton;
	import org.flixel.FlxCamera;
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	import org.flixel.FlxPath;
	import org.flixel.FlxPoint;
	import org.flixel.FlxRect;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxTilemap;
	import org.flixel.FlxU;

	public class PlayState extends FlxState
	{
		// Tileset that works with AUTO mode (best for thin walls)
		[Embed(source = 'wall_USE.png')]private static var auto_tiles:Class;
				
		// Default character loading texts		
		// [Embed(source = 'default_alt.txt', mimeType = 'application/octet-stream')]private static var default_alt:Class;
		// f[Embed(source = 'default_empty.txt', mimeType = 'application/octet-stream')]private static var default_empty:Class;
		[Embed(source = 'characters0.txt', mimeType = 'application/octet-stream')]private static var characters0:Class;
		[Embed(source = 'characters1.txt', mimeType = 'application/octet-stream')]private static var characters1:Class;
		[Embed(source = 'characters2.txt', mimeType = 'application/octet-stream')]private static var characters2:Class;
		[Embed(source = 'characters3.txt', mimeType = 'application/octet-stream')]private static var characters3:Class;
		[Embed(source = 'characters4.txt', mimeType = 'application/octet-stream')]private static var characters4:Class;
		[Embed(source = 'characters5.txt', mimeType = 'application/octet-stream')]private static var characters5:Class;
		[Embed(source = 'characters6.txt', mimeType = 'application/octet-stream')]private static var characters6:Class;
		[Embed(source = 'default_characters.txt', mimeType = 'application/octet-stream')]private static var default_characters:Class;
		[Embed(source = 'default_characters_level_middle.txt', mimeType = 'application/octet-stream')]private static var default_characters2:Class;
		[Embed(source = 'hard_level_characters.txt', mimeType = 'application/octet-stream')]private static var default_chars_hard:Class;

		// Default levels
		[Embed(source = 'level0.txt', mimeType = 'application/octet-stream')]private static var default_level0:Class;
		[Embed(source = 'level1.txt', mimeType = 'application/octet-stream')]private static var default_level1:Class;
		[Embed(source = 'level2.txt', mimeType = 'application/octet-stream')]private static var default_level2:Class;
		[Embed(source = 'level3.txt', mimeType = 'application/octet-stream')]private static var default_level3:Class;
		[Embed(source = 'level4.txt', mimeType = 'application/octet-stream')]private static var default_level4:Class;
		[Embed(source = 'level5.txt', mimeType = 'application/octet-stream')]private static var default_level5:Class;
		[Embed(source = 'level6.txt', mimeType = 'application/octet-stream')]private static var default_level6:Class;
		[Embed(source = 'default_auto.txt', mimeType = 'application/octet-stream')]private static var default_auto:Class;
		[Embed(source = 'level_middle.txt', mimeType = 'application/octet-stream')]private static var default_middle:Class;
		[Embed(source = 'level_hard.txt', mimeType = 'application/octet-stream')]private static var default_hard:Class;

		[Embed(source="zombie_combined.png")] private static var ImgSpaceman:Class;
		[Embed(source="blackScreen_100.png")] private static var BlackTile:Class;
		[Embed(source="basic_floor_tile_USE_65.png")] private static var FloorTile:Class;

		//logger
		private var playertime:Number = new Date().time;
		private var versionID:Number = 1;
		public var logger:Logging = new Logging(200,versionID,true);
		
		// Some static constants for the size of the tilemap tiles
		public const TILE_WIDTH:uint = 65;
		public const TILE_HEIGHT:uint = 65;
		
		// The FlxTilemap we're using
		private var collisionMap:FlxTilemap;
		
		private var facingDirection:int =0;
		
		// Box to show the user where they're placing stuff
		private var highlightBox:FlxObject;
		
		// Player modified from "Mode" demo

		public var player:Zombie;
		private var humans:Vector.<Human>;
		private var janitors:Vector.<Janitor>;
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
		private var instructions:FlxText;
		private var destination:FlxPoint;

		private var keys:Vector.<Key>;
		private var doors:Vector.<Door>;
		private var unlockedDoors:Vector.<UnlockedDoor>;
		
		public static var level:int = 0;
		
		private var infected:Zombie;
		private var area:FlxSprite;
		
		//Cameras
		private var cam:FlxCamera;
		private var camQuit:FlxCamera;
		private var camNextLevel:FlxCamera;
		private var camLevel:FlxCamera;
		
		private static var resetNumber:int = 0;
		
		//Decides wheter the rooms go dark or not
		public var darkRooms:Boolean=true;

		
		private var blankTiles:Array;
		
		//constants For detection
		private var distanceCanSee:int = 50/16*TILE_WIDTH;
		private var coneWidth:Number = 45;
		private var killWidth:Number = 90;
		private var throwable:Boolean = false;
		private var pSyringe: Syringe;
		private var dSyringe: Syringe;
		
		private var exitX:Number;
		private var exitY:Number;
		private var win:Boolean = false;
		private var cd:int = 50;
		private var youLoseScreen:FlxText;
		private var t;
		private var youWinScreen:FlxText;
		
		override public function create():void
		{
			FlxG.worldBounds = new FlxRect(0,0,TILE_WIDTH*100,TILE_HEIGHT*100);
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
			if(level==0){
				collisionMap.loadMap(new default_level0(), auto_tiles, TILE_WIDTH, TILE_HEIGHT, FlxTilemap.AUTO);	
			}
			else if(level==1){
				collisionMap.loadMap(new default_level1(), auto_tiles, TILE_WIDTH, TILE_HEIGHT, FlxTilemap.AUTO);
			}
			else if(level==2){
				collisionMap.loadMap(new default_level2(), auto_tiles, TILE_WIDTH, TILE_HEIGHT, FlxTilemap.AUTO);
			}
			else if(level==3){
				collisionMap.loadMap(new default_level3(), auto_tiles, TILE_WIDTH, TILE_HEIGHT, FlxTilemap.AUTO);
			}
			else if(level==4){
				collisionMap.loadMap(new default_level4(), auto_tiles, TILE_WIDTH, TILE_HEIGHT, FlxTilemap.AUTO);
			}
			else if(level==5){
				collisionMap.loadMap(new default_level5(), auto_tiles, TILE_WIDTH, TILE_HEIGHT, FlxTilemap.AUTO);
			}
			else if(level==6){
				collisionMap.loadMap(new default_level6(), auto_tiles, TILE_WIDTH, TILE_HEIGHT, FlxTilemap.AUTO);
			}
			else if(level==7){
				collisionMap.loadMap(new default_auto(), auto_tiles, TILE_WIDTH, TILE_HEIGHT, FlxTilemap.AUTO);
			}
			else if(level==8){
				collisionMap.loadMap(new default_middle(), auto_tiles, TILE_WIDTH, TILE_HEIGHT, FlxTilemap.AUTO);
			}
			else if(level==9){
				collisionMap.loadMap(new default_hard(), auto_tiles, TILE_WIDTH, TILE_HEIGHT, FlxTilemap.AUTO);
			}
			
			add(collisionMap);
			for(var i:int =0;i<collisionMap.widthInTiles;i++){
				for(var j:int=0;j<collisionMap.heightInTiles;j++){
					if(collisionMap.getTile(i,j)==0){
						var floorScreenTile:FlxSprite = new FlxSprite(i*TILE_WIDTH,j*TILE_HEIGHT);
						floorScreenTile.loadGraphic(FloorTile,false,false,TILE_WIDTH,TILE_HEIGHT);
						add(floorScreenTile);
					}
				}
			}
			highlightBox = new FlxObject(0, 0, TILE_WIDTH, TILE_HEIGHT);
			destination = new FlxPoint(0,0);
			setupPlayer();
			characterLoader();
			

			/*resetBtn = new FlxButton(-100, 42, "Reset", function():void
			{
				resetGame();
			});
			add(resetBtn);*/
			
			nextLevelBtn = new FlxButton(-100, 70, "Next Level", function():void
			{
				level++;
				level = level%10;
				resetGame();
			});
			add(nextLevelBtn);

			
			quitBtn = new FlxButton(-1000, 30, "Quit",
				function():void { FlxG.fade(0xff000000, 0.22, function():void { 
					level = 0;
					FlxG.resetGame();
				} ); } );
			add(quitBtn);
			
			
			t = new FlxButton(-10000, 30, "LEVEL " + (level+1));
			add(t);
			
			addCam();
			blankTiles = new Array();
			for(var q:int=0;q<collisionMap.widthInTiles;q++){
				blankTiles[q]=new Array();
			}
			for(var i:int =0;i<collisionMap.widthInTiles;i++){
				for(var j:int=0;j<collisionMap.heightInTiles;j++){
					if(collisionMap.getTile(i,j)==0 && this.darkRooms){
						var blankScreenTile:FlxSprite = new FlxSprite(i*TILE_WIDTH,j*TILE_HEIGHT);
						blankScreenTile.loadGraphic(BlackTile,false,false,TILE_WIDTH,TILE_HEIGHT);
						add(blankScreenTile);
						blankTiles[i][j]=blankScreenTile;
					}
					else{
						var blankScreenTile:FlxSprite = new FlxSprite(i*TILE_WIDTH,j*TILE_HEIGHT);
						blankScreenTile.loadGraphic(BlackTile,false,false,TILE_WIDTH,TILE_HEIGHT);
						//blankScreenTile.visible=false;
						add(blankScreenTile);
						blankTiles[i][j]=blankScreenTile;
					}
					
				}
			}
			revealBoard();			

			instructions = new FlxText(1*TILE_WIDTH,1*TILE_HEIGHT,10*TILE_WIDTH,"Arrow keys to move \nPress E to open doors \nPress R to reset");


			if (level==0) {
				add(instructions);
			} else if (level==1) {
				add(instructions = new FlxText(4*TILE_WIDTH,1*TILE_HEIGHT,6*TILE_WIDTH,"You can zombify humans by running into them from behind."))
			} else if (level==2) {
				add(instructions = new FlxText(7*TILE_WIDTH,1*TILE_HEIGHT,6*TILE_WIDTH,"BEWARE If a human sees you, it will go after you!"))
			} else if (level==3) {
				add(instructions = new FlxText(7*TILE_WIDTH,1*TILE_HEIGHT,6*TILE_WIDTH,"Humans can kill zombies...but not without getting stunned!"))
			} else if (level==4) {
				add(instructions = new FlxText(10*TILE_WIDTH,3*TILE_HEIGHT,6*TILE_WIDTH,"BEWARE Janitors see everything...And they also have keys"))
			} else if (level==5) {
				add(instructions = new FlxText(8*TILE_WIDTH,3*TILE_HEIGHT,6*TILE_WIDTH,"If you zombify a nurse you get disguised for 5 seconds!"))
			} else if (level==6) {
				add(instructions = new FlxText(8*TILE_WIDTH,3*TILE_HEIGHT,6*TILE_WIDTH,"If you zombify a doctor you get a syringe! Press SPACE to throw"))
			}
			instructions.setFormat(null,30/100*TILE_WIDTH);
	
		}
		
		public function revealBoard():void{
			if(this.darkRooms){
			for(var i:int =0;i<collisionMap.widthInTiles;i++){
				for(var j:int=0;j<collisionMap.heightInTiles;j++){
					//if(collisionMap.getTile(i,j)==0){
						(FlxSprite(blankTiles[i][j])).visible=true;
					//}
					//else{
						//(FlxSprite(blankTiles[i][j])).visible=false;
					//}
				}
			}
			var toVisit:Array = new Array(); 
			var playerTileX:int=player.x/TILE_WIDTH;
			var playerTileY:int=player.y/TILE_HEIGHT;
			toVisit.push([playerTileX,playerTileY]);
			toVisit.push([playerTileX+1,playerTileY+0]);
			toVisit.push([playerTileX+1,playerTileY+1]);
			toVisit.push([playerTileX+0,playerTileY+1]);
			toVisit.push([playerTileX+1,playerTileY-1]);
			toVisit.push([playerTileX-1,playerTileY-1]);
			toVisit.push([playerTileX+0,playerTileY-1]);
			toVisit.push([playerTileX-1,playerTileY+0]);
			toVisit.push([playerTileX-1,playerTileY+1]);
			while(toVisit.length>0){
				var currentNode:Array = toVisit.pop();
				if(collisionMap.getTile(currentNode[0],currentNode[1])==0 && (FlxSprite(blankTiles[currentNode[0]][currentNode[1]])).visible==true){
					(FlxSprite(blankTiles[currentNode[0]][currentNode[1]])).visible=false;
					toVisit.push([currentNode[0]+1,currentNode[1]+0]);
					toVisit.push([currentNode[0]+1,currentNode[1]+1]);
					toVisit.push([currentNode[0]+0,currentNode[1]+1]);
					toVisit.push([currentNode[0]+1,currentNode[1]-1]);
					toVisit.push([currentNode[0]-1,currentNode[1]-1]);
					toVisit.push([currentNode[0]+0,currentNode[1]-1]);
					toVisit.push([currentNode[0]-1,currentNode[1]+0]);
					toVisit.push([currentNode[0]-1,currentNode[1]+1]);
				}
				else {
					(FlxSprite(blankTiles[currentNode[0]][currentNode[1]])).visible=false;
				}
			}


			}
		}
		
		private function resetGame():void{
			if (win) {
				var t:FlxText;
				t = new FlxText(0,(FlxG.height/2-20),(FlxG.width),"Zombify");
				add(t);
			} else {
				FlxG.resetState();
			}
			win = false;
		}
		
		private function addCam():void {
			add(player);
			if(cam !=null){
				FlxG.removeCamera(cam,false);
				FlxG.removeCamera(camQuit,false);
				FlxG.removeCamera(camNextLevel,false);
				FlxG.removeCamera(camLevel,false);
			}
			else{
				cam = new FlxCamera(0,0, FlxG.width, FlxG.height,1); // we put the first one in the top left corner
				camQuit = new FlxCamera(2, 2, quitBtn.width, quitBtn.height);
				//camReset = new FlxCamera(2, 42, resetBtn.width, resetBtn.height);
				camNextLevel = new FlxCamera(2, 32, nextLevelBtn.width, nextLevelBtn.height);
				camLevel = new FlxCamera(2,62,t.width, t.height);

			}
			cam.follow(player);
			// this sets the limits of where the camera goes so that it doesn't show what's outside of the tilemap
			cam.setBounds(0,0,collisionMap.width, collisionMap.height);
			//cam.color = 0xFFFFFF; 
			FlxG.addCamera(cam);
			
			camQuit.follow(quitBtn);
			FlxG.addCamera(camQuit);
			
			camNextLevel.follow(nextLevelBtn);
			FlxG.addCamera(camNextLevel);
			
			camLevel.follow(t);
			FlxG.addCamera(camLevel);
		}
		
		
		private function characterLoader():void{
			humans = new Vector.<Human>();
			janitors = new Vector.<Janitor>();
			doors = new Vector.<Door>();
			keys = new Vector.<Key>();
			unlockedDoors = new Vector.<UnlockedDoor>();
			var btarray:ByteArray;
			if (level==0){
				btarray = new characters0();
			}else if(level==1){
				btarray = new characters1();
			}else if(level==2){
				btarray = new characters2();
			}else if(level==3){
				btarray = new characters3();
			}else if(level==4){
				btarray = new characters4();
			}else if(level==5){
				btarray = new characters5();
			}else if(level==6){
				btarray = new characters6();
			}else if(level==7){
				btarray = new default_characters();
			}else if(level==8){
				btarray = new default_characters2();
			}else if(level==9){
				btarray = new default_chars_hard();
			}
		
			var wholeLevel:String = btarray.readMultiByte(btarray.bytesAvailable, btarray.endian);
			var arLines:Array = wholeLevel.split("\n");
			var x:int;
			var y:int;
			var type:String;
			var lineArray:Array;
			var h:Human=new Human(0,0,true);
			//var d:Door = new Door(10, 10);
			var j:Janitor=new Janitor(0,0);
			var door:Door = new Door(0,0);
			var key:Key = new Key(collisionMap, door, player,0,0);
			var unlockedDoor:UnlockedDoor = new UnlockedDoor(0,0);
			var nextIsWinDoor:Boolean = false;
			for each (var singleLine:String in arLines)
			{
				lineArray = singleLine.split(",");
				//player.x=(lineArray.length-1)*TILE_WIDTH;
				//player.y=(lineArray.length-1)*TILE_HEIGHT;
				
				type = lineArray[0];
				x = int(lineArray[1]);
				y = int(lineArray[2]);
				if(type=="H"){
					h=new Human(x*TILE_WIDTH+h.width/2,y*TILE_HEIGHT+h.height/2,true);
					humans.push(h);
				}
				if(type=="J"){
					
					j = new Janitor(x*TILE_WIDTH+h.width/2,y*TILE_HEIGHT+h.height/2);
					humans.push(j);		
					key = new Key(collisionMap, door, player, x*TILE_WIDTH,y*TILE_HEIGHT+key.height/2);
					keys.push(key);
					j.key=key;
					j.key.visible=false;
				}
				if(type=="PATIENT"){
					h=new Patient(x*TILE_WIDTH+h.width/2,y*TILE_HEIGHT+h.height/2);
					humans.push(h);
				}
				if(type=="DOCTOR"){
					h=new Doctor(x*TILE_WIDTH+h.width/2,y*TILE_HEIGHT+h.height/2);
					humans.push(h);
				}
				if(type=="NURSE"){
					h=new Nurse(x*TILE_WIDTH+h.width/2,y*TILE_HEIGHT+h.height/2);
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
					door = new Door(x*TILE_WIDTH-door.width/4,y*TILE_HEIGHT-door.height/4);
					if(nextIsWinDoor){
						door.isWin = true;
						nextIsWinDoor = false;
					}
					doors.push(door);
				}
				if(type=="KEY"){
					key = new Key(collisionMap, door, player, x*TILE_WIDTH,y*TILE_HEIGHT+key.height/2);
					key.collectable = true;
					keys.push(key);
				}
				if(type=="UDOOR"){
					unlockedDoor = new UnlockedDoor(x*TILE_WIDTH-door.width/4,y*TILE_HEIGHT-door.height/4);
					if(nextIsWinDoor){
						unlockedDoor.isWin = true;
						nextIsWinDoor = false;
					}
					unlockedDoors.push(unlockedDoor);
					
				}
				if(type=="EXIT"){
					exitX = x*TILE_WIDTH;
					exitY = y*TILE_HEIGHT;
					nextIsWinDoor = true;
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
//			for each(var jan:Janitor in janitors){
//				add(jan);
//			}

			logger.recordLevelStart(level,"start level "+level);
		}
		
		override public function update():void
		{
			// Tilemaps can be collided just like any other FlxObject, and flixel
			// automatically collides each individual tile with the object.
			FlxG.collide(player, collisionMap);
			FlxG.collide(collisionMap, pSyringe,touchedH);
			for each(var hum:Human in humans){
				FlxG.collide(hum,pSyringe, touchedH);
			}
			FlxG.collide(collisionMap, dSyringe,touchedZ);
			for each(var zom:Zombie in zombies){
				FlxG.collide(zom,dSyringe, touchedZ);
			}
			
			//FlxG.collide(infected, collisionMap);
			
			highlightBox.x = Math.floor(FlxG.mouse.x / TILE_WIDTH) * TILE_WIDTH;
			highlightBox.y = Math.floor(FlxG.mouse.y / TILE_HEIGHT) * TILE_HEIGHT;
			
			
			updatePlayer();
			collideCheck(humans);
			//hitdetect(humans);
			//collideCheck(janitors);
			for(var w:int=0; w<zombies.length;w++){
				if(zombies[w]!= player){
					zombies[w].zombieUpdate(collisionMap,humans,new FlxPoint(zombies[w].x+zombies[w].width/2,zombies[w].y+zombies[w].height/2));
				}
			}
			
//			for(var t:int=0; t<janitors.length;t++){
//				janitors[t].die();
//			}
			
			super.update();
		}
		//var dis:Boolean = false;
		public function collideCheck(type):void {
			cd++;
			for(var i:int=0; i<type.length;i++){
				for (var j:int=0;j<zombies.length;j++){
					try{
						type[i].humanUpdate(collisionMap);
						
						if(zombies[j].alive && type[i].alive){
							FlxG.collide(zombies[j],type[i],collided);
							(Human(type[i])).alerted.x=(Human(type[i])).x;
							(Human(type[i])).alerted.y=(Human(type[i])).y-(Human(type[i])).height;
							if((Human(type[i])).alertAdded && !(Human(type[i])).alertedOfEnemy){
								remove((Human(type[i])).alerted);
								(Human(type[i])).alertAdded=false;
							}
						}
						
						if(zombies[j].alive && type[i].alive){
							
							if(detect(type[i],zombies[j])){
								if(type[i] is Doctor && cd >=50 ){
									/*var t:FlxText;
									var a:int = FlxU.getAngle(new FlxPoint(type[i].x + type[i].width/2, type[i].y+ type[i].height/2), new FlxPoint(zombies[i].x + zombies[i].width/2, zombies[i].y+ zombies[i].height/2));
									t = new FlxText(20,0,40, a.toString());
									t.size = 15;
									add(t);*/
									(Doctor(type[i])).stopFollowingPath();
									dSyringe = new Syringe(FlxU.getAngle(new FlxPoint(type[i].x + type[i].width/2, type[i].y+ type[i].height/2), new FlxPoint(zombies[j].x + zombies[j].width/2, zombies[j].y+ zombies[j].height/2)), type[i].x+type[i].width/2, type[i].y+type[i].height/2,zombies[j].x-type[i].x,zombies[j].y-type[i].y);
									dSyringe.angle = -90 + FlxU.getAngle(new FlxPoint(type[i].x + type[i].width/2, type[i].y+ type[i].height/2), new FlxPoint(zombies[j].x + zombies[j].width/2, zombies[j].y+ zombies[j].height/2));
									add(dSyringe);
									dSyringe.updatePos(10000);
									(Doctor(type[i])).goBack(collisionMap);
									cd = 0;
								}
								(Human(type[i])).alerted.x=(Human(type[i])).x;
								(Human(type[i])).alerted.y=(Human(type[i])).y-(Human(type[i])).height;
								if(!(Human(type[i])).alertAdded){
									add((Human(type[i])).alerted);
									(Human(type[i])).alertAdded = true;
									(Human(type[i])).alertedOfEnemy=true;
								}
								(Human(type[i])).alerted.play("alert");
								if(!(type[i] is Doctor)){
									if(!type[i].isFollowing)type[i].onRoute = false;
									type[i].setPath(new FlxPoint(zombies[j].x + zombies[j].width / 2, zombies[j].y + zombies[j].height / 2),collisionMap);
																	
								}
								//type[i].color=0xFFD700;
							}
							else if(type[i].pathSpeed==0 && (Human(type[i])).isFollowing){
								type[i].goBack(collisionMap);
								//type[i].onRoute = true;
								//dis = true;
								type[i].color=0xFFFFFF;
							}
							else if(type[i].isFollowing){
								//dis = true;
								//type[i].onRoute = true;
								(Human(type[i])).alerted.x=(Human(type[i])).x;
								(Human(type[i])).alerted.y=(Human(type[i])).y-(Human(type[i])).height;
								if(FlxG.collide(type[i],collisionMap)){
									remove((Human(type[i])).alerted);
									(Human(type[i])).alertAdded=false;
									type[i].goBack(collisionMap);
									type[i].color=0xFFFFFF;
								}
								(Human(type[i])).alertedOfEnemy=true;
								//dis = false;
							}
							else{
								//type[i].onRoute = true;
								//dis = false;
								type[i].color=0xFFFFFF;
								(Human(type[i])).alertedOfEnemy=false;
							}
						}
					}catch(e:Error){
						break;
					}
				}
			}
		}
		

		public function touchedZ(obj1:FlxObject,obj2:FlxObject):void{
			var syr: Syringe;
			var zom:Zombie;
			if(obj1 is FlxTilemap){
				syr = Syringe(obj2);
				remove(syr, true);
				syr.destroy();
				syr.exists = false;
				
			}
			else if(obj1 is Zombie){
				//syr.explode();//might be a problem
				zom = Zombie(obj1);
				syr = Syringe(obj2);
				var pos:int = zombies.indexOf(zom);
				zombies.splice(pos,1);
				remove(zom, true);
				remove(syr, true);
				zom.exists = false;
				zom.alive = false;
				syr.exists = false;
				syr.destory();
			}
		}
		
		public function touchedH(obj1:FlxObject,obj2:FlxObject):void{
			var syr: Syringe;
			var man: Human;
			if(obj1 is FlxTilemap){
				syr = Syringe(obj2);
				remove(syr, true);
				syr.destroy();
				syr.exists = false;
				
			}
			else if(obj1 is Human){
				man = Human(obj1);
				infected = new Zombie(man.x,man.y,man.width,man.height, man.drag.x,man.drag.y,man.maxVelocity.x,man.maxVelocity.y);
				var pos:int = humans.indexOf(man);
				humans.splice(pos,1);
				add(infected);
				var path:FlxPath =infected.findNearestHuman(collisionMap,humans,new FlxPoint(infected.x+infected.width/2,infected.y+infected.height/2));
				infected.attackNearestHuman(collisionMap, path);
				zombies.push(infected);
				remove(man.alerted);
				syr = Syringe(obj2);
				if(man is Janitor){
					var jan:Janitor = man as Janitor;
					jan.exists=false;
					jan.alive=false;
					jan.die();
				}
				man.alive = false;

				remove(man, true);
				remove(syr, true);
				man.exists = false;
				
				syr.explode();//might be a problem
				syr.destory();
				syr.exists = false;
			}
		}
		
		public function collided(obj1:FlxObject,obj2:FlxObject):void{
			var man:Human;
			var zom:Zombie;
			var nur:Nurse;
			if(obj1 is Human){
				if(obj2 is Zombie){
					man = Human(obj1);
					zom = Zombie(obj2);
				}else{
					return;
				}
			}else if(obj1 is Zombie){
				if(obj2 is Human){
					zom = Zombie(obj1);
					man = Human(obj2);
				}
				else{
					return;
				}
			}else{
				return;
			}
			if(this.canKill(man,zom)){
				if(man.isStunned || man is Patient){
					zom.disguiseOFF();
					infected = new Zombie(man.x,man.y,man.width,man.height, man.drag.x,man.drag.y,man.maxVelocity.x,man.maxVelocity.y);
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
					if(zom==player){
						if(man is Janitor){
							logger.recordEvent(level,1,"pos=("+(int)(player.x/TILE_WIDTH)+","+(int)(player.y/TILE_HEIGHT)+")|action:kill janitor");
						}else if(man is Nurse){
							logger.recordEvent(level,2,"pos=("+(int)(player.x/TILE_WIDTH)+","+(int)(player.y/TILE_HEIGHT)+")|action:kill nurse");
						}else if(man is Doctor){
							logger.recordEvent(level,3,"pos=("+(int)(player.x/TILE_WIDTH)+","+(int)(player.y/TILE_HEIGHT)+")|action:kill doctor");
						}else{
							logger.recordEvent(level,4,"pos=("+(int)(player.x/TILE_WIDTH)+","+(int)(player.y/TILE_HEIGHT)+")|action:kill human");
						}
					}
					if(man is Janitor){
						var jan:Janitor = man as Janitor;
						jan.die();
					}
					if(man is Nurse){
						if(zom==player){
							zom.disguiseON();
							if(this.facingDirection==0){
								player.play("idle",true);
							}
							else if(this.facingDirection==1){
								player.play("idleBack",true);
							}
							else if(this.facingDirection==2){
								player.play("right",true);
							}
							else if(this.facingDirection==3){
								player.play("topRight",true);
							}
							else if(this.facingDirection==4){
								player.play("bottomLeft",true);
								player.facing=FlxObject.RIGHT;
							}
							else if(this.facingDirection==5){
								player.play("right",true);
								player.facing=FlxObject.LEFT;
							}
							else if(this.facingDirection==6){
								player.play("bottomLeft",true);
							}
							else{
								player.play("topRight",true);
								player.facing=FlxObject.RIGHT;
							}
						}
					}
					if(man is Doctor){
						if(zom == player){
							throwable = true;
						}
						
					}
					remove(man,true);
					man.alive=false;
					
				}else{
					remove(zom,true);
					man.goBack(collisionMap);
					zom.alive=false;
					man.stunHuman();
					logger.recordEvent(level,5,"pos=("+(int)(player.x/TILE_WIDTH)+","+(int)(player.y/TILE_HEIGHT)+")|action:killed by human");
				}
				man.alerted.x=man.x;
				man.alerted.y=man.y-man.height;
				if(man.alertAdded){
					remove(man.alerted);
					man.alertAdded=false;
				}
			}
			else{
				zom.disguiseOFF();
				var t:FlxText;
			
				infected = new Zombie(man.x,man.y,man.width,man.height, man.drag.x,man.drag.y,man.maxVelocity.x,man.maxVelocity.y);
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
				if(man is Janitor){
					var jan:Janitor = man as Janitor;
					jan.die();
				}
				if(man is Nurse){
					if(zom==player){
						zom.disguiseON();
						if(this.facingDirection==0){
							player.play("idle",true);
						}
						else if(this.facingDirection==1){
							player.play("idleBack",true);
						}
						else if(this.facingDirection==2){
							player.play("right",true);
						}
						else if(this.facingDirection==3){
							player.play("topRight",true);
						}
						else if(this.facingDirection==4){
							player.play("bottomLeft",true);
							player.facing=FlxObject.RIGHT;
						}
						else if(this.facingDirection==5){
							player.play("right",true);
							player.facing=FlxObject.LEFT;
						}
						else if(this.facingDirection==6){
							player.play("bottomLeft",true);
						}
						else{
							player.play("topRight",true);
							player.facing=FlxObject.RIGHT;
						}
						
					}
				}
				if((man is Doctor) && zom == player){
					throwable = true;
				}
				if(zom==player){
					if(man is Janitor){
						logger.recordEvent(level,1,"pos=("+(int)(player.x/TILE_WIDTH)+","+(int)(player.y/TILE_HEIGHT)+")|action:kill janitor");
					}else if(man is Nurse){
						logger.recordEvent(level,2,"pos=("+(int)(player.x/TILE_WIDTH)+","+(int)(player.y/TILE_HEIGHT)+")|action:kill nurse");
					}else if(man is Doctor){
						logger.recordEvent(level,3,"pos=("+(int)(player.x/TILE_WIDTH)+","+(int)(player.y/TILE_HEIGHT)+")|action:kill doctor");
					}else{
						logger.recordEvent(level,4,"pos=("+(int)(player.x/TILE_WIDTH)+","+(int)(player.y/TILE_HEIGHT)+")|action:kill human");
					}
				}
				
				man.alerted.x=man.x;
				man.alerted.y=man.y-man.height;
				if(man.alertAdded){
					remove(man.alerted);
					man.alertAdded=false;
				}
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
			player = new Zombie(20, 20,TILE_WIDTH*7/8,TILE_HEIGHT*7/8,640/16*TILE_WIDTH,640/16*TILE_WIDTH,80/16*TILE_WIDTH,80/16*TILE_WIDTH);
			player.loadGraphic(ImgSpaceman, true, true, TILE_WIDTH,TILE_HEIGHT);
			//bounding box tweaks
			player.width = TILE_WIDTH*5/8;
			player.height = TILE_HEIGHT*7/8;
			player.offset.x = player.width/4;
			player.offset.y = 1;
			
			//basic player physics
			player.drag.x = 640/1*TILE_WIDTH;
			player.drag.y = 640/1*TILE_HEIGHT;
			//player.acceleration.y = 420;
			player.maxVelocity.x = 80/20*TILE_WIDTH;
			player.maxVelocity.y = 80/20*TILE_HEIGHT;
			
			//animations
			player.addAnimation("idle", [0]);
			player.addAnimation("run", [0, 1, 2, 3], 12);
			player.addAnimation("idleBack",[4]);
			player.addAnimation("runBack",[5,6,7,4],12);
			player.addAnimation("topRight",[10]);
			player.addAnimation("right",[8]);
			player.addAnimation("bottomLeft",[9]);
			zombies.push(player);


		}
		

		private function updatePlayer():void
		{
			//wrap(player);

			if (player.alive == false) {
				if(this.youLoseScreen ==null){
					logger.recordLevelEnd();
					this.youLoseScreen = new FlxText(-100000,0,820,"YOU LOSE TRY NOT TO GET CURED  Press R to restart");
					this.youLoseScreen.size=39;
					add(this.youLoseScreen);
					var camRe:FlxCamera = new FlxCamera(50, 300, this.youLoseScreen.width, this.youLoseScreen.height);
					camRe.follow(this.youLoseScreen);
					FlxG.addCamera(camRe);
				}
			}
						
			for (var i:Number=0;i<doors.length;i++){
				keys[i].checkCollision(collisionMap, doors[i], player, Math.round((doors[i].x+doors[i].width/4)/TILE_WIDTH), Math.round((doors[i].y+doors[i].height/4)/TILE_HEIGHT),zombies,this);
				doors[i].updateDoor();
				
			}
			
			for each(var ud:UnlockedDoor in unlockedDoors){
				//trace(Math.abs((ud.y)/TILE_HEIGHT));
				ud.checkCollision(collisionMap, player, Math.round((ud.x+ud.width/4)/TILE_WIDTH), Math.round((ud.y+ud.height/4)/TILE_HEIGHT),zombies,player,this);
				ud.updateDoor();
			}

//			for (var t:Number=0;t<janitors.length;t++) {
//				janitors[t].die();
//			}

			
			//MOVEMENT
			player.acceleration.x = 0;
			player.acceleration.y = 0;
			if(FlxG.keys.LEFT)
			{
				//player.facing = FlxObject.LEFT;
				player.acceleration.x -= player.drag.x;
			}
			else if(FlxG.keys.RIGHT)
			{
				//player.facing = FlxObject.RIGHT;
				player.acceleration.x += player.drag.x;
			}
			if(FlxG.keys.UP)
			{
				//player.facing = FlxObject.UP;
				player.acceleration.y -= player.drag.y;
			}
			else if(FlxG.keys.DOWN)
			{
				//player.facing = FlxObject.DOWN;
				player.acceleration.y += player.drag.y;
			}
			if(FlxG.keys.SPACE){
				if(throwable){
					logger.recordEvent(level,8,"pos=("+(int)(player.x/TILE_WIDTH)+","+(int)(player.y/TILE_HEIGHT)+")|action:use syringe");
					/*if(player.angle == 0 || player.angle == 180){
						pSyringe = new Syringe(player.angle, player.x+2, player.y);
					}
					else if(player.angle == 90 || player.angle == -90){
						pSyringe = new Syringe(player.angle, player.x, player.y+7);
					}*/
					var angleToThrow:Number;
					if(player.velocity.x>0 && player.velocity.y==0){
						angleToThrow=90;
					}
					else if(player.velocity.x>0 && player.velocity.y>0){
						angleToThrow=135;
					}
					else if(player.velocity.x>0 && player.velocity.y<0){
						angleToThrow=45;
					}
					else if(player.velocity.x==0 && player.velocity.y>0){
						angleToThrow=180;
					}
					else if(player.velocity.x<0 && player.velocity.y>0){
						angleToThrow=-135;
					}
					else if(player.velocity.x<0 && player.velocity.y==0){
						angleToThrow=-90;
					}
					else if(player.velocity.x<0 && player.velocity.y<0){
						angleToThrow=-45;
					}
					else if(player.velocity.x==0 && player.velocity.y<0){
						angleToThrow=0;
					}
					else{
						if(this.facingDirection==0){
							angleToThrow = 180;
						}
						else if(this.facingDirection==1){
							angleToThrow=0;
						}
						else if(this.facingDirection==2){
							angleToThrow=90;
						}
						else if(this.facingDirection==3){
							angleToThrow=45;
						}
						else if(this.facingDirection==4){
							angleToThrow=-135;
						}
						else if(this.facingDirection==5){
							angleToThrow=-90;
						}
						else if(this.facingDirection==6){
							angleToThrow=135;
						}
						else{
							angleToThrow=-45;
						}
					}
					pSyringe = new Syringe(angleToThrow, player.x+player.width/2, player.y+player.height/2, 0,0);
					pSyringe.angle = angleToThrow-90;
					add(pSyringe);
					pSyringe.updatePos(10000);
					throwable = false;
					//FlxG.collide(collisionMap, pSyringe, touchedH);
					/*for(var i1:int = 0; i1<humans.length; i1++){
						FlxG.collide(humans[i1],pSyringe, touchedH);
					}*/
					
				}
			}
			if(FlxG.keys.ALT){
				throwable = true;
			}
			if(FlxG.keys.justPressed("R")){
				resetGame();
			}
			
			//ANIMATION
			if(player.velocity.x>0 && player.velocity.y==0){
				player.play("right");
				player.facing=FlxObject.RIGHT;
				this.facingDirection=2;
			}
			else if(player.velocity.x>0 && player.velocity.y>0){
				player.play("bottomLeft");
				player.facing=FlxObject.LEFT;
				this.facingDirection=4;
			}
			else if(player.velocity.x>0 && player.velocity.y<0){
				player.play("topRight");
				player.facing=FlxObject.RIGHT;
				this.facingDirection=3;
			}
			else if(player.velocity.x==0 && player.velocity.y>0){
				player.play("run");
				player.facing=FlxObject.RIGHT;
				this.facingDirection=0;
			}
			else if(player.velocity.x<0 && player.velocity.y>0){
				player.play("bottomLeft");
				player.facing=FlxObject.RIGHT;
				this.facingDirection=6;
			}
			else if(player.velocity.x<0 && player.velocity.y==0){
				player.play("right");
				player.facing=FlxObject.LEFT;
				this.facingDirection=5;
			}
			else if(player.velocity.x<0 && player.velocity.y<0){
				player.play("topRight");
				player.facing=FlxObject.RIGHT;
				this.facingDirection=7;
			}
			else if(player.velocity.x==0 && player.velocity.y<0){
				
				player.play("runBack");
				player.facing=FlxObject.RIGHT;
				this.facingDirection=1;
			}
			else{
				if(this.facingDirection==0){
					player.play("idle");
				}
				else if(this.facingDirection==1){
					player.play("idleBack");
				}
				else if(this.facingDirection==2){
					player.play("right");
				}
				else if(this.facingDirection==3){
					player.play("topRight");
				}
				else if(this.facingDirection==4){
					player.play("bottomLeft");
					player.facing=FlxObject.RIGHT;
				}
				else if(this.facingDirection==5){
					player.play("right");
					player.facing=FlxObject.LEFT;
				}
				else if(this.facingDirection==6){
					player.play("bottomLeft");
				}
				else{
					player.play("topRight");
					player.facing=FlxObject.RIGHT;
				}
			}
			 
			if (Math.abs(player.x- (exitX))<=TILE_WIDTH/8 && Math.abs(player.y - (exitY))<=TILE_HEIGHT/8) {
				win == true;
				
				
				if(this.youWinScreen ==null){
					logger.recordLevelEnd();
					this.youWinScreen = new FlxText(-200000,0,820,"YAY YOU ZOMBIFIED THIS FLOOR!! Press R to continue to next floor");
					this.youWinScreen.size=39;
					add(this.youWinScreen);
					var camRev:FlxCamera = new FlxCamera(50, 300, this.youWinScreen.width, this.youWinScreen.height);
					camRev.follow(this.youWinScreen);
					FlxG.addCamera(camRev);
					level++;
					//level = level%10;
					//resetGame();
				
					
				}
			}
		
		}

		private function hitdetect(type){
			if(pSyringe != null){
				for(var i:int=0; i<type.length;i++){
					if(humans[i].alive && pSyringe.exists){
						FlxG.collide(humans[i],pSyringe,touchedH);
					}
				}
			}
			
		}
		private function detect(looker:Human,lookee:FlxObject):Boolean
		{
			if(lookee is Zombie){
				var lookeeZ:Zombie = lookee as Zombie;
				if(lookeeZ.isDisguised){
					return false;
				}
			}
			if(collisionMap.ray(new FlxPoint(looker.x + looker.width / 2, looker.y + looker.height / 2),new FlxPoint(lookee.x + lookee.width / 2, lookee.y + lookee.height / 2))){
				if(FlxU.getDistance(new FlxPoint(looker.x + looker.width / 2, looker.y + looker.height / 2),new FlxPoint(lookee.x + lookee.width / 2, lookee.y + lookee.height / 2))<=this.distanceCanSee){
					var angle:Number = FlxU.getAngle(new FlxPoint(looker.x + looker.width / 2, looker.y + looker.height / 2),new FlxPoint(lookee.x + lookee.width / 2, lookee.y + lookee.height / 2));
					if(angle>=looker.getAngle()-this.coneWidth && angle<=looker.getAngle()+this.coneWidth){
						return true;
					}
					else if(looker is Janitor){
						return true;
					}
				}
			}
			return false;
			
		}
		private function canKill(looker:Human,lookee:FlxObject):Boolean
		{
			if(lookee is Zombie){
				var lookeeZ:Zombie = lookee as Zombie;
				if(lookeeZ.isDisguised){
					return false;
				}
			}
			if(collisionMap.ray(new FlxPoint(looker.x + looker.width / 2, looker.y + looker.height / 2),new FlxPoint(lookee.x + lookee.width / 2, lookee.y + lookee.height / 2))){
				if(FlxU.getDistance(new FlxPoint(looker.x + looker.width / 2, looker.y + looker.height / 2),new FlxPoint(lookee.x + lookee.width / 2, lookee.y + lookee.height / 2))<=this.distanceCanSee){
					var angle:Number = FlxU.getAngle(new FlxPoint(looker.x + looker.width / 2, looker.y + looker.height / 2),new FlxPoint(lookee.x + lookee.width / 2, lookee.y + lookee.height / 2));
					var lAngle:int = looker.getAngle();
					if(angle < 0){
						angle = angle+360;
					}
					if(lAngle < 0){
						lAngle = lAngle +360
					}
					if(Math.abs(lAngle - angle) <=90 ){
						return true;
					}
					else if(looker is Janitor){
						return true;
					}
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
