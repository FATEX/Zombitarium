package objects
{
	import Key;
	
	public class Janitor extends Human
	{
		[Embed(source="janitor_all.png")] private static var ImgJanitor:Class;
		public var key:Key;
		
		public function Janitor(originX:Number, originY:Number)
		{
			super(originX, originY,true);

			
			//key = new Key(c, d, p, this.x, this.y+50);
			//key.visible = false;
		}
		
		public function die() :void{
				key.collectable = true;
				key.visible = true;
				
			
		}
	}
}