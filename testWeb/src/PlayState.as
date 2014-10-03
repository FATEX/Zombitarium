package
{
	import flash.display.BlendMode;
	
	import org.flixel.FlxButton;
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	import org.flixel.FlxPath;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxU;
	import org.flixel.FlxTilemap;

	public class PlayState extends FlxState
	{
		// Tileset that works with AUTO mode (best for thin walls)
		[Embed(source = 'auto_tiles.png')]private static var auto_tiles:Class;
		
		// Tileset that works with ALT mode (best for thicker walls)
		[Embed(source = 'alt_tiles.png')]private static var alt_tiles:Class;
		
		// Tileset that works with OFF mode (do what you want mode)
		[Embed(source = 'empty_tiles.png')]private static var empty_tiles:Class;
		
		// Default tilemaps. Embedding text files is a little weird.
		[Embed(source = 'default_auto.txt', mimeType = 'application/octet-stream')]private static var default_auto:Class;
		[Embed(source = 'default_alt.txt', mimeType = 'application/octet-stream')]private static var default_alt:Class;
		[Embed(source = 'default_empty.txt', mimeType = 'application/octet-stream')]private static var default_empty:Class;

		[Embed(source="spaceman.png")] private static var ImgSpaceman:Class;
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
		private var player:FlxSprite;
		private var zombie:FlxSprite;
		private var isFollowing:Boolean;
		private var isChasing:Boolean=false;
		private var xPos:int;
		// Some interface buttons and text
		private var autoAltBtn:FlxButton;
		private var resetBtn:FlxButton;
		private var quitBtn:FlxButton;
		private var helperTxt:FlxText;
		private var destination:FlxPoint;
		// Key and Door
		private var door1:Door = new Door(120, 255);
		private var key1:Key = new Key(collisionMap, door1, player, 40, 260);

		
		//constants For detection
		private var distanceCanSee:int = 100;
		private var coneWidth:Number = 45;
		override public function create():void
		{
			FlxG.framerate = 50;
			FlxG.flashFramerate = 50;
			//Load _datamap to _map and add to PlayState
			
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
			
			// When switching between modes here, the map is reloaded with it's own data, so the positions of tiles are kept the same
			// Notice that different tilesets are used when the auto mode is switched
			autoAltBtn = new FlxButton(4, FlxG.height - 24, "AUTO", function():void
			{
				switch(collisionMap.auto)
				{
					case FlxTilemap.AUTO:
						collisionMap.loadMap(FlxTilemap.arrayToCSV(collisionMap.getData(true), collisionMap.widthInTiles),
							alt_tiles, TILE_WIDTH, TILE_HEIGHT, FlxTilemap.ALT);
						autoAltBtn.label.text = "ALT";
						break;
						
					case FlxTilemap.ALT:
						collisionMap.loadMap(FlxTilemap.arrayToCSV(collisionMap.getData(true), collisionMap.widthInTiles),
							empty_tiles, TILE_WIDTH, TILE_HEIGHT, FlxTilemap.OFF);
						autoAltBtn.label.text = "OFF";
						break;
						
					case FlxTilemap.OFF:
						collisionMap.loadMap(FlxTilemap.arrayToCSV(collisionMap.getData(true), collisionMap.widthInTiles),
							auto_tiles, TILE_WIDTH, TILE_HEIGHT, FlxTilemap.AUTO);
						autoAltBtn.label.text = "AUTO";
						break;
				}
				
			});
			add(autoAltBtn);
			
			resetBtn = new FlxButton(8 + autoAltBtn.width, FlxG.height - 24, "Reset", function():void
			{
				switch(collisionMap.auto)
				{
					case FlxTilemap.AUTO:
						collisionMap.loadMap(new default_auto(), auto_tiles, TILE_WIDTH, TILE_HEIGHT, FlxTilemap.AUTO);
						
						player.x = 64;
						player.y = 220;
						break;
						
					case FlxTilemap.ALT:
						collisionMap.loadMap(new default_alt(), alt_tiles, TILE_WIDTH, TILE_HEIGHT, FlxTilemap.ALT);
						player.x = 64;
						player.y = 128;
						break;
						
					case FlxTilemap.OFF:
						collisionMap.loadMap(new default_empty(), empty_tiles, TILE_WIDTH, TILE_HEIGHT, FlxTilemap.OFF);
						player.x = 64;
						player.y = 64;
						break;
				}
			});
			add(resetBtn);
			
			quitBtn = new FlxButton(FlxG.width - resetBtn.width - 4, FlxG.height - 24, "Quit",
				function():void { FlxG.fade(0xff000000, 0.22, function():void { FlxG.switchState(new MenuState()); } ); } );
			add(quitBtn);
			
			helperTxt = new FlxText(12 + autoAltBtn.width*2, FlxG.height - 30, 150, "Click to place tiles\nShift-Click to remove tiles\nArrow keys to move");
			add(helperTxt);
		}
		
		override public function update():void
		{
			// Tilemaps can be collided just like any other FlxObject, and flixel
			// automatically collides each individual tile with the object.
			FlxG.collide(player, collisionMap);
			FlxG.collide(player,zombie,collided);
			highlightBox.x = Math.floor(FlxG.mouse.x / TILE_WIDTH) * TILE_WIDTH;
			highlightBox.y = Math.floor(FlxG.mouse.y / TILE_HEIGHT) * TILE_HEIGHT;
			
			if (FlxG.mouse.pressed())
			{
				// FlxTilemaps can be manually edited at runtime as well.
				// Setting a tile to 0 removes it, and setting it to anything else will place a tile.
				// If auto map is on, the map will automatically update all surrounding tiles.
				if(FlxG.keys.B){
					destination = new FlxPoint(FlxG.mouse.x, FlxG.mouse.y);
				}
				else{
					collisionMap.setTile(FlxG.mouse.x / TILE_WIDTH, FlxG.mouse.y / TILE_HEIGHT, FlxG.keys.SHIFT?0:1);
				}
			}
			
			updatePlayer();
			super.update();
		}
		public function collided(obj1:FlxObject,obj2:FlxObject):void{
			if(zombie.facing==FlxObject.LEFT && zombie.x>player.x){
				player.color=0x0000ff;
			}
			else if(zombie.facing==FlxObject.LEFT && zombie.x<=player.x){
				zombie.color=0x0000ff;
			}
			else if(zombie.facing==FlxObject.RIGHT && zombie.x>player.x){
				zombie.color=0x0000ff;
			}
			else if(zombie.facing==FlxObject.RIGHT && zombie.x<=player.x){
				player.color=0x0000ff;
			}
			
		}
		public override function draw():void
		{
			super.draw();
			highlightBox.drawDebug();
		}
		
		private function setupPlayer():void
		{
			zombie = new FlxSprite(7*TILE_WIDTH, 11*TILE_HEIGHT);
			zombie.loadGraphic(ImgSpaceman, true, true, 16);
			
			//bounding box tweaks
			zombie.width = 14;
			zombie.height = 14;
			zombie.offset.x = 1;
			zombie.offset.y = 1;
			
			//basic player physics
			zombie.drag.x = 640;
			zombie.drag.y = 640;
			//player.acceleration.y = 420;
			zombie.maxVelocity.x = 80;
			zombie.maxVelocity.y = 80;
			
			//animations
			zombie.addAnimation("idle", [0]);
			zombie.addAnimation("run", [1, 2, 3, 0], 12);
			zombie.addAnimation("jump", [4]);
			
			//add(zombie);
			zombie.color=0x800000;
			player = new FlxSprite(20, 20);
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
			player.addAnimation("run", [1, 2, 3, 0], 12);
			player.addAnimation("jump", [4]);
			
			

			add(door1);
			add(key1);
			add(player);

		}
		
		private function updatePlayer():void
		{
			wrap(player);
			key1.checkCollision(collisionMap, door1, player, 8, 17);
			door1.updateDoor();
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
			if (FlxG.mouse.pressed())
			{
				// FlxTilemaps can be manually edited at runtime as well.
				// Setting a tile to 0 removes it, and setting it to anything else will place a tile.
				// If auto map is on, the map will automatically update all surrounding tiles.
				if(FlxG.keys.B){
					destination = new FlxPoint(FlxG.mouse.x, FlxG.mouse.y);
				}
			}
			if(FlxG.keys.A){
				var path:FlxPath = collisionMap.findPath(new FlxPoint(player.x + player.width / 2, player.y + player.height / 2), destination);
				
				//Tell unit to follow path
				player.followPath(path,100,null,true);
				//_action = ACTION_GO;
			}
//			if(zombie.pathSpeed==0){
//				zombie.color=0x800000;
//				isFollowing=true;
//				if(xPos==24){
//					xPos=7;
//					//zombie.facing=FlxObject.LEFT;
//				}
//				else{
//					xPos=24;
//					//zombie.facing=FlxObject.RIGHT;
//				}
//			}
//			if(isFollowing){
//
//			var path:FlxPath = collisionMap.findPath(new FlxPoint(zombie.x + zombie.width / 2, zombie.y + zombie.height / 2), new FlxPoint(xPos*TILE_WIDTH - zombie.width/2, 11*TILE_HEIGHT-zombie.height/2));
//			//Tell unit to follow path
//			zombie.followPath(path,50,FlxObject.PATH_FORWARD,true);
//			isFollowing=false;
//			};
//			if(detect(zombie,player)){
//				this.isChasing=true;
//				var path:FlxPath = collisionMap.findPath(new FlxPoint(zombie.x + zombie.width / 2, zombie.y + zombie.height / 2), new FlxPoint(player.x + player.width / 2, player.y + player.height / 2));
//				//Tell unit to follow path
//				zombie.followPath(path,70,FlxObject.PATH_FORWARD,true);
//				isFollowing=false;
//				zombie.color=0xFFD700;
//			}
//			else 
//			{
//				if(zombie.pathSpeed==0 && this.isChasing)
//				{
//				isFollowing=true;
//				this.isChasing=false;
//				}
//				else if(this.isChasing)
//				{
//					var path:FlxPath = collisionMap.findPath(new FlxPoint(zombie.x + zombie.width / 2, zombie.y + zombie.height / 2), new FlxPoint(player.x + player.width / 2, player.y + player.height / 2));
//					//Tell unit to follow path
//					if(path !=null)
//					{
//						zombie.followPath(path,70,FlxObject.PATH_FORWARD,true);
//					}
//					else{
//						if(FlxG.collide(zombie,collisionMap)){
//							isFollowing=true;
//							this.isChasing=false;
//							zombie.stopFollowingPath(true);
//						}
//						
//					}
//				}
//				zombie.color=0x800000;
//			}
			//ANIMATION
			 if(player.velocity.x == 0 || player.velocity.y == 0)
			{
				player.play("idle");
			}
			else
			{
				player.play("run");
			}
		
		}

		private function detect(looker:FlxObject,lookee:FlxObject):Boolean
		{
			if(collisionMap.ray(new FlxPoint(looker.x + looker.width / 2, looker.y + looker.height / 2),new FlxPoint(lookee.x + lookee.width / 2, lookee.y + lookee.height / 2))){
				if(FlxU.getDistance(new FlxPoint(looker.x + looker.width / 2, looker.y + looker.height / 2),new FlxPoint(lookee.x + lookee.width / 2, lookee.y + lookee.height / 2))<=this.distanceCanSee){
					var angle:Number = FlxU.getAngle(new FlxPoint(looker.x + looker.width / 2, looker.y + looker.height / 2),new FlxPoint(lookee.x + lookee.width / 2, lookee.y + lookee.height / 2));
					if(angle>=looker.angle-this.coneWidth && angle<=looker.angle+this.coneWidth){
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
