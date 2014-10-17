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
		private const TILE_WIDTH:uint = 16;
		private const TILE_HEIGHT:uint = 16;
		[Embed(source="spaceman.png")] private static var ImgSpaceman:Class;
		
		public function Doctor(originX:Number, originY:Number)
		{
			super(originX, originY);
			super.loadGraphic(ImgSpaceman, true, true, 16);
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