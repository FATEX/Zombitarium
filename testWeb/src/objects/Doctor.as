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

		private const TILE_WIDTH:uint = 65;
		private const TILE_HEIGHT:uint = 65;
		[Embed(source="doctor_front_1.png")] private static var ImgSpaceman:Class;

		[Embed(source="alert_anim_100.png")] private static var ImgAlert:Class;
		
		public function Doctor(originX:Number, originY:Number)
		{
			super(originX, originY,false);
			super.loadGraphic(ImgSpaceman, true, true, TILE_WIDTH,TILE_HEIGHT);
			super.addAnimation("idle", [0]);
			super.addAnimation("run", [0]);
			super.addAnimation("idleBack", [1]);
			super.addAnimation("runBack", [1]);
			super.addAnimation("right",[2]);
			super.addAnimation("bottomLeft",[3]);
			super.addAnimation("topRight",[4]);
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