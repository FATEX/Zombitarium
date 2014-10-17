package objects
{
	import Key;
	
	public class Janitor extends Human
	{
		[Embed(source="walk_nurse_front.png")] private static var ImgJanitor:Class;
		[Embed(source="spaceman.png")] private static var ImgJanitorZom:Class;
		public var key:Key;
		
		public function Janitor(originX:Number, originY:Number)
		{
			super(originX, originY);

			
			//key = new Key(c, d, p, this.x, this.y+50);
			//key.visible = false;
		}
		
		public function die() :void{
				key.collectable = true;
				key.visible = true;
				
			
		}
	}
}