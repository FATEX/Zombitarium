package
{
	import flash.media.Sound;
	
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	

	public class Door extends FlxSprite
	{
		var doorOpen:Boolean = false;
		var doorOpenImg:FlxSprite;
		var pressed:Boolean = true;
		var isWin:Boolean = false;
		
		private const TILE_WIDTH:uint = 65;
		private const TILE_HEIGHT:uint = 65;
		
		[Embed(source="doorL_100.png")] static var ImgDoorClose:Class;
		[Embed(source="doorOpenL_100.png")] static var ImgDoorOpen:Class;
		[Embed(source="doorWin_100.png")] private static var ImgDoorCloseWin:Class;
		[Embed(source="doorOpenWin_100.png")] private static var ImgDoorOpenWin:Class;
		[Embed(source = "doorSound.mp3")]private var MySound : Class; 		 
		private var sound : Sound; // not MySound! 
		
		
		public function Door(tx,ty)
		{
			super(tx,ty);
			this.height=TILE_HEIGHT;
			this.width=TILE_WIDTH;
		
		}
		public function updateDoor(p):void 
		{
			if (doorOpen == false) {
				if(isWin){
					this.loadGraphic(ImgDoorCloseWin, false, false, TILE_WIDTH*1.5, TILE_HEIGHT*1.5);
				}else{
					this.loadGraphic(ImgDoorClose, false, false, TILE_WIDTH*1.5, TILE_HEIGHT*1.5);
				}
				this.immovable = true;
			} else
			{
				if(isWin){
					this.loadGraphic(ImgDoorOpenWin, false, false, TILE_WIDTH*1.5, TILE_HEIGHT*1.5);
				}else{
					this.loadGraphic(ImgDoorOpen, false, false,  TILE_WIDTH*1.5, TILE_HEIGHT*1.5);
				}
				this.immovable = true;
				
			}
//			if(doorOpen == false){ // if the door hasn't been opened yet
//					if(FlxG.overlap(p, this) && FlxG.keys.E && pressed){ // check if the door and the player are touching
//						pressed = false;
//						doorOpen = true;
//						sound = (new MySound()) as Sound;
//						sound.play();
////						state.revealBoard()
////						for(var i:int =0; i<zombies.length;i++){
////							zombies[i].checkPath(c);
////						}
//						
//					} else if (FlxG.keys.E == false) {
//						pressed = true;
//					}
//				
//			}
//			else
//			{
//				if (FlxG.keys.E && pressed && FlxG.overlap(p, this)) {
//					pressed = false;
//					doorOpen = false;
////					PlayState.logger.recordEvent(PlayState.level+1,12,"pos=("+(int)(p.x/TILE_WIDTH)+","+(int)(p.y/TILE_HEIGHT)+")|action:close locked door");
////					c.setTile(tx, ty, 1);
////					state.revealBoard();
////					for(var j:int =0; j<zombies.length;j++){
////						zombies[j].checkPath(c);
////					}
//				} 
//				else if (FlxG.keys.E == false) {
//					pressed = true;
//				}
//				
//			}
		}
	}
}