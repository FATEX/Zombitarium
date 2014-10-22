package objects
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import objects.Human;
	
	import org.flixel.FlxPath;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxTilemap;
	
	public class Doctor extends Human
	{
		private const TILE_WIDTH:uint = 100;
		private const TILE_HEIGHT:uint = 100;
		[Embed(source="doctor_front_1SUPERTINY.png")] private static var ImgSpaceman:Class;
		[Embed(source="alert_anim.png")] private static var ImgAlert:Class;
		
		public function Doctor(originX:Number, originY:Number)
		{
			super(originX, originY);
			super.loadGraphic(ImgSpaceman, true, true, TILE_WIDTH,TILE_HEIGHT);
		}
		
		public function throwSyringe(dPosx:int, dPosy:int, tPosx:int, tPosy:int):Boolean{
			//TODO
			if(dPosx == tPosx || dPosy == tPosy){
				return true;
			}
			return false;
		}
		
		public function die():void{
			super.destroy();
		}
	}
}