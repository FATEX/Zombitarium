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
	import objects.Floors;
	import objects.Human;
	import objects.Janitor;
	import objects.Nurse;
	import objects.Patient;
	import objects.Syringe;
	import objects.Wall;
	
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
		[Embed(source = 'wall_complete_file2.png')]private static var auto_tiles:Class;
		[Embed(source = 'wall_tile_universal_gray_130x65.png')]private static var universal_Wall:Class;
		[Embed(source = 'wall_USE3.png')]private static var coverTiles:Class;
		[Embed(source = 'wall_USE4.png')]private static var coverTiles2:Class;
		[Embed(source = 'wall_USE5.png')]private static var coverTiles3:Class;

		// Music
		[Embed(source = "zbg1.mp3")]private var MySound : Class; 		 
		private var sound : Sound; // not MySound! 
		public var myChannel:SoundChannel = new SoundChannel();
				
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
		[Embed(source = 'lvl0_alt.txt', mimeType = 'application/octet-stream')]private static var level0:Class;
		[Embed(source = 'level1.txt', mimeType = 'application/octet-stream')]private static var default_level1:Class;
		[Embed(source = 'lvl1_alt.txt', mimeType = 'application/octet-stream')]private static var level1:Class;
		[Embed(source = 'level2.txt', mimeType = 'application/octet-stream')]private static var default_level2:Class;
		[Embed(source = 'lvl2_alt.txt', mimeType = 'application/octet-stream')]private static var level2:Class;
		[Embed(source = 'level2T.txt', mimeType = 'application/octet-stream')]private static var default_level2T:Class;
		[Embed(source = 'level3.txt', mimeType = 'application/octet-stream')]private static var default_level3:Class;
		[Embed(source = 'lvl3_alt.txt', mimeType = 'application/octet-stream')]private static var level3:Class;
		[Embed(source = 'level3T.txt', mimeType = 'application/octet-stream')]private static var default_level3T:Class;
		[Embed(source = 'level4.txt', mimeType = 'application/octet-stream')]private static var default_level4:Class;
		[Embed(source = 'lvl4_alt.txt', mimeType = 'application/octet-stream')]private static var level4:Class;
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

		[Embed(source="blank2.png")] private static var BlackTile:Class;
		[Embed(source="floor_tile_type3_gray2.png")] private static var FloorTile:Class;

		[Embed(source="janitor_all_zombies.png")] private static var ImgJanitorDead:Class;
		[Embed(source="nurse_all_zombies_use_final.png")] private static var ImgNurseDead:Class;


		//logger
		public static var isPageLoaded:Boolean = false;
		private var playertime:Number = new Date().time;
		private static var versionID:Number = 4;
		public static var logger:Logging = new Logging(200,versionID,false);		
		
		// Some static constants for the size of the tilemap tiles
		public const TILE_WIDTH:uint = 65;
		public const TILE_HEIGHT:uint = 65;
		
		// The FlxTilemap we're using
		private var collisionMap:FlxTilemap;
		
		private var facingDirection:int =0;
		
		// Box to show the user where they're placing stuff
		private var highlightBox:FlxObject;
		
		// Player modified from "Mode" demo
		private var beatLevel:Boolean=false;
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
	
		private var zombieNum:FlxText;
		private var muteButton:FlxButton;
		private var syringeUI:FlxSprite;
		private var zombieHead:FlxSprite;
		private var levelText:FlxText;
		private var nurseHead:FlxSprite;
		private var disguiseTimerText:FlxText;
		
		private var keys:Vector.<Key>;
		private var doors:Vector.<Door>;
		private var unlockedDoors:Vector.<UnlockedDoor>;
		
		public static var level:int = 0;
		
		private var infected:Zombie;
		private var area:FlxSprite;
		private var exitDoor:DoorObject;
		//Cameras
		private var cam:FlxCamera;
		//private var camQuit:FlxCamera;
		//private var camNextLevel:FlxCamera;
		//private var camLevel:FlxCamera;
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
		public var win:Boolean = false;
		private var cd:int = 50;
		private var youLoseScreen:FlxText;
		private var zombieLimited:FlxText;
		private var t;
		private var powerUpMenu:FlxText;
		private var nkeys;
		private var nkeysC = 0;
		private var powerUp:Boolean = false;
		//private var stop_btn;
		public static var soundOn:Boolean = true;
		public static var isABTesting:Boolean = true;
		private var numberOfZombies = 0;
		private var pressed = true;
		
		// menu bar 
		[Embed(source = "menuBar1.png")] private var ImgHeader:Class;
		private var header: FlxSprite;
		[Embed(source = "imgZ.png")] private var ImgZ:Class;
		private var imgZ: FlxSprite;
		[Embed(source = "imgSy.png")] private var ImgSy:Class;
		private var imgSy: FlxSprite;
		[Embed(source = "hat_only.png")] private var ImgN:Class;
		private var imgN: FlxSprite;
		[Embed(source = "bExit.png")] private var BtnExit:Class;
		[Embed(source = "bMute.png")] private var BtnMute:Class;
		[Embed(source = "bUnmute.png")] private var BtnUnmute:Class;
		
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
				collisionMap.loadMap(new default_level0(), auto_tiles, TILE_WIDTH, TILE_HEIGHT,FlxTilemap.AUTO);
				add(collisionMap);	
				//constructMap(new level0());
			}
			else if(level==1){
				collisionMap.loadMap(new default_level1(), auto_tiles, TILE_WIDTH, TILE_HEIGHT, FlxTilemap.AUTO);
				add(collisionMap);	
				//constructMap(new level1());
			}
			else if(level==2){
				collisionMap.loadMap(new default_level2(), auto_tiles, TILE_WIDTH, TILE_HEIGHT, FlxTilemap.AUTO);
				add(collisionMap);	
				//constructMap(new level2());
			}
			else if(level==3){
				collisionMap.loadMap(new default_level2T(), auto_tiles, TILE_WIDTH, TILE_HEIGHT, FlxTilemap.AUTO);
			}
			else if(level==4){
				collisionMap.loadMap(new default_level3(), auto_tiles, TILE_WIDTH, TILE_HEIGHT, FlxTilemap.AUTO);
				add(collisionMap);	
				//constructMap(new level3());
			}
			else if(level==5){
				collisionMap.loadMap(new default_level3T(), auto_tiles, TILE_WIDTH, TILE_HEIGHT, FlxTilemap.AUTO);
			}
			else if(level==6){
				collisionMap.loadMap(new default_level4(), auto_tiles, TILE_WIDTH, TILE_HEIGHT, FlxTilemap.AUTO);
				add(collisionMap);	
				//constructMap(new level4());
			}
			else if(level==7){
				collisionMap.loadMap(new default_level4T(), auto_tiles, TILE_WIDTH, TILE_HEIGHT, FlxTilemap.AUTO);
			}
			else if(level==8){
				collisionMap.loadMap(new default_level5(), auto_tiles, TILE_WIDTH, TILE_HEIGHT, FlxTilemap.AUTO);
			}
			else if(level==9){
				collisionMap.loadMap(new default_level5T(), auto_tiles, TILE_WIDTH, TILE_HEIGHT, FlxTilemap.AUTO);
			}
			else if(level==10){
				collisionMap.loadMap(new default_level6(), auto_tiles, TILE_WIDTH, TILE_HEIGHT, FlxTilemap.AUTO);
			}
			else if(level==11){
				collisionMap.loadMap(new default_level6T(), auto_tiles, TILE_WIDTH, TILE_HEIGHT, FlxTilemap.AUTO);
			}
			else if(level==12){
				collisionMap.loadMap(new default_auto(), auto_tiles, TILE_WIDTH, TILE_HEIGHT, FlxTilemap.AUTO);
			}
			else if(level==13){
				collisionMap.loadMap(new default_middle(), auto_tiles, TILE_WIDTH, TILE_HEIGHT, FlxTilemap.AUTO);
			}
			else if(level==14){
				collisionMap.loadMap(new default_hard(), auto_tiles, TILE_WIDTH, TILE_HEIGHT, FlxTilemap.AUTO);
			}
			else if(level==15){
				collisionMap.loadMap(new default_levelAlice(), auto_tiles, TILE_WIDTH, TILE_HEIGHT, FlxTilemap.AUTO);
			}
			
			add(collisionMap);
			trace("aaa");
			for(var i:int =0;i<collisionMap.widthInTiles;i++){
				for(var j:int=0;j<collisionMap.heightInTiles;j++){
					if(collisionMap.getTile(i,j)==0){
						if(collisionMap.getTile(i-1,j) != 0 && collisionMap.getTile(i,j-1) != 0){
							add(new Floors(i*65, j*65, "dc"));
							
						}
						else if(collisionMap.getTile(i,j-1) != 0){
							var myNum:Number = Math.floor(Math.random()*5) + 1;
							if(myNum == 1){
								add(new Floors(i*65, j*65, "up1"));
							}
							else if(myNum == 2){
								add(new Floors(i*65, j*65, "up2"));
							}
							else if(myNum == 3){
								add(new Floors(i*65, j*65, "up3"));
							}
							else if(myNum == 4){
								add(new Floors(i*65, j*65, "up4"));
							}
							else if(myNum == 5){
								add(new Floors(i*65, j*65, "up5"));
							}
							add(new Floors(i*65, j*65, "dup"));
						}
						else if(collisionMap.getTile(i-1,j) != 0){
							var myNum:Number = Math.floor(Math.random()*5) + 1;
							if(myNum == 1){
								add(new Floors(i*65, j*65, "left1"));
							}
							else if(myNum == 2){
								add(new Floors(i*65, j*65, "left2"));
							}
							else if(myNum == 3){
								add(new Floors(i*65, j*65, "left3"));
							}
							else if(myNum == 4){
								add(new Floors(i*65, j*65, "left4"));
							}
							else if(myNum == 5){
								add(new Floors(i*65, j*65, "left5"));
							}
							add(new Floors(i*65, j*65, "dleft"));
						}
						else if(i>0 && j >0 && collisionMap.getTile(i-1,j-1) != 0){
							add(new Floors(i*65, j*65, "outCorner"));
						}
						else{
							var myNum:Number = Math.floor(Math.random()*5) + 1;
							if(myNum == 1){
								add(new Floors(i*65, j*65, "A"));
							}
							else if(myNum == 2){
								add(new Floors(i*65, j*65, "B"));
							}
							else if(myNum == 3){
								add(new Floors(i*65, j*65, "C"));
							}
							else if(myNum == 4){
								add(new Floors(i*65, j*65, "D"));
							}
							else if(myNum == 5){
								add(new Floors(i*65, j*65, "E"));
							}
						}
					}
					else{
						/*if(j-1>=0 && j+1<collisionMap.heightInTiles && i+1<collisionMap.widthInTiles && collisionMap.getTile(i,j+1)==0 && collisionMap.getTile(i,j)==1 && collisionMap.getTile(i+1,j)==0){
							add(new Wall(i*65, j*65, "D"));
						}
						else if(j-1>=0 && j+1<collisionMap.heightInTiles && i+1<collisionMap.widthInTiles && collisionMap.getTile(i,j-1)==0 && collisionMap.getTile(i,j)==1 && collisionMap.getTile(i+1,j)==0){
							add(new Wall(i*65, j*65, "C"));
						}
						else if(i-1>=0 && j+1<collisionMap.heightInTiles && collisionMap.getTile(i-1,j)==0 && collisionMap.getTile(i,j)==1 && collisionMap.getTile(i,j+1)==0){
							add(new Wall(i*65, j*65, "B"));
						}
						else if(i-1>=0 && j+1<collisionMap.heightInTiles && i+1<collisionMap.widthInTiles && collisionMap.getTile(i-1,j)==0 && collisionMap.getTile(i,j)==1 && collisionMap.getTile(i,j-1)==0){
							add(new Wall(i*65, j*65, "A"));
						}
						else if(i-1>=0 && j+1<collisionMap.heightInTiles && i+1<collisionMap.widthInTiles && collisionMap.getTile(i-1,j)==1 && collisionMap.getTile(i,j)==1 && collisionMap.getTile(i+1,j)==1 && collisionMap.getTile(i,j+1)==0){
							add(new Wall(i*65, j*65, "H"));
						}*/
					}
				}
			}
			/*
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
			}*/
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

			t = new FlxButton(-10000, 30, "LEVEL " + (level+1));
			add(t);

			
			addCam();
			
			blankTiles = new Array();
			if(level==0){
				add((instructions = new FlxText(10*TILE_WIDTH,1*TILE_HEIGHT,5*TILE_WIDTH,"You can open locked doors with a key")).setFormat(null,30/100*TILE_WIDTH));
			}
			for(var q:int=0;q<collisionMap.widthInTiles;q++){
				blankTiles[q]=new Array();
			}
			for(var i:int =0;i<collisionMap.widthInTiles;i++){
				for(var j:int=0;j<collisionMap.heightInTiles;j++){
					if(collisionMap.getTile(i,j)==0 && this.darkRooms){
						var blankScreenTile:FlxSprite = new FlxSprite(i*TILE_WIDTH-25,j*TILE_HEIGHT-20);
						blankScreenTile.loadGraphic(BlackTile,false,false,TILE_WIDTH+45,TILE_HEIGHT+40);
						add(blankScreenTile);
						blankTiles[i][j]=blankScreenTile;
					}
					else{
						var blankScreenTile:FlxSprite = new FlxSprite(i*TILE_WIDTH-25,j*TILE_HEIGHT-20);
						blankScreenTile.loadGraphic(BlackTile,false,false,TILE_WIDTH+45,TILE_HEIGHT+40);
						//blankScreenTile.visible=false;
						add(blankScreenTile);
						blankTiles[i][j]=blankScreenTile;
					}
					
				}
			}
			revealBoard();			

			instructions = new FlxText(3*TILE_WIDTH,1*TILE_HEIGHT,10*TILE_WIDTH,"Arrow keys or WASD to move \nPress E to open doors");

			if (level==0) {
				add(instructions);
			} else if (level==1) {
				add(instructions = new FlxText(6*TILE_WIDTH,4*TILE_HEIGHT,6*TILE_WIDTH,"You can zombify humans by running into them from behind."))
			} else if (level==2) {
				add(instructions = new FlxText(7*TILE_WIDTH,4*TILE_HEIGHT,6*TILE_WIDTH,"BEWARE If a human sees you, it will go after you!"))
			} else if (level==4) {
				add(instructions = new FlxText(1*TILE_WIDTH,3*TILE_HEIGHT,3*TILE_WIDTH,"Humans can kill zombies...but not without getting stunned!"))
			} else if (level==6) {
				add(instructions = new FlxText(11*TILE_WIDTH,3*TILE_HEIGHT,6*TILE_WIDTH,"BEWARE Janitors see everything...And they also have keys"))
			} else if (level==8) {
				add(instructions = new FlxText(0*TILE_WIDTH,3*TILE_HEIGHT,3*TILE_WIDTH,"If you zombify a nurse you get disguised for 3 seconds!"))
			} else if (level==10) {
				add(instructions = new FlxText(1*TILE_WIDTH,3*TILE_HEIGHT,3*TILE_WIDTH,"If you zombify a doctor you get a syringe! Press SPACE to throw"))
			}
			instructions.setFormat(null,30/100*TILE_WIDTH);
			
			header = new FlxSprite(0, 0, ImgHeader);
			header.scrollFactor.x=header.scrollFactor.y=0;
			add(header);
			
			quitBtn = new FlxButton(0, 0, "",
				function():void { FlxG.fade(0xff000000, 0.22, function():void { 
					level = 0;
					SoundMixer.stopAll();
					if (soundOn) {
						soundbtn = (new MySoundbtn()) as Sound;
						myChannelbtn = soundbtn.play();
					}
					FlxG.resetGame();
				} ); } );
			quitBtn.color = 0xfafafa;
			quitBtn.loadGraphic(BtnExit);
			quitBtn.scrollFactor.x=quitBtn.scrollFactor.y=0;
			add(quitBtn);
			
			levelText = new FlxText(130, 5, 100, ""+(level+1));
			levelText.scrollFactor.x=levelText.scrollFactor.y=0;
			levelText.color=0x00382E;
			levelText.size=20;
			add(levelText);
			
			disguiseTimerText = new FlxText(450,5,200);
			disguiseTimerText.scrollFactor.x=disguiseTimerText.scrollFactor.y=0;
			disguiseTimerText.color=0x7E0000;
			disguiseTimerText.size=20;
			add(disguiseTimerText);
			
			zombieHead = new FlxSprite(280,0, ImgZ);
			zombieHead.scrollFactor.x=zombieHead.scrollFactor.y=0;
			add(zombieHead);
			nurseHead = new FlxSprite(400,0, ImgN);
			nurseHead.scrollFactor.x=nurseHead.scrollFactor.y=0;
			add(nurseHead);
			
			
			zombieNum = new FlxText(250, 5, 100, "Zombies:"+(zombies.length-1));
			zombieNum.scrollFactor.x=zombieNum.scrollFactor.y=0;
			zombieNum.color=0x7E0000;
			zombieNum.size=20;
			add(zombieNum);


			muteButton = new FlxButton(FlxG.width-70, 0,"",function():void{
				soundbtn = (new MySoundbtn()) as Sound;
				myChannelbtn = soundbtn.play();
				if (soundOn) {
					soundOn = false;
					myChannel.stop();
					muteButton.loadGraphic(BtnUnmute);
				} else {
					myChannel = sound.play(0,10);
					soundOn = true;
					muteButton.loadGraphic(BtnMute);
				}
			});
			muteButton.color = 0xfafafa;

			if(soundOn){
				//FlxG.mute = false;
				muteButton.loadGraphic(BtnMute);
			}else{
				//FlxG.mute = true;
				//muteButton.label.text = "UnMute";
				muteButton.loadGraphic(BtnUnmute);
			}
			muteButton.scrollFactor.x=muteButton.scrollFactor.y=0;
			add(muteButton);
			
			
			
			syringeUI = new FlxSprite(330, 0,ImgSy);
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
						(FlxSprite(blankTiles[i][j])).visible=true;
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
			if(cam !=null){
				FlxG.removeCamera(cam,false);
			}
			else{
				cam = new FlxCamera(0,0, FlxG.width, FlxG.height,1); 
			}
			cam.follow(player);
			cam.setBounds(0,0,collisionMap.width, collisionMap.height);
			FlxG.addCamera(cam);

			this.powerUpMenu = new FlxText(-6000,0,100,"Powerup: " + powerUp.toString() + "\nKeys: " + nkeysC + "/" + nkeys);
			this.powerUpMenu.size=12;
			
			
//			if(isABTesting){
//				this.zombieLimited = new FlxText(-100000,-100000,820,"0/2");
//				this.zombieLimited.size=39;
//				add(this.zombieLimited);
//				var camRe:FlxCamera = new FlxCamera(810, 0, this.zombieLimited.width, this.zombieLimited.height);
//				camRe.follow(this.zombieLimited);
//				FlxG.addCamera(camRe);
//			}
			
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
				x=x+1;
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
					if(x-1>=0 && x+1<collisionMap.widthInTiles &&(collisionMap.getTile(x-1,y)==0 || collisionMap.getTile(x+1,y)==0)){
						door.angle=90;
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
					if(x-1>=0 && x+1<collisionMap.widthInTiles &&(collisionMap.getTile(x-1,y)==0 || collisionMap.getTile(x+1,y)==0)){
						unlockedDoor.angle=90;
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
			FlxG.collide(player, collisionMap);
			FlxG.collide(collisionMap, pSyringe,touchedH);
			this.drawingCamera.fill(0x00000000);
			for each(var hum:Human in humans){
				try{
				if(!FlxSprite(this.blankTiles[int((hum.x+hum.width/2)/TILE_WIDTH)][int((hum.y+hum.height/2)/TILE_HEIGHT)]).visible && this.collisionMap.getTile((hum.x+hum.width/2)/TILE_WIDTH,(hum.y+hum.height/2)/TILE_HEIGHT)!=1){
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
				else{
					zombies[w].playerUpdate();
				}
			}

			zombieNum.text = ""+(zombies.length-1);
			if(zombies.length-1==0){
				zombieHead.color=0x000000;
			}else{
				zombieHead.color=0xFFFFFF;
			}
			
			if(throwable){
				syringeUI.visible=true;
				syringeUI.color=0xFFFFFF;
			}
			else{
				syringeUI.visible=true;
				syringeUI.color=0x000000;
			}
			if(player.isDisguised){
				nurseHead.visible=true;
				nurseHead.color=0xFFFFFF;
				disguiseTimerText.visible=true;
				disguiseTimerText.text = "0:0"+(int)(4-player.disguiseTimer/50);
			}else{
				nurseHead.visible=true;
				nurseHead.color=0x000000;
				disguiseTimerText.visible=true;
				disguiseTimerText.text = "0:00";
			}
			
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
										myChannelsyrg = soundsyrg.play(); 
									}
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
					zom = Zombie(obj1);
					syr = Syringe(obj2);
					var pos:int = zombies.indexOf(zom);
					if(zom!=player){
					zombies.splice(pos,1);
						remove(zom,true);
						zom.exists = false;

					}
					remove(syr, true);
					zom.alive = false;
					syr.exists = false;
					syr.destory();
				}

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
			trace("can kill: " + this.canKill(man,zom).toString());
			trace("Man: "+man.ID);
			if(this.canKill(man,zom)){
				if(man.isStunned || man is Patient){
					zom.disguiseOFF();

					soundhdead = (new MySoundhdead()) as Sound;
					if(soundOn){
						myChannelhdead = soundhdead.play();
					}
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
								player.play("idleRight",true);
							}
							else if(this.facingDirection==3){
								player.play("idleTRight",true);
							}
							else if(this.facingDirection==4){
								player.play("idleBLeft",true);
								player.facing=FlxObject.RIGHT;
							}
							else if(this.facingDirection==5){
								player.play("idleRight",true);
								player.facing=FlxObject.LEFT;
							}
							else if(this.facingDirection==6){
								player.play("idleBLeft",true);
							}
							else{
								player.play("idleTRight",true);
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
					var pos3:int = zombies.indexOf(zom);
					if(zom!=player){
						zombies.splice(pos3,1);
						remove(zom,true);
						zom.exists=false;
					}
					if (soundOn) {
					soundzdead = (new MySoundzdead()) as Sound;
					myChannelzdead = soundzdead.play();
					}
					man.goBack(collisionMap);
					zom.alive=false;
					man.stunHuman();
					man.stunAn.x=man.x;
					man.stunAn.y=man.y-man.height;
					add(man.stunAn);
					man.stunAn.play("stun");
					man.stunAdded=true;
					if(zom==player){
						if(man is Janitor){
							logger.recordEvent(level+1,6,"pos=("+(int)(player.x/TILE_WIDTH)+","+(int)(player.y/TILE_HEIGHT)+")|action:killed by janitor");
						}else if(man is Nurse){
							logger.recordEvent(level+1,7,"pos=("+(int)(player.x/TILE_WIDTH)+","+(int)(player.y/TILE_HEIGHT)+")|action:killed by nurse");
						}else if(man is Doctor){
							logger.recordEvent(level+1,8,"pos=("+(int)(player.x/TILE_WIDTH)+","+(int)(player.y/TILE_HEIGHT)+")|action:killed by doctor");
						}else if(man is Patient){
							logger.recordEvent(level+1,9,"pos=("+(int)(player.x/TILE_WIDTH)+","+(int)(player.y/TILE_HEIGHT)+")|action:killed by patient");
						}else{
							logger.recordEvent(level+1,10,"pos=("+(int)(player.x/TILE_WIDTH)+","+(int)(player.y/TILE_HEIGHT)+")|action:killed by human");
						}
					}else{
						if(man is Janitor){
							logger.recordEvent(level+1,26,"pos=("+(int)(zom.x/TILE_WIDTH)+","+(int)(zom.y/TILE_HEIGHT)+")|action:zombie killed by janitor");
						}else if(man is Nurse){
							logger.recordEvent(level+1,27,"pos=("+(int)(zom.x/TILE_WIDTH)+","+(int)(zom.y/TILE_HEIGHT)+")|action:zombie killed by nurse");
						}else if(man is Doctor){
							logger.recordEvent(level+1,28,"pos=("+(int)(zom.x/TILE_WIDTH)+","+(int)(zom.y/TILE_HEIGHT)+")|action:zombie killed by doctor");
						}else if(man is Patient){
							logger.recordEvent(level+1,29,"pos=("+(int)(zom.x/TILE_WIDTH)+","+(int)(zom.y/TILE_HEIGHT)+")|action:zombie killed by patient");
						}else{
							logger.recordEvent(level+1,30,"pos=("+(int)(zom.x/TILE_WIDTH)+","+(int)(zom.y/TILE_HEIGHT)+")|action:zombie killed by human");
						}
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
				var pos:int = humans.indexOf(man);
				if(pos!=-1){
				zom.disguiseOFF();
				var t:FlxText;
			

				infected = new Zombie(man.x,man.y,man.width,man.height, man.drag.x,man.drag.y,man.maxVelocity.x,man.maxVelocity.y);
				if (soundOn) {
				soundhdead = (new MySoundhdead()) as Sound;
				myChannelhdead = soundhdead.play();
				}
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
							player.play("idleRight",true);
						}
						else if(this.facingDirection==3){
							player.play("idleTRight",true);
						}
						else if(this.facingDirection==4){
							player.play("idleBLeft",true);
							player.facing=FlxObject.RIGHT;
						}
						else if(this.facingDirection==5){
							player.play("idleRight",true);
							player.facing=FlxObject.LEFT;
						}
						else if(this.facingDirection==6){
							player.play("idleBLeft",true);
						}
						else{
							player.play("idleTRight",true);
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
			player.addAnimation("topRight",[16,17,18,19],12);
			player.addAnimation("right",[8,9,10,11],12);
			player.addAnimation("bottomLeft",[12,13,14,15],12);
			zombies.push(player);


		}
		

		private function updatePlayer():void
		{
			if (player.alive == false) {
				logger.recordEvent(level+1,101,"pos=("+(int)(player.x/TILE_WIDTH)+","+(int)(player.y/TILE_HEIGHT)+")|level "+(level+1)+" ends");
				logger.recordLevelEnd();
				player.play("right",true);
				player.angle=player.angle+10;
				FlxG.fade(0xff000000, 0.3, on_fade_completed2);

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
					myChanneldr = sounddr.play(); 
					}
					
					
				} else if (FlxG.keys.E == false) {
					pressed = true;
					
				}
			}

			
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
			if(player.alive){
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
							angleToThrow=135;
						}
						else if(this.facingDirection==5){
							angleToThrow=-90;
						}
						else if(this.facingDirection==6){
							angleToThrow=-135;
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
			if(FlxG.keys.justPressed("R")){
				if(beatLevel && level==15){
					
				}
				else if(beatLevel){
					level++;
					level=level%16;
					resetGame();

				}
				else{
					resetGame();
				}
				
			}
			
			if((FlxG.keys.RIGHT || FlxG.keys.D) && player.velocity.y==0){
				player.play("right");
				player.facing=FlxObject.RIGHT;
				this.facingDirection=2;
			}
			else if((FlxG.keys.RIGHT || FlxG.keys.D) && (FlxG.keys.DOWN || FlxG.keys.S)){
				player.play("bottomLeft");
				player.facing=FlxObject.LEFT;
				this.facingDirection=4;
			}
			else if((FlxG.keys.RIGHT || FlxG.keys.D) && (FlxG.keys.UP || FlxG.keys.W)){
				player.play("topRight");
				player.facing=FlxObject.RIGHT;
				this.facingDirection=3;
			}
			else if(player.velocity.x==0 && (FlxG.keys.DOWN || FlxG.keys.S)){
				player.play("run");
				player.facing=FlxObject.RIGHT;
				this.facingDirection=0;
			}
			else if((FlxG.keys.LEFT || FlxG.keys.A) && (FlxG.keys.DOWN || FlxG.keys.S)){
				player.play("bottomLeft");
				player.facing=FlxObject.RIGHT;
				this.facingDirection=6;
			}
			else if((FlxG.keys.LEFT || FlxG.keys.A) && player.velocity.y==0){
				player.play("right");
				player.facing=FlxObject.LEFT;
				this.facingDirection=5;
			}
			else if((FlxG.keys.LEFT || FlxG.keys.A) && (FlxG.keys.UP || FlxG.keys.W)){
				player.play("topRight");
				player.facing=FlxObject.RIGHT;
				this.facingDirection=7;
			}
			else if(player.velocity.x==0 && (FlxG.keys.UP || FlxG.keys.W)){
				
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
					player.play("idleRight");
				}
				else if(this.facingDirection==3){
					player.play("idleTRight");
				}
				else if(this.facingDirection==4){
					player.play("idleBLeft");
					player.facing=FlxObject.LEFT;
				}
				else if(this.facingDirection==5){
					player.play("idleRight");
					player.facing=FlxObject.LEFT;
				}
				else if(this.facingDirection==6){
					player.play("idleBLeft");
					player.facing=FlxObject.RIGHT;

				}
				else{
					player.play("idleTRight");
					player.facing=FlxObject.RIGHT;
				}
			}
			 
			if (Math.abs(player.x- (exitX))<=TILE_WIDTH*.8 && Math.abs(player.y - (exitY))<=TILE_HEIGHT/2 && this.exitDoor.doorOpen) {
				//win == true;
				//myChannel.stop();
				logger.recordEvent(level+1,102,"pos=("+(int)(player.x/TILE_WIDTH)+","+(int)(player.y/TILE_HEIGHT)+")|level "+(level+1)+" complete");
				logger.recordLevelEnd();
				this.beatLevel=true;
				FlxG.fade(0xff000000, 0.3, on_fade_completed);
				
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
					//trace("angle is : "+ angle);
					//trace("Langle is : "+ lAngle);
					if(angle < 0){
						angle = angle+360;
					}
					//cover the corner case
					if(lAngle == 0){
						if(Math.abs(lAngle - angle) <=90 || Math.abs(lAngle+360 - angle) <=90){
							return true;
						}
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
		
		public function on_fade_completed():void
		{
			// playing the game itself
			if(level==15){
				FlxG.switchState(new FinalWinState());
			}
			else{
				FlxG.switchState(new WinState());
			}
		}
		public function on_fade_completed2():void
		{
			// playing the game itself
			//myChannel.stop();
			FlxG.switchState(new LoseState());
		}
		
		private function constructMap(map:String):void{
			/*
			var row:Array = map.split("\n");
			for(var i:int = 0; i < row.length; i++){
				var cols:String = String(row[i]);
				var col:Array = cols.split(",");
				for(var j:int = 0; j < col.length; j++){
					if(col[j] == "5"){
						trace(i);
						trace(j);
						add(new Wall(j*65, i*65, "5"));
					}
					else if(col[j] == "A"){
						add(new Wall(j*65, i*65, "A"));
					}
					else if(col[j] == "B"){
						add(new Wall(j*65, i*65, "B"));
					}
					else if(col[j] == "C"){
						add(new Wall(j*65, i*65, "C"));
					}
					else if(col[j] == "D"){
						add(new Wall(j*65, i*65, "D"));
					}
					else if(col[j] == "E"){
						add(new Wall(j*65, i*65, "E"));
					}
					else if(col[j] == "F"){
						add(new Wall(j*65, i*65, "F"));
					}
					else if(col[j] == "G"){
						add(new Wall(j*65, i*65, "G"));
					}
					else if(col[j] == "H"){
						add(new Wall(j*65, i*65, "H"));
					}
					else if(col[j] == "1"){
						add(new Wall(j*65, i*65, "1"));
					}
					else if(col[j] == "2"){
						add(new Wall(j*65, i*65, "2"));
					}
					else if(col[j] == "3"){
						add(new Wall(j*65, i*65, "3"));
					}
					else if(col[j] == "4"){
						add(new Wall(j*65, i*65, "4"));
					}
					else if(col[j] == "6"){
						add(new Wall(j*65, i*65, "6"));
					}
					else if(col[j] == "7"){
						add(new Wall(j*65, i*65, "7"));
					}
					else if(col[j] == "8"){
						add(new Wall(j*65, i*65, "8"));
					}
					/*else if(col[j] == "A"){
						add(new Floors(j*65, i*65, "A"));
					}
					else if(col[j] == "B"){
						add(new Floors(j*65, i*65, "B"));
					}
					else if(col[j] == "C"){
						add(new Floors(j*65, i*65, "C"));
					}
					else if(col[j] == "D"){
						add(new Floors(j*65, i*65, "D"));
					}
					else if(col[j] == "E"){
						add(new Floors(j*65, i*65, "E"));
					}
					else if(col[j] == "up1"){
						add(new Floors(j*65, i*65, "up1"));
					}
					else if(col[j] == "up2"){
						add(new Floors(j*65, i*65, "up2"));
					}
					else if(col[j] == "up3"){
						add(new Floors(j*65, i*65, "up3"));
					}
					else if(col[j] == "up4"){
						add(new Floors(j*65, i*65, "up4"));
					}
					else if(col[j] == "up5"){
						add(new Floors(j*65, i*65, "up5"));
					}
					else if(col[j] == "left1"){
						add(new Floors(j*65, i*65, "left1"));
					}
					else if(col[j] == "left2"){
						add(new Floors(j*65, i*65, "left2"));
					}
					else if(col[j] == "left3"){
						add(new Floors(j*65, i*65, "left3"));
					}
					else if(col[j] == "left4"){
						add(new Floors(j*65, i*65, "left4"));
					}
					else if(col[j] == "left5"){
						add(new Floors(j*65, i*65, "left5"));
					}
					else if(col[j] == "right1"){
						add(new Floors(j*65, i*65, "right1"));
					}
					else if(col[j] == "right2"){
						add(new Floors(j*65, i*65, "right2"));
					}
					else if(col[j] == "right3"){
						add(new Floors(j*65, i*65, "right3"));
					}
					else if(col[j] == "right4"){
						add(new Floors(j*65, i*65, "right4"));
					}
					else if(col[j] == "right5"){
						add(new Floors(j*65, i*65, "right5"));
					}
					else if(col[j] == "down1"){
						add(new Floors(j*65, i*65, "down1"));
					}
					else if(col[j] == "down2"){
						add(new Floors(j*65, i*65, "down2"));
					}
					else if(col[j] == "down3"){
						add(new Floors(j*65, i*65, "down3"));
					}
					else if(col[j] == "down4"){
						add(new Floors(j*65, i*65, "down4"));
					}
					else if(col[j] == "down5"){
						add(new Floors(j*65, i*65, "down5"));
					}
					else if(col[j] == "bup"){
						add(new Floors(j*65, i*65, "bup"));
					}
					else if(col[j] == "bleft"){
						add(new Floors(j*65, i*65, "bleft"));
					}
					else if(col[j] == "bright"){
						add(new Floors(j*65, i*65, "bright"));
					}
					else if(col[j] == "bdown"){
						add(new Floors(j*65, i*65, "bdown"));
					}
					else if(col[j] == "bf"){
						add(new Floors(j*65, i*65, "bf"));
					}
					else if(col[j] == "dup"){
						add(new Floors(j*65, i*65, "dup"));
					}
					else if(col[j] == "dleft"){
						add(new Floors(j*65, i*65, "dleft"));
					}
					else if(col[j] == "dc"){
						add(new Floors(j*65, i*65, "dc"));
					}
				}
			}
			
			trace(map.length);
			*/
		}
		
	}
} 
