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
		
		[Embed(source="doorL_100.png")] public static var ImgDoorClose:Class;
		[Embed(source="doorOpenL_100.png")] public static var ImgDoorOpen:Class;
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