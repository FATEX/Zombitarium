package
{
	import flash.display.BlendMode;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	import objects.Human;
	
	import org.flixel.FlxButton;
	import org.flixel.FlxCamera;
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	import org.flixel.FlxPath;
	import org.flixel.FlxPoint;
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
		private var player:Zombie;
		private var zombie:Human;
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
//		private var keyCollected:Boolean = false;
//		private var doorOpen:Boolean = false;
//		private var doorKey:FlxSprite;
//		private var door:FlxSprite;
//		private var doorOpenImg:FlxSprite;
//		private var pressed:Boolean = true;
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
			
			// Then we setup two cameras to follow each of the two players
			
			var cam:FlxCamera = new FlxCamera(0,0, FlxG.width/4, FlxG.height/4, 4); // we put the first one in the top left corner
			cam.follow(player);
			// this sets the limits of where the camera goes so that it doesn't show what's outside of the tilemap
			cam.setBounds(0,0,collisionMap.width, collisionMap.height);
			cam.color = 0xFFCCCC; // add a light red tint to the camera to differentiate it from the other
			FlxG.addCamera(cam);
			
			// Almost the same thing as the first camera
			cam = new FlxCamera(FlxG.width,0, FlxG.width/2, FlxG.height,4);    // and the second one in the top middle of the screen
			//cam.follow(zombie);
			cam.setBounds(0,0,collisionMap.width, collisionMap.height);
			//cam.color = 0xCCCCFF; // Add a light blue tint to the camera
			FlxG.addCamera(cam);
			
			cam = new FlxCamera(0,FlxG.height, FlxG.width/2, FlxG.height,4);    // and the second one in the top middle of the screen
			//cam.follow(zombie);
			cam.setBounds(0,0,collisionMap.width, collisionMap.height);
			//cam.color = 0xCCCCFF; // Add a light blue tint to the camera
			FlxG.addCamera(cam);
			
			// add quit button
			/*var quitBtn:FlxButton = new FlxButton(1000, 1000, "Quit", onQuit); //put the button out of screen so we don't see in the two other cameras
			add(quitBtn);
			
			// Create a camera focused on the quit button.
			// We do this because we don't want the quit button to be
			// tinted by the other cameras.
			cam = new FlxCamera(2, 2, quitBtn.width, quitBtn.height);
			cam.follow(quitBtn);
			FlxG.addCamera(cam);*/
			
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
			if(player.alive && zombie.alive){
				FlxG.collide(player,zombie,collided);
			}
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
			zombie.humanUpdate(collisionMap);
			
			if(player.alive && zombie.alive){
				if(detect(zombie,player)){
					zombie.setPath(new FlxPoint(player.x + player.width / 2, player.y + player.height / 2),collisionMap);
					zombie.color=0xFFD700;
				}
				else if(zombie.pathSpeed==0){
					zombie.goBack(collisionMap);
				}
				else if(zombie.isFollowing){
					if(FlxG.collide(zombie,collisionMap)){
						zombie.goBack(collisionMap);
					}
				}
				else{
					zombie.color=0x800000;
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
				remove(man,true);
				man.alive=false;
			}
			else{
				man.stunHuman();
			}
			}
		else{
			var infected:Zombie = new Zombie(man.x,man.y,man.width,man.health,man.drag.x,man.drag.y,man.maxVelocity.x,man.maxVelocity.y);
			add(infected);
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
			zombie = new Human(6*TILE_WIDTH,2*TILE_HEIGHT);
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
			
			add(zombie);
			zombie.color=0x800000;
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
			player.addAnimation("run", [1, 2, 3, 0], 12);
			player.addAnimation("jump", [4]);
			
			add(player);
			
			//doorKey = new FlxSprite(40, 260); 
			//doorKey.loadGraphic(ImgKey, false, false, 16); 
			add(door1);
			add(key1);
			
			
			
			//door = new FlxSprite(120, 255); 
			//door.loadGraphic(ImgDoor, false, false, 30); 
			//door.maxVelocity.x = 0;
			//door.maxVelocity.y = 0;
			//door.immovable = true;
			//add(door);
			
			//doorOpenImg = new FlxSprite(120, 255); 
			//doorOpenImg.loadGraphic(ImgDoorOpen, false, false, 30); 
			//doorOpenImg.immovable = true;
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
		

		private function detect(looker:Human,lookee:FlxObject):Boolean
		{
			if(collisionMap.ray(new FlxPoint(looker.x + looker.width / 2, looker.y + looker.height / 2),new FlxPoint(lookee.x + lookee.width / 2, lookee.y + lookee.height / 2))){
				if(FlxU.getDistance(new FlxPoint(looker.x + looker.width / 2, looker.y + looker.height / 2),new FlxPoint(lookee.x + lookee.width / 2, lookee.y + lookee.height / 2))<=this.distanceCanSee){
					var angle:Number = FlxU.getAngle(new FlxPoint(looker.x + looker.width / 2, looker.y + looker.height / 2),new FlxPoint(lookee.x + lookee.width / 2, lookee.y + lookee.height / 2));
					if(angle>=looker.getAngle()-this.coneWidth && angle<=looker.getAngle()+this.coneWidth){
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
