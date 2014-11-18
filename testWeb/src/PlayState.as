package
{
	import flash.display.Shape;
	import flash.events.TimerEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	import flash.text.TextField;
	import flash.utils.ByteArray;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	
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
		[Embed(source = 'wall_USE2.png')]private static var auto_tiles:Class;
		[Embed(source = 'wall_USE3.png')]private static var coverTiles:Class;
		[Embed(source = 'wall_USE4.png')]private static var coverTiles2:Class;
		[Embed(source = 'wall_USE5.png')]private static var coverTiles3:Class;

		
		// Music
		[Embed(source = "bg.mp3")]private var MySound : Class; 		 
		private var sound : Sound; // not MySound! 
		private var myChannel:SoundChannel = new SoundChannel();
				
		[Embed(source = "click.mp3")]private var MySoundbtn : Class; 		 
		private var soundbtn : Sound; // not MySound! 
		private var myChannelbtn:SoundChannel = new SoundChannel();
		
		[Embed(source = "fts.mp3")]private var MySoundmvt : Class; 		 
		private var soundmvt : Sound; // not MySound! 
		private var myChannelmvt:SoundChannel = new SoundChannel();
		
		[Embed(source = "zdead.mp3")]private var MySoundhdead : Class; 		 
		private var soundhdead : Sound; // not MySound! 
		private var myChannelhdead:SoundChannel = new SoundChannel();
		
		[Embed(source = "zdd.mp3")]private var MySoundzdead : Class; 		 
		private var soundzdead : Sound; // not MySound! 
		private var myChannelzdead:SoundChannel = new SoundChannel();
		
		[Embed(source = "costm.mp3")]private var MySoundcostm : Class; 		 
		private var soundcostm : Sound; // not MySound! 
		private var myChannelcostm:SoundChannel = new SoundChannel();
		
		[Embed(source = "syrg.mp3")]private var MySoundsyrg : Class; 		 
		private var soundsyrg : Sound; // not MySound! 
		private var myChannelsyrg:SoundChannel = new SoundChannel();
		
		[Embed(source = "doorIO.mp3")]private var MySounddr : Class; 		 
		private var sounddr : Sound; // not MySound! 
		private var myChanneldr:SoundChannel = new SoundChannel();
				
		// Default character loading texts		
		[Embed(source = 'characters0.txt', mimeType = 'application/octet-stream')]private static var characters0:Class;
		[Embed(source = 'characters1.txt', mimeType = 'application/octet-stream')]private static var characters1:Class;
		[Embed(source = 'characters2.txt', mimeType = 'application/octet-stream')]private static var characters2:Class;
		[Embed(source = 'characters2T.txt', mimeType = 'application/octet-stream')]private static var characters2T:Class;
		[Embed(source = 'characters3.txt', mimeType = 'application/octet-stream')]private static var characters3:Class;
		[Embed(source = 'characters3T.txt', mimeType = 'application/octet-stream')]private static var characters3T:Class;
		[Embed(source = 'characters4.txt', mimeType = 'application/octet-stream')]private static var characters4:Class;
		[Embed(source = 'characters4T.txt', mimeType = 'application/octet-stream')]private static var characters4T:Class;
		[Embed(source = 'characters5.txt', mimeType = 'application/octet-stream')]private static var characters5:Class;
		[Embed(source = 'characters5T.txt', mimeType = 'application/octet-stream')]private static var characters5T:Class;
		[Embed(source = 'characters6.txt', mimeType = 'application/octet-stream')]private static var characters6:Class;
		[Embed(source = 'characters6T.txt', mimeType = 'application/octet-stream')]private static var characters6T:Class;
		[Embed(source = 'charactersAlice.txt', mimeType = 'application/octet-stream')]private static var chAlice:Class;
		[Embed(source = 'default_characters.txt', mimeType = 'application/octet-stream')]private static var default_characters:Class;
		[Embed(source = 'default_characters_level_middle.txt', mimeType = 'application/octet-stream')]private static var default_characters2:Class;
		[Embed(source = 'hard_level_characters.txt', mimeType = 'application/octet-stream')]private static var default_chars_hard:Class;

		// Default levels
		[Embed(source = 'level0.txt', mimeType = 'application/octet-stream')]private static var default_level0:Class;
		[Embed(source = 'level1.txt', mimeType = 'application/octet-stream')]private static var default_level1:Class;
		[Embed(source = 'level2.txt', mimeType = 'application/octet-stream')]private static var default_level2:Class;
		[Embed(source = 'level2T.txt', mimeType = 'application/octet-stream')]private static var default_level2T:Class;
		[Embed(source = 'level3.txt', mimeType = 'application/octet-stream')]private static var default_level3:Class;
		[Embed(source = 'level3T.txt', mimeType = 'application/octet-stream')]private static var default_level3T:Class;
		[Embed(source = 'level4.txt', mimeType = 'application/octet-stream')]private static var default_level4:Class;
		[Embed(source = 'level4T.txt', mimeType = 'application/octet-stream')]private static var default_level4T:Class;
		[Embed(source = 'level5.txt', mimeType = 'application/octet-stream')]private static var default_level5:Class;
		[Embed(source = 'level5T.txt', mimeType = 'application/octet-stream')]private static var default_level5T:Class;
		[Embed(source = 'level6.txt', mimeType = 'application/octet-stream')]private static var default_level6:Class;
		[Embed(source = 'level6T.txt', mimeType = 'application/octet-stream')]private static var default_level6T:Class;
		[Embed(source = 'levelAlice.txt', mimeType = 'application/octet-stream')]private static var default_levelAlice:Class;
		[Embed(source = 'default_auto.txt', mimeType = 'application/octet-stream')]private static var default_auto:Class;
		[Embed(source = 'level_middle.txt', mimeType = 'application/octet-stream')]private static var default_middle:Class;
		[Embed(source = 'level_hard.txt', mimeType = 'application/octet-stream')]private static var default_hard:Class;

		[Embed(source="zombie_combined.png")] private static var ImgSpaceman:Class;
		[Embed(source="human_dead.png")] private static var ImgHumanDead:Class;
		[Embed(source="doctor_dead.png")] private static var ImgDoctorDead:Class;
		[Embed(source="human_dead.png")] private static var ImgJanitorDead:Class;
		[Embed(source="nurse_dead.png")] private static var ImgNurseDead:Class;
		[Embed(source="blackScreen_100.png")] private static var BlackTile:Class;
		[Embed(source="basic_floor_tile_USE_65.png")] private static var FloorTile:Class;

		//logger
		public static var isPageLoaded:Boolean = false;
		private var playertime:Number = new Date().time;
		private static var versionID:Number = 3;
		public static var logger:Logging = new Logging(200,versionID,false);		
		private static var isMuted = false; 
		
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
	
		private var zombieNum:FlxButton;
		private var muteButton:FlxButton;
		private var syringeUI:FlxButton;
		
		private var keys:Vector.<Key>;
		private var doors:Vector.<Door>;
		private var unlockedDoors:Vector.<UnlockedDoor>;
		
		public static var level:int = 0;
		
		private var infected:Zombie;
		private var area:FlxSprite;
		private var exitDoor:DoorObject;
		//Cameras
		private var cam:FlxCamera;
		private var camQuit:FlxCamera;
		private var camNextLevel:FlxCamera;
		private var camLevel:FlxCamera;
		private var drawingCamera:FlxSprite;
		private var camSound:FlxCamera;
		
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
		private var zombieLimited:FlxText;
		private var t;
		private var youWinScreen:FlxText;
		private var powerUpMenu:FlxText;
		private var nkeys;
		private var nkeysC = 0;
		private var powerUp:Boolean = false;
		//private var stop_btn;
		public static var soundOn:Boolean = true;
		public static var isABTesting:Boolean = true;
		private var numberOfZombies = 0;
		private var pressed = true;
		
		override public function create():void
		{
			//SoundMixer.stopAll();
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
				collisionMap.loadMap(new default_level0(), auto_tiles, TILE_WIDTH, TILE_HEIGHT, FlxTilemap.OFF);	
			}
			else if(level==1){
				collisionMap.loadMap(new default_level1(), auto_tiles, TILE_WIDTH, TILE_HEIGHT, FlxTilemap.OFF);
			}
			else if(level==2){
				collisionMap.loadMap(new default_level2(), auto_tiles, TILE_WIDTH, TILE_HEIGHT, FlxTilemap.OFF);
			}
			else if(level==3){
				collisionMap.loadMap(new default_level2T(), auto_tiles, TILE_WIDTH, TILE_HEIGHT, FlxTilemap.OFF);
			}
			else if(level==4){
				collisionMap.loadMap(new default_level3(), auto_tiles, TILE_WIDTH, TILE_HEIGHT, FlxTilemap.OFF);
			}
			else if(level==5){
				collisionMap.loadMap(new default_level3T(), auto_tiles, TILE_WIDTH, TILE_HEIGHT, FlxTilemap.OFF);
			}
			else if(level==6){
				collisionMap.loadMap(new default_level4(), auto_tiles, TILE_WIDTH, TILE_HEIGHT, FlxTilemap.OFF);
			}
			else if(level==7){
				collisionMap.loadMap(new default_level4T(), auto_tiles, TILE_WIDTH, TILE_HEIGHT, FlxTilemap.OFF);
			}
			else if(level==8){
				collisionMap.loadMap(new default_level5(), auto_tiles, TILE_WIDTH, TILE_HEIGHT, FlxTilemap.OFF);
			}
			else if(level==9){
				collisionMap.loadMap(new default_level5T(), auto_tiles, TILE_WIDTH, TILE_HEIGHT, FlxTilemap.OFF);
			}
			else if(level==10){
				collisionMap.loadMap(new default_level6(), auto_tiles, TILE_WIDTH, TILE_HEIGHT, FlxTilemap.OFF);
			}
			else if(level==11){
				collisionMap.loadMap(new default_level6T(), auto_tiles, TILE_WIDTH, TILE_HEIGHT, FlxTilemap.OFF);
			}
			else if(level==12){
				collisionMap.loadMap(new default_auto(), auto_tiles, TILE_WIDTH, TILE_HEIGHT, FlxTilemap.OFF);
			}
			else if(level==13){
				collisionMap.loadMap(new default_middle(), auto_tiles, TILE_WIDTH, TILE_HEIGHT, FlxTilemap.OFF);
			}
			else if(level==14){
				collisionMap.loadMap(new default_hard(), auto_tiles, TILE_WIDTH, TILE_HEIGHT, FlxTilemap.OFF);
			}
			else if(level==15){
				collisionMap.loadMap(new default_levelAlice(), auto_tiles, TILE_WIDTH, TILE_HEIGHT, FlxTilemap.OFF);
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
			for(var i:int =0;i<collisionMap.widthInTiles;i++){
				for(var j:int=0;j<collisionMap.heightInTiles;j++){
					if(j+1<collisionMap.heightInTiles && i+1<collisionMap.widthInTiles && collisionMap.getTile(i,j+1)==0 && collisionMap.getTile(i,j)==1 && collisionMap.getTile(i+1,j)==0){
						var coverSpr3:FlxSprite = new FlxSprite(i*TILE_WIDTH,(j)*TILE_HEIGHT);
						coverSpr3.loadGraphic(coverTiles3,false,false,TILE_WIDTH,TILE_HEIGHT);
						add(coverSpr3);
					}
					else if(j+1<collisionMap.heightInTiles && collisionMap.getTile(i,j+1)==0 && collisionMap.getTile(i,j)==1){
						var coverSpr:FlxSprite = new FlxSprite(i*TILE_WIDTH,(j)*TILE_HEIGHT);
						coverSpr.loadGraphic(coverTiles,false,false,TILE_WIDTH,TILE_HEIGHT);
						add(coverSpr);
					}
					else if(i+1<collisionMap.widthInTiles && collisionMap.getTile(i+1,j)==0 && collisionMap.getTile(i,j)==1){
						var coverSpr2:FlxSprite = new FlxSprite(i*TILE_WIDTH,(j)*TILE_HEIGHT);
						coverSpr2.loadGraphic(coverTiles2,false,false,TILE_WIDTH,TILE_HEIGHT);
						add(coverSpr2);
					}
					
				}
			}
			highlightBox = new FlxObject(0, 0, TILE_WIDTH, TILE_HEIGHT);
			destination = new FlxPoint(0,0);
			setupPlayer();
			characterLoader();
			
			
//			var test = setInterval(startbgsounds,0);
//			
//			function startbgsounds():void{
//				if (soundOn) {
//				sound = (new MySound()) as Sound;
//				myChannel = sound.play(0,10);
//				clearInterval(test);
//				}
//			}
			
			sound = (new MySound()) as Sound;
			if(soundOn){
				myChannel = sound.play(0,10);
			}
			
			nextLevelBtn = new FlxButton(-100, 70, "Next Level", function():void
			{
				if (soundOn) {
				soundbtn = (new MySoundbtn()) as Sound;
				myChannelbtn = soundbtn.play();
				}
			
				level++;
				level = level%16;
				resetGame();
			});
			add(nextLevelBtn);

			quitBtn = new FlxButton(-1000, 30, "Quit",
				function():void { FlxG.fade(0xff000000, 0.22, function():void { 
					level = 0;
					SoundMixer.stopAll();
					if (soundOn) {
					soundbtn = (new MySoundbtn()) as Sound;
					myChannelbtn = soundbtn.play();
					}
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
						var blankScreenTile:FlxSprite = new FlxSprite(i*TILE_WIDTH-5,j*TILE_HEIGHT);
						blankScreenTile.loadGraphic(BlackTile,false,false,TILE_WIDTH+5,TILE_HEIGHT);
						add(blankScreenTile);
						blankTiles[i][j]=blankScreenTile;
					}
					else{
						var blankScreenTile:FlxSprite = new FlxSprite(i*TILE_WIDTH-5,j*TILE_HEIGHT);
						blankScreenTile.loadGraphic(BlackTile,false,false,TILE_WIDTH+5,TILE_HEIGHT);
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
			} else if (level==4) {
				add(instructions = new FlxText(7*TILE_WIDTH,1*TILE_HEIGHT,6*TILE_WIDTH,"Humans can kill zombies...but not without getting stunned!"))
			} else if (level==6) {
				add(instructions = new FlxText(10*TILE_WIDTH,3*TILE_HEIGHT,6*TILE_WIDTH,"BEWARE Janitors see everything...And they also have keys"))
			} else if (level==8) {
				add(instructions = new FlxText(8*TILE_WIDTH,3*TILE_HEIGHT,6*TILE_WIDTH,"If you zombify a nurse you get disguised for 5 seconds!"))
			} else if (level==10) {
				add(instructions = new FlxText(8*TILE_WIDTH,3*TILE_HEIGHT,6*TILE_WIDTH,"If you zombify a doctor you get a syringe! Press SPACE to throw"))
			}
			instructions.setFormat(null,30/100*TILE_WIDTH);
			
			if(isABTesting){
			zombieNum = new FlxButton(FlxG.width-100, 40,"Zombies:"+(zombies.length-1)+"/2");
			}
			else{
				zombieNum = new FlxButton(FlxG.width-100, 40,"Zombies:"+(zombies.length-1));
			}
			zombieNum.scrollFactor.x=zombieNum.scrollFactor.y=0;
			add(zombieNum);			
			
			muteButton = new FlxButton(FlxG.width-100, 0,"Mute",function():void{
				soundbtn = (new MySoundbtn()) as Sound;
				myChannelbtn = soundbtn.play();
				if (soundOn) {
					soundOn = false;
					//SoundMixer.stopAll();
					//myChannel.soundTransform = new SoundTransform(0);
					myChannel.stop();
					muteButton.label.text = "Mute";
				} else {
					//myChannel.soundTransform = new SoundTransform(1);
					myChannel = sound.play(0,10);
					soundOn = true;
					muteButton.label.text = "UnMute";
				}
			});
			if(soundOn){
				//FlxG.mute = false;
			}else{
				//FlxG.mute = true;
				muteButton.label.text = "UnMute";
			}
			muteButton.scrollFactor.x=muteButton.scrollFactor.y=0;
			add(muteButton);
			
			syringeUI = new FlxButton(FlxG.width-100, 80,"syringe:"+"false");
			syringeUI.scrollFactor.x=syringeUI.scrollFactor.y=0;
			add(syringeUI);
			
			logger.recordLevelStart(level+1,"start level "+(level+1));
			//logger.recordEvent(level+1,100,"level starts");
			this.drawingCamera = new FlxSprite(0,0);
			this.drawingCamera.makeGraphic(1000,2000,0xffffff);
			add(this.drawingCamera);
		}
		
		public function setABTesting(value:int):void{
			if(value == 1){
				isABTesting = true;
			}
			else if(value == 2){
				isABTesting = false;
			}
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
			myChannel.stop();
			FlxG.resetState();
			win = false;
			
		}
		
		private function addCam():void {
			//add(player);
			if(cam !=null){
				FlxG.removeCamera(cam,false);
				FlxG.removeCamera(camQuit,false);
				FlxG.removeCamera(camNextLevel,false);
				FlxG.removeCamera(camLevel,false);
				FlxG.removeCamera(camSound,false);
			}
			else{
				cam = new FlxCamera(0,0, FlxG.width, FlxG.height,1); // we put the first one in the top left corner
				camQuit = new FlxCamera(2, 2, quitBtn.width, quitBtn.height);
				//camReset = new FlxCamera(2, 42, resetBtn.width, resetBtn.height);
				camNextLevel = new FlxCamera(2, 32, nextLevelBtn.width, nextLevelBtn.height);
				camLevel = new FlxCamera(2,62,t.width, t.height);
				camSound = new FlxCamera(2,92, quitBtn.width, quitBtn.height);

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
			
			//camSound.follow(stop_btn);
			//FlxG.addCamera(camSound);
			
			this.powerUpMenu = new FlxText(-6000,0,100,"Powerup: " + powerUp.toString() + "\nKeys: " + nkeysC + "/" + nkeys);
			this.powerUpMenu.size=12;
			
			
			if(isABTesting){
				this.zombieLimited = new FlxText(-100000,-100000,820,"0/2");
				this.zombieLimited.size=39;
				add(this.zombieLimited);
				var camRe:FlxCamera = new FlxCamera(810, 0, this.zombieLimited.width, this.zombieLimited.height);
				camRe.follow(this.zombieLimited);
				FlxG.addCamera(camRe);
			}
			
//			add(this.powerUpMenu);
//			var camRe:FlxCamera = new FlxCamera(0, 100, this.powerUpMenu.width, this.powerUpMenu.height);
//			camRe.follow(this.powerUpMenu);
//			FlxG.addCamera(camRe);
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
				btarray = new characters2T();
			}else if(level==4){
				btarray = new characters3();
			}else if(level==5){
				btarray = new characters3T();
			}else if(level==6){
				btarray = new characters4();
			}else if(level==7){
				btarray = new characters4T();
			}else if(level==8){
				btarray = new characters5();
			}else if(level==9){
				btarray = new characters5T();
			}else if(level==10){
				btarray = new characters6();
			}else if(level==11){
				btarray = new characters6T();
			}else if(level==12){
				btarray = new default_characters();
			}else if(level==13){
				btarray = new default_characters2();
			}else if(level==14){
				btarray = new default_chars_hard();
			}else if(level==15){
				btarray = new chAlice();
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
			var unId:int = 0;
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
					h.ID=unId;
					unId++;
					humans.push(h);
				}
				if(type=="J"){
					
					j = new Janitor(x*TILE_WIDTH+h.width/2,y*TILE_HEIGHT+h.height/2);
					humans.push(j);		
					key = new Key(collisionMap, door, player, x*TILE_WIDTH,y*TILE_HEIGHT+key.height/2);
					keys.push(key);
					j.key=key;
					j.key.visible=false;
					j.ID=unId;
					unId++;
				}
				if(type=="PATIENT"){
					h=new Patient(x*TILE_WIDTH+h.width/2,y*TILE_HEIGHT+h.height/2);
					h.ID=unId;
					unId++;
					humans.push(h);
				}
				if(type=="DOCTOR"){
					h=new Doctor(x*TILE_WIDTH+h.width/2,y*TILE_HEIGHT+h.height/2);
					h.ID=unId;
					unId++;
					humans.push(h);
				}
				if(type=="NURSE"){
					h=new Nurse(x*TILE_WIDTH+h.width/2,y*TILE_HEIGHT+h.height/2);
					h.ID=unId;
					unId++;
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
						this.exitDoor=door;
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
						this.exitDoor=unlockedDoor;
					}
					unlockedDoors.push(unlockedDoor);
					
				}
				if(type=="EXIT"){
					exitX = x*TILE_WIDTH;
					exitY = y*TILE_HEIGHT;
					nextIsWinDoor = true;
				}
				if(type=="NKEYS") {
					nkeys = x;
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

			add(player);
		}
		
		override public function update():void
		{
			// Tilemaps can be collided just like any other FlxObject, and flixel
			// automatically collides each individual tile with the object.
			FlxG.collide(player, collisionMap);
			FlxG.collide(collisionMap, pSyringe,touchedH);
			this.drawingCamera.fill(0x00000000);
			for each(var hum:Human in humans){
				try{
				if(!FlxSprite(this.blankTiles[int(hum.x/TILE_WIDTH)][int(hum.y/TILE_HEIGHT)]).visible){
					var triangle:Shape = new Shape(); 
					var sides:Number = 5;
					var xP:Vector.<Number> = new Vector.<Number>();
					var yP:Vector.<Number> = new Vector.<Number>();
					var startDegree:Number = hum.getAngle()-45;
					var degrees:Number = 90;
					if(hum is Janitor){
						sides=20;
						degrees=360;
					}
					var radius:Number = distanceCanSee;
					var centerX:Number = -this.cam.width/2-this.cam.scroll.x+hum.x+hum.width/2;
					var centerY:Number = -this.cam.height/2-this.cam.scroll.y+hum.y+hum.height/2;
					for(var i:Number =0; i<=sides; i++){
						xP.push(centerX + (Math.sin((startDegree + (degrees * ( i / sides))) *0.0174532925) * radius));
						yP.push(centerY - (Math.cos((startDegree + (degrees * ( i /  sides)))*0.0174532925 ) * radius))
					}
					for(var j:int=0;j<xP.length-1;j++){
						if(this.cam.getContainerSprite().getChildByName("tri"+j+hum.ID)!=null){
							this.cam.getContainerSprite().removeChild(this.cam.getContainerSprite().getChildByName("tri"+j+hum.ID));
						}
						if(player.isDisguised){
							triangle.graphics.beginFill(0x00FF00); 
						}
						else{
							triangle.graphics.beginFill(0xFF0000); 
						}
						triangle.graphics.moveTo(centerX, centerY); 
						triangle.graphics.lineTo(xP[j], yP[j]); 
						triangle.graphics.lineTo(xP[j+1], yP[j+1]); 
						triangle.graphics.lineTo(centerX , centerY); 
						triangle.name="tri"+j+hum.ID;
						triangle.alpha=.25;
						if(!hum.isStunned){
							this.cam.getContainerSprite().addChild(triangle);
						}
					}
				}
				else{
					for(var j:int=0;j<20;j++){
						if(this.cam.getContainerSprite().getChildByName("tri"+j+hum.ID)!=null){
							this.cam.getContainerSprite().removeChild(this.cam.getContainerSprite().getChildByName("tri"+j+hum.ID));
						}
					}
				}
				}
				catch(e:Error){
					trace("something");
				}
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
			if(isABTesting){
				zombieNum.label.text = "Zombies:"+(zombies.length-1)+"/2";
			}
			else{
				zombieNum.label.text = "Zombies:"+(zombies.length-1);
			}
			syringeUI.label.text = "Syringe:"+ throwable.toString();
			
			super.update();
		}
		//var dis:Boolean = false;
		public function collideCheck(type):void {
			cd++;
			for(var i:int=0; i<type.length;i++){
				for (var j:int=0;j<zombies.length;j++){
					try{
						type[i].humanUpdate(collisionMap);
						if(!(Human(type[i])).isStunned && (Human(type[i])).stunAdded){
							(Human(type[i])).stunAdded=false;
							remove((Human(type[i])).stunAn,true);
						}
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
								if(type[i] is Doctor && cd >=50 && !type[i].isStunned){
									/*var t:FlxText;
									var a:int = FlxU.getAngle(new FlxPoint(type[i].x + type[i].width/2, type[i].y+ type[i].height/2), new FlxPoint(zombies[i].x + zombies[i].width/2, zombies[i].y+ zombies[i].height/2));
									t = new FlxText(20,0,40, a.toString());
									t.size = 15;
									add(t);*/
									(Doctor(type[i])).stopFollowingPath();
									dSyringe = new Syringe(FlxU.getAngle(new FlxPoint(type[i].x + type[i].width/2, type[i].y+ type[i].height/2), new FlxPoint(zombies[j].x + zombies[j].width/2, zombies[j].y+ zombies[j].height/2)), type[i].x+type[i].width/2, type[i].y+type[i].height/2,zombies[j].x-type[i].x,zombies[j].y-type[i].y, 1);
									dSyringe.angle = -90 + FlxU.getAngle(new FlxPoint(type[i].x + type[i].width/2, type[i].y+ type[i].height/2), new FlxPoint(zombies[j].x + zombies[j].width/2, zombies[j].y+ zombies[j].height/2));
									add(dSyringe);
									if (soundOn) {
									soundsyrg = (new MySoundsyrg()) as Sound;
									myChannelsyrg = soundsyrg.play(); }
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
				if(zom==player){
					logger.recordEvent(level+1,36,"pos=("+(int)(zom.x/TILE_WIDTH)+","+(int)(zom.y/TILE_HEIGHT)+")|action:killed by syringe");
				}else{
					logger.recordEvent(level+1,37,"pos=("+(int)(zom.x/TILE_WIDTH)+","+(int)(zom.y/TILE_HEIGHT)+")|action:zombie killed by syringe");
				}
				if(obj1 == player && player.isDisguised){
					syr = Syringe(obj2);
					remove(syr, true);
					syr.destroy();
					syr.exists = false;
				}
				else{
					//syr.explode();//might be a problem
					if(isABTesting){
						if(zom != player) numberOfZombies--;
						zombieLimited.text = numberOfZombies + "/2"; 
					}
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
				/*zombies.splice(pos,1);
				remove(zom, true);
				remove(syr, true);
				zom.exists = false;
				zom.alive = false;
				syr.exists = false;
				syr.destory();*/
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
				if (soundOn) {
				soundhdead = (new MySoundhdead()) as Sound;
				myChannelhdead = soundhdead.play();
				}
				var pos:int = humans.indexOf(man);
				for(var j:int=0;j<20;j++){
					if(this.cam.getContainerSprite().getChildByName("tri"+j+man.ID)!=null){
						this.cam.getContainerSprite().removeChild(this.cam.getContainerSprite().getChildByName("tri"+j+man.ID));
					}
				}


				if(isABTesting){
					if(numberOfZombies < 2){
						numberOfZombies++;
						zombieLimited.text = numberOfZombies + "/2"; 
						infected = new Zombie(man.x,man.y,man.width,man.height, man.drag.x,man.drag.y,man.maxVelocity.x,man.maxVelocity.y);
						if(man.stunAdded){
							man.stunAdded=false;
							remove(man.stunAn,true);
						}
						if (man is Doctor) {
							infected.setImage(ImgDoctorDead);
						} else if (man is Nurse) {
							infected.setImage(ImgNurseDead);
						} else if (man is Janitor) {
							infected.setImage(ImgJanitorDead);
						} else {
							infected.setImage(ImgHumanDead);
						}
						if(man is Janitor){
							logger.recordEvent(level+1,31,"pos=("+(int)(man.x/TILE_WIDTH)+","+(int)(man.y/TILE_HEIGHT)+")|action:syringe kill janitor");
						}else if(man is Nurse){
							logger.recordEvent(level+1,32,"pos=("+(int)(man.x/TILE_WIDTH)+","+(int)(man.y/TILE_HEIGHT)+")|action:syringe kill nurse");
						}else if(man is Doctor){
							logger.recordEvent(level+1,33,"pos=("+(int)(man.x/TILE_WIDTH)+","+(int)(man.y/TILE_HEIGHT)+")|action:syringe kill doctor");
						}else if(man is Patient){
							logger.recordEvent(level+1,34,"pos=("+(int)(man.x/TILE_WIDTH)+","+(int)(man.y/TILE_HEIGHT)+")|action:syringe kill patient");							
						}else{
							logger.recordEvent(level+1,35,"pos=("+(int)(man.x/TILE_WIDTH)+","+(int)(man.y/TILE_HEIGHT)+")|action:syringe kill human");
						}
						var pos:int = humans.indexOf(man);
						humans.splice(pos,1);
						remove(player);
						add(infected);
						add(player);
						var path:FlxPath =infected.findNearestHuman(collisionMap,humans,new FlxPoint(infected.x+infected.width/2,infected.y+infected.height/2));
						infected.attackNearestHuman(collisionMap, path);
						zombies.push(infected);
						remove(man.alerted);
						if(!man.isStunned && man.stunAdded){
							man.stunAdded=false;
							remove(man.stunAn,true);
						}
						syr = Syringe(obj2);
						if(man is Janitor){
							var jan:Janitor = man as Janitor;
							jan.exists=false;
							jan.alive=false;
							jan.die();
						}
						man.alive = false;
						if(!man.isStunned && man.stunAdded){
							man.stunAdded=false;
							remove(man.stunAn,true);
						}
						for(var j:int=0;j<20;j++){
							if(this.cam.getContainerSprite().getChildByName("tri"+j+man.ID)!=null){
								this.cam.getContainerSprite().removeChild(this.cam.getContainerSprite().getChildByName("tri"+j+man.ID));
							}
						}
						remove(man, true);
						remove(syr, true);
						man.exists = false;
						
						syr.explode();//might be a problem
						syr.destory();
						syr.exists = false;
					}
					else{
						//zombie >2
						if(man is Janitor){
							logger.recordEvent(level+1,31,"pos=("+(int)(man.x/TILE_WIDTH)+","+(int)(man.y/TILE_HEIGHT)+")|action:syringe kill janitor");
						}else if(man is Nurse){
							logger.recordEvent(level+1,32,"pos=("+(int)(man.x/TILE_WIDTH)+","+(int)(man.y/TILE_HEIGHT)+")|action:syringe kill nurse");
						}else if(man is Doctor){
							logger.recordEvent(level+1,33,"pos=("+(int)(man.x/TILE_WIDTH)+","+(int)(man.y/TILE_HEIGHT)+")|action:syringe kill doctor");
						}else if(man is Patient){
							logger.recordEvent(level+1,34,"pos=("+(int)(man.x/TILE_WIDTH)+","+(int)(man.y/TILE_HEIGHT)+")|action:syringe kill patient");							
						}else{
							logger.recordEvent(level+1,35,"pos=("+(int)(man.x/TILE_WIDTH)+","+(int)(man.y/TILE_HEIGHT)+")|action:syringe kill human");
						}
						var pos:int = humans.indexOf(man);
						humans.splice(pos,1);
						remove(man.alerted);
						if(!man.isStunned && man.stunAdded){
							man.stunAdded=false;
							remove(man.stunAn,true);
						}
						syr = Syringe(obj2);
						if(man is Janitor){
							var jan:Janitor = man as Janitor;
							jan.exists=false;
							jan.alive=false;
							jan.die();
						}
						man.alive = false;
						if(!man.isStunned && man.stunAdded){
							man.stunAdded=false;
							remove(man.stunAn,true);
						}
						for(var j:int=0;j<20;j++){
							if(this.cam.getContainerSprite().getChildByName("tri"+j+man.ID)!=null){
								this.cam.getContainerSprite().removeChild(this.cam.getContainerSprite().getChildByName("tri"+j+man.ID));
							}
						}
						remove(man, true);
						remove(syr, true);
						man.exists = false;
						
						syr.explode();//might be a problem
						syr.destory();
						syr.exists = false;
					}
				}
				else{
					//not AB testing
					infected = new Zombie(man.x,man.y,man.width,man.height, man.drag.x,man.drag.y,man.maxVelocity.x,man.maxVelocity.y);
					/*if(man.stunAdded){
						man.stunAdded=false;
						remove(man.stunAn,true);
					}*/
					if (man is Doctor) {
						infected.setImage(ImgDoctorDead);
					} else if (man is Nurse) {
						infected.setImage(ImgNurseDead);
					} else if (man is Janitor) {
						infected.setImage(ImgJanitorDead);
					} else {
						infected.setImage(ImgHumanDead);
					}
					if(man is Janitor){
						logger.recordEvent(level+1,31,"pos=("+(int)(man.x/TILE_WIDTH)+","+(int)(man.y/TILE_HEIGHT)+")|action:syringe kill janitor");
					}else if(man is Nurse){
						logger.recordEvent(level+1,32,"pos=("+(int)(man.x/TILE_WIDTH)+","+(int)(man.y/TILE_HEIGHT)+")|action:syringe kill nurse");
					}else if(man is Doctor){
						logger.recordEvent(level+1,33,"pos=("+(int)(man.x/TILE_WIDTH)+","+(int)(man.y/TILE_HEIGHT)+")|action:syringe kill doctor");
					}else if(man is Patient){
						logger.recordEvent(level+1,34,"pos=("+(int)(man.x/TILE_WIDTH)+","+(int)(man.y/TILE_HEIGHT)+")|action:syringe kill patient");							
					}else{
						logger.recordEvent(level+1,35,"pos=("+(int)(man.x/TILE_WIDTH)+","+(int)(man.y/TILE_HEIGHT)+")|action:syringe kill human");
					}
					var pos:int = humans.indexOf(man);
					humans.splice(pos,1);
					remove(player);
					add(infected);
					add(player);
					var path:FlxPath =infected.findNearestHuman(collisionMap,humans,new FlxPoint(infected.x+infected.width/2,infected.y+infected.height/2));
					infected.attackNearestHuman(collisionMap, path);
					zombies.push(infected);
					remove(man.alerted);
					if(!man.isStunned && man.stunAdded){
						man.stunAdded=false;
						remove(man.stunAn,true);
					}
					syr = Syringe(obj2);
					if(man is Janitor){
						var jan:Janitor = man as Janitor;
						jan.exists=false;
						jan.alive=false;
						jan.die();
					}
					man.alive = false;
					if(!man.isStunned && man.stunAdded){
						man.stunAdded=false;
						remove(man.stunAn,true);
					}
					for(var j:int=0;j<20;j++){
						if(this.cam.getContainerSprite().getChildByName("tri"+j+man.ID)!=null){
							this.cam.getContainerSprite().removeChild(this.cam.getContainerSprite().getChildByName("tri"+j+man.ID));
						}
					}
					remove(man, true);
					remove(syr, true);
					man.exists = false;
					
					syr.explode();//might be a problem
					syr.destory();
					syr.exists = false;
				}
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
			if(!man.isStunned && man.stunAdded){
				man.stunAdded=false;
				remove(man.stunAn,true);
			}
			if(this.canKill(man,zom)){
				if(man.isStunned || man is Patient){
					zom.disguiseOFF();

					soundhdead = (new MySoundhdead()) as Sound;
					if(soundOn){
						myChannelhdead = soundhdead.play();
					}
					infected = new Zombie(man.x,man.y,man.width,man.height, man.drag.x,man.drag.y,man.maxVelocity.x,man.maxVelocity.y);

					if(isABTesting){
						if(numberOfZombies < 2){
							numberOfZombies++;
							zombieLimited.text = numberOfZombies + "/2"; 
							infected = new Zombie(man.x,man.y,man.width,man.height, man.drag.x,man.drag.y,man.maxVelocity.x,man.maxVelocity.y);
							if(man.stunAdded){
								man.stunAdded=false;
								remove(man.stunAn,true);
							}
							//t = new FlxText(0,20,FlxG.width,"positionx" + infected.x + "positiony"+infected.y);
							//FlxG.collide(infected, collisionMap);
							if (man is Doctor) {
								infected.setImage(ImgDoctorDead);
							} else if (man is Nurse) {
								infected.setImage(ImgNurseDead);
							} else if (man is Janitor) {
								infected.setImage(ImgJanitorDead);
							} else {
								infected.setImage(ImgHumanDead);
							}
							
							var pos2:int = humans.indexOf(man);
							//humans[pos].x=1000000000;
							humans.splice(pos2,1);
							remove(player);
							add(infected);
							add(player);
							var path2:FlxPath =infected.findNearestHuman(collisionMap,humans,new FlxPoint(infected.x+infected.width/2,infected.y+infected.height/2));
							
							//t = new FlxText(0,20,FlxG.width,"PATH: "+path);
							//add(t);
							infected.attackNearestHuman(collisionMap, path2);
							zombies.push(infected);
						}
						else{
							//zom>2
							if(man.stunAdded){
								man.stunAdded=false;
								remove(man.stunAn,true);
							}
							var pos2:int = humans.indexOf(man);
							humans.splice(pos2,1);
						}

					}
					else{
						//not AB test
						infected = new Zombie(man.x,man.y,man.width,man.height, man.drag.x,man.drag.y,man.maxVelocity.x,man.maxVelocity.y);
						if(man.stunAdded){
							man.stunAdded=false;
							remove(man.stunAn,true);
						}
						//t = new FlxText(0,20,FlxG.width,"positionx" + infected.x + "positiony"+infected.y);
						//FlxG.collide(infected, collisionMap);
						if (man is Doctor) {
							infected.setImage(ImgDoctorDead);
						} else if (man is Nurse) {
							infected.setImage(ImgNurseDead);
						} else if (man is Janitor) {
							infected.setImage(ImgJanitorDead);
						} else {
							infected.setImage(ImgHumanDead);
						}
						
						var pos2:int = humans.indexOf(man);
						//humans[pos].x=1000000000;
						humans.splice(pos2,1);
						remove(player);
						add(infected);
						add(player);
						var path2:FlxPath =infected.findNearestHuman(collisionMap,humans,new FlxPoint(infected.x+infected.width/2,infected.y+infected.height/2));
						
						//t = new FlxText(0,20,FlxG.width,"PATH: "+path);
						//add(t);
						infected.attackNearestHuman(collisionMap, path2);
						zombies.push(infected);
					}
					
					if(zom==player){
						if(man is Janitor){
							logger.recordEvent(level+1,1,"pos=("+(int)(player.x/TILE_WIDTH)+","+(int)(player.y/TILE_HEIGHT)+")|action:kill janitor");
						}else if(man is Nurse){
							logger.recordEvent(level+1,2,"pos=("+(int)(player.x/TILE_WIDTH)+","+(int)(player.y/TILE_HEIGHT)+")|action:kill nurse");
						}else if(man is Doctor){
							logger.recordEvent(level+1,3,"pos=("+(int)(player.x/TILE_WIDTH)+","+(int)(player.y/TILE_HEIGHT)+")|action:kill doctor");
						}else if(man is Patient){
							logger.recordEvent(level+1,4,"pos=("+(int)(player.x/TILE_WIDTH)+","+(int)(player.y/TILE_HEIGHT)+")|action:kill patient");							
						}else{
							logger.recordEvent(level+1,5,"pos=("+(int)(player.x/TILE_WIDTH)+","+(int)(player.y/TILE_HEIGHT)+")|action:kill human");
						}
					}else{
						if(man is Janitor){
							logger.recordEvent(level+1,21,"pos=("+(int)(zom.x/TILE_WIDTH)+","+(int)(zom.y/TILE_HEIGHT)+")|action:zombie kill janitor");
						}else if(man is Nurse){
							logger.recordEvent(level+1,22,"pos=("+(int)(zom.x/TILE_WIDTH)+","+(int)(zom.y/TILE_HEIGHT)+")|action:zombie kill nurse");
						}else if(man is Doctor){
							logger.recordEvent(level+1,23,"pos=("+(int)(zom.x/TILE_WIDTH)+","+(int)(zom.y/TILE_HEIGHT)+")|action:zombie kill doctor");
						}else if(man is Patient){
							logger.recordEvent(level+1,24,"pos=("+(int)(zom.x/TILE_WIDTH)+","+(int)(zom.y/TILE_HEIGHT)+")|action:zombie kill patient");
						}else{
							logger.recordEvent(level+1,25,"pos=("+(int)(zom.x/TILE_WIDTH)+","+(int)(zom.y/TILE_HEIGHT)+")|action:zombie kill human");
						}
					}
					if(man is Janitor){
						var jan:Janitor = man as Janitor;
						jan.die();
					}
					if(man is Nurse){
						if(zom==player){
							zom.disguiseON();
//							if (soundOn) {
//								soundcostm = (new MySoundcostm()) as Sound;
//								myChannelcostm = soundcostm.play();
//							}
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
							powerUp=true;
						}
						
					}
					if(!man.isStunned && man.stunAdded){
						man.stunAdded=false;
						remove(man.stunAn,true);
					}
					for(var j:int=0;j<20;j++){
						if(this.cam.getContainerSprite().getChildByName("tri"+j+man.ID)!=null){
							this.cam.getContainerSprite().removeChild(this.cam.getContainerSprite().getChildByName("tri"+j+man.ID));
						}
					}
					remove(man,true);
					man.alive=false;
					
				}else{
					if(isABTesting){
						if(zom != player) numberOfZombies--;
						zombieLimited.text = numberOfZombies + "/2";
					}
					var pos3:int = zombies.indexOf(zom);
					zombies.splice(pos3,1);
					remove(zom,true);
					if (soundOn) {
					soundzdead = (new MySoundzdead()) as Sound;
					myChannelzdead = soundzdead.play();
					}
					man.goBack(collisionMap);
					zom.alive=false;
					zom.exists=false;
					man.stunHuman();
					man.stunAn.x=man.x;
					man.stunAn.y=man.y-man.height;
					add(man.stunAn);
					man.stunAn.play("stun");
					man.stunAdded=true;
					if(zom==player){
						logger.recordEvent(level+1,6,"pos=("+(int)(player.x/TILE_WIDTH)+","+(int)(player.y/TILE_HEIGHT)+")|action:killed by human");
					}else{
						logger.recordEvent(level+1,26,"pos=("+(int)(zom.x/TILE_WIDTH)+","+(int)(zom.y/TILE_HEIGHT)+")|action:zombie killed by human");
					}
				}
				man.alerted.x=man.x;
				man.alerted.y=man.y-man.height;
				if(man.alertAdded){
					remove(man.alerted);
					man.alertAdded=false;
				}
				if(!man.isStunned && man.stunAdded){
					man.stunAdded=false;
					remove(man.stunAn,true);
				}
			}
			else{
				zom.disguiseOFF();
				var t:FlxText;
			

				infected = new Zombie(man.x,man.y,man.width,man.height, man.drag.x,man.drag.y,man.maxVelocity.x,man.maxVelocity.y);
				if (soundOn) {
				soundhdead = (new MySoundhdead()) as Sound;
				myChannelhdead = soundhdead.play();
				}

				if(isABTesting){
					if(numberOfZombies < 2){
						numberOfZombies++;
						zombieLimited.text = numberOfZombies + "/2"; 
						infected = new Zombie(man.x,man.y,man.width,man.height, man.drag.x,man.drag.y,man.maxVelocity.x,man.maxVelocity.y);
						if(man.stunAdded){
							man.stunAdded=false;
							remove(man.stunAn,true);
						}
						if (man is Doctor) {
							infected.setImage(ImgDoctorDead);
						} else if (man is Nurse) {
							infected.setImage(ImgNurseDead);
						} else if (man is Janitor) {
							infected.setImage(ImgJanitorDead);
						} else {
							infected.setImage(ImgHumanDead);
						}
						//t = new FlxText(0,20,FlxG.width,"positionx" + infected.x + "positiony"+infected.y);
						//FlxG.collide(infected, collisionMap);
						var pos:int = humans.indexOf(man);
						//humans[pos].x=1000000000;
						humans.splice(pos,1);
						remove(player);
						add(infected);
						add(player);
						var path:FlxPath =infected.findNearestHuman(collisionMap,humans,new FlxPoint(infected.x+infected.width/2,infected.y+infected.height/2));
						
						//t = new FlxText(0,20,FlxG.width,"PATH: "+path);
						//add(t);
						infected.attackNearestHuman(collisionMap, path);
						zombies.push(infected);
					}
					else{
						if(man.stunAdded){
							man.stunAdded=false;
							remove(man.stunAn,true);
						}
						var pos2:int = humans.indexOf(man);
						humans.splice(pos2,1);
					}
					
				}
				else{
					infected = new Zombie(man.x,man.y,man.width,man.height, man.drag.x,man.drag.y,man.maxVelocity.x,man.maxVelocity.y);
					if(man.stunAdded){
						man.stunAdded=false;
						remove(man.stunAn,true);
					}
					if (man is Doctor) {
						infected.setImage(ImgDoctorDead);
					} else if (man is Nurse) {
						infected.setImage(ImgNurseDead);
					} else if (man is Janitor) {
						infected.setImage(ImgJanitorDead);
					} else {
						infected.setImage(ImgHumanDead);
					}
					//t = new FlxText(0,20,FlxG.width,"positionx" + infected.x + "positiony"+infected.y);
					//FlxG.collide(infected, collisionMap);
					var pos:int = humans.indexOf(man);
					for(var j:int=0;j<20;j++){
						if(this.cam.getContainerSprite().getChildByName("tri"+j+man.ID)!=null){
							this.cam.getContainerSprite().removeChild(this.cam.getContainerSprite().getChildByName("tri"+j+man.ID));
						}
					}
					//humans[pos].x=1000000000;
					humans.splice(pos,1);
					remove(player);
					add(infected);
					add(player);
					var path:FlxPath =infected.findNearestHuman(collisionMap,humans,new FlxPoint(infected.x+infected.width/2,infected.y+infected.height/2));
					
					//t = new FlxText(0,20,FlxG.width,"PATH: "+path);
					//add(t);
					infected.attackNearestHuman(collisionMap, path);
					zombies.push(infected);
				}
				//t = new FlxText(0,20,FlxG.width,"positionx" + infected.x + "positiony"+infected.y);
				//FlxG.collide(infected, collisionMap);
				//humans[pos].x=1000000000;
				
				
				
				if(man is Janitor){
					var jan:Janitor = man as Janitor;
					jan.die();
				}
				if(man is Nurse){
					if(zom==player){
						zom.disguiseON();
//						if (soundOn) {
//							soundcostm = (new MySoundcostm()) as Sound;
//							myChannelcostm = soundcostm.play();
//						}
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
						logger.recordEvent(level+1,1,"pos=("+(int)(player.x/TILE_WIDTH)+","+(int)(player.y/TILE_HEIGHT)+")|action:kill janitor");
					}else if(man is Nurse){
						logger.recordEvent(level+1,2,"pos=("+(int)(player.x/TILE_WIDTH)+","+(int)(player.y/TILE_HEIGHT)+")|action:kill nurse");
					}else if(man is Doctor){
						logger.recordEvent(level+1,3,"pos=("+(int)(player.x/TILE_WIDTH)+","+(int)(player.y/TILE_HEIGHT)+")|action:kill doctor");
					}else if(man is Patient){
						logger.recordEvent(level+1,4,"pos=("+(int)(player.x/TILE_WIDTH)+","+(int)(player.y/TILE_HEIGHT)+")|action:kill patient");
					}else{
						logger.recordEvent(level+1,5,"pos=("+(int)(player.x/TILE_WIDTH)+","+(int)(player.y/TILE_HEIGHT)+")|action:kill human");
					}
				}else{
					if(man is Janitor){
						logger.recordEvent(level+1,21,"pos=("+(int)(zom.x/TILE_WIDTH)+","+(int)(zom.y/TILE_HEIGHT)+")|action:zombie kill janitor");
					}else if(man is Nurse){
						logger.recordEvent(level+1,22,"pos=("+(int)(zom.x/TILE_WIDTH)+","+(int)(zom.y/TILE_HEIGHT)+")|action:zombie kill nurse");
					}else if(man is Doctor){
						logger.recordEvent(level+1,23,"pos=("+(int)(zom.x/TILE_WIDTH)+","+(int)(zom.y/TILE_HEIGHT)+")|action:zombie kill doctor");
					}else if(man is Patient){
						logger.recordEvent(level+1,24,"pos=("+(int)(zom.x/TILE_WIDTH)+","+(int)(zom.y/TILE_HEIGHT)+")|action:zombie kill patient");
					}else{
						logger.recordEvent(level+1,25,"pos=("+(int)(zom.x/TILE_WIDTH)+","+(int)(zom.y/TILE_HEIGHT)+")|action:zombie kill human");
					}
				}
				
				man.alerted.x=man.x;
				man.alerted.y=man.y-man.height;
				if(man.alertAdded){
					remove(man.alerted);
					man.alertAdded=false;
				}
				if(!man.isStunned && man.stunAdded){
					man.stunAdded=false;
					remove(man.stunAn,true);
				}
				for(var j:int=0;j<20;j++){
					if(this.cam.getContainerSprite().getChildByName("tri"+j+man.ID)!=null){
						this.cam.getContainerSprite().removeChild(this.cam.getContainerSprite().getChildByName("tri"+j+man.ID));
					}
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
			//player.offset.x = TILE_WIDTH/4;
			//player.offset.y = TILE_HEIGHT/4;
			player.width = TILE_WIDTH*2/8;
			player.height = TILE_HEIGHT*6/8;
			player.centerOffsets();
			
			
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
					logger.recordEvent(level+1,101,"pos=("+(int)(player.x/TILE_WIDTH)+","+(int)(player.y/TILE_HEIGHT)+")|level "+(level+1)+" ends");
					logger.recordLevelEnd();
					this.youLoseScreen = new FlxText(50,300,800,"YOU LOSE TRY NOT TO GET CURED  \nPress R to restart");
					this.youLoseScreen.color=0x00FF00
					this.youLoseScreen.size=35;
					this.youLoseScreen.scrollFactor = new FlxPoint(0,0);
					add(this.youLoseScreen);
					/*var camRe:FlxCamera = new FlxCamera(50, 300, this.youLoseScreen.width, this.youLoseScreen.height);
					camRe.follow(this.youLoseScreen);
					FlxG.addCamera(camRe);*/
					remove(player);
				}
			}
						
			for (var i:Number=0;i<doors.length;i++){
				keys[i].checkCollision(collisionMap, doors[i], player, Math.round((doors[i].x+doors[i].width/4)/TILE_WIDTH), Math.round((doors[i].y+doors[i].height/4)/TILE_HEIGHT),zombies,this);
				doors[i].updateDoor();
				if (soundOn && FlxG.overlap(player, doors[i])) {
				doors[i].soundDoor(player,this);
				}
				
			}
			
			
			for each(var ud:UnlockedDoor in unlockedDoors){
				//trace(Math.abs((ud.y)/TILE_HEIGHT));
				ud.checkCollision(collisionMap, player, Math.round((ud.x+ud.width/4)/TILE_WIDTH), Math.round((ud.y+ud.height/4)/TILE_HEIGHT),zombies,player,this);
				ud.updateDoor();
				
				if(FlxG.overlap(player, ud) && FlxG.keys.E && pressed){ // check if the door and the player are touching
					pressed = false;
					
					if (soundOn) {
					sounddr = (new MySounddr()) as Sound;
					myChanneldr = sounddr.play(); }
					
					
				} else if (FlxG.keys.E == false) {
					pressed = true;
					
				}
			}

//			for (var t:Number=0;t<janitors.length;t++) {
//				janitors[t].die();
//			}

			
			//MOVEMENT
			player.acceleration.x = 0;
			player.acceleration.y = 0;
			
			/*if(FlxG.keys.ENTER){
				if(isABTesting){
					isABTesting = false;
				}
				else{
					isABTesting = true;
				}
			}*/
			
			if(FlxG.keys.LEFT || FlxG.keys.A)
			{
				//player.facing = FlxObject.LEFT;
				player.acceleration.x -= player.drag.x;
				
			}
			else if(FlxG.keys.RIGHT || FlxG.keys.D)
			{
				//player.facing = FlxObject.RIGHT;
				player.acceleration.x += player.drag.x;
				
			}
			if(FlxG.keys.UP || FlxG.keys.W)
			{
				//player.facing = FlxObject.UP;
				player.acceleration.y -= player.drag.y;
				
			}
			else if(FlxG.keys.DOWN || FlxG.keys.S)
			{
				//player.facing = FlxObject.DOWN;
				player.acceleration.y += player.drag.y;
			
			}
			if(FlxG.keys.SPACE){
				if(throwable){
					logger.recordEvent(level+1,15,"pos=("+(int)(player.x/TILE_WIDTH)+","+(int)(player.y/TILE_HEIGHT)+")|action:use syringe");
					/*if(player.angle == 0 || player.angle == 180){
						pSyringe = new Syringe(player.angle, player.x+2, player.y);
					}
					else if(player.angle == 90 || player.angle == -90){
						pSyringe = new Syringe(player.angle, player.x, player.y+7);
					}*/
					if (soundOn) {
						soundsyrg = (new MySoundsyrg()) as Sound;
						myChannelsyrg = soundsyrg.play();
					}
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
					pSyringe = new Syringe(angleToThrow, player.x+player.width/2, player.y+player.height/2, 0,0, 0);
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
//				if ((level==9) && win) {
//					win=false;
//					FlxG.fade(0xff000000, 0.22, function():void { 
//						level = 0;
//						FlxG.switchState(new PlayState());
//					} );
//				} 
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
			 
			if (Math.abs(player.x- (exitX))<=TILE_WIDTH*.8 && Math.abs(player.y - (exitY))<=TILE_HEIGHT/2 && this.exitDoor.doorOpen) {
				win == true;
				
				
				if(this.youWinScreen ==null){
					logger.recordEvent(level+1,102,"pos=("+(int)(player.x/TILE_WIDTH)+","+(int)(player.y/TILE_HEIGHT)+")|level "+(level+1)+" complete");
					logger.recordLevelEnd();

					if (level==15) {
						this.youWinScreen = new FlxText(50,300,800,"YOU HAVE ZOMBIFIED THE ENTIRE HOSPITAL! \nUse the Quit Button to return to menu.");

					} else {
					this.youWinScreen = new FlxText(50,300,800,"YAY YOU ZOMBIFIED THIS FLOOR!! \nPress R to continue to next floor"); 
					level++; 
					level = level%16;
					}
					this.youWinScreen.color=0x00FF00
					this.youWinScreen.scrollFactor = new FlxPoint(0,0);
					this.youWinScreen.size=20;
					//this.youWinScreen = new FlxText(-200000,0,820,"YAY YOU ZOMBIFIED THIS FLOOR!! Press R to continue to next floor");
					this.youWinScreen.size=35;
					add(this.youWinScreen);
					/*var camRev:FlxCamera = new FlxCamera(50, 300, this.youWinScreen.width, this.youWinScreen.height);
					camRev.follow(this.youWinScreen);
					FlxG.addCamera(camRev);*/
					remove(player);
					//level++;
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
					var holdLooker:Number = looker.getAngle();
					if(holdLooker>180){
						holdLooker=360-holdLooker;
					}
					if(holdLooker<-180){
						holdLooker=360+holdLooker;
					}
					if(angle>=holdLooker-this.coneWidth && angle<=holdLooker+this.coneWidth){
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
