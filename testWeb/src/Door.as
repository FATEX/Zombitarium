package
{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	

	public class Door extends DoorObject
	{
		var doorOpenImg:FlxSprite;
		var pressed:Boolean = true;
		var isWin:Boolean = false;
		private var keyCollectedAlways:Boolean = true;
		
		private const TILE_WIDTH:uint = 65;
		private const TILE_HEIGHT:uint = 65;
		
		[Embed(source="wall_door_locked_gray_with_trim.png")] static var ImgDoorClose:Class;
		[Embed(source="wall_door_unlocked_gray_65x65.png")] static var ImgDoorOpen:Class;
		[Embed(source="doorWin_100.png")] private static var ImgDoorCloseWin:Class;
		[Embed(source="doorOpenWin_100.png")] private static var ImgDoorOpenWin:Class;
		[Embed(source = "doorIO.mp3")]private var MySound : Class; 
		[Embed(source = "locked-door.mp3")]private var MySoundLockedDoor : Class; 		 
		private var sound : Sound; // not MySound! 
		private var doorUnlocked:Boolean=false;
		
		public function Door(tx,ty)
		{
			super(tx,ty);
			this.height=TILE_HEIGHT;
			this.width=TILE_WIDTH;
		
		}
		public function updateDoor():void 
		{
			
			
			if (doorOpen == false) {
				if(isWin){
					this.loadGraphic(ImgDoorClose, false, false, TILE_WIDTH, TILE_HEIGHT);

				}else{
					this.loadGraphic(ImgDoorClose, false, false, TILE_WIDTH, TILE_HEIGHT);

				}
				this.immovable = true;
			} else
			{
				if(isWin){
					this.loadGraphic(ImgDoorOpen, false, false, TILE_WIDTH, TILE_HEIGHT);

				}else{
					this.loadGraphic(ImgDoorOpen, false, false,  TILE_WIDTH, TILE_HEIGHT);

				}
				this.immovable = true;
				
			}
			
			
				
			
		}
		public function soundDoor(p, d) {
			if(FlxG.overlap(p, d) && FlxG.keys.E && pressed){ // check if the door and the player are touching
						pressed = false;
						
						if(this.doorOpen || this.doorUnlocked){
							sound = (new MySound()) as Sound;
							sound.play();
							this.doorUnlocked=true;
						}
						else if(!doorUnlocked){
							sound = (new MySoundLockedDoor()) as Sound;
							sound.play();
						}
						
						
					} else if (FlxG.keys.E == false) {
						pressed = true;
						
					}
				
		}
	}
}