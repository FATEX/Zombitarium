package objects
{
	import org.flixel.FlxSprite;
	public class Wall extends FlxSprite
	{
		[Embed(source = 'wall_tile_corner_gray_65x65_1.png')]private static var wall01:Class;
		[Embed(source = 'wall_tile_corner_gray_65x65_2.png')]private static var wall02:Class;
		[Embed(source = 'wall_tile_corner_gray_65x65_3.png')]private static var wall03:Class;
		[Embed(source = 'wall_tile_corner_gray_65x65_4.png')]private static var wall04:Class;
		[Embed(source = 'wall_tile_type1_gray_65x65_1.png')]private static var wall11:Class;
		[Embed(source = 'wall_tile_type1_gray_65x65_2.png')]private static var wall12:Class;
		[Embed(source = 'wall_tile_type1_gray_65x65_3.png')]private static var wall13:Class;
		[Embed(source = 'wall_tile_type1_gray_65x65_4.png')]private static var wall14:Class;
		[Embed(source = 'wall_tile_type2_gray_65x65_1.png')]private static var wall21:Class;
		[Embed(source = 'wall_tile_type2_gray_65x65_2.png')]private static var wall22:Class;
		[Embed(source = 'wall_tile_type2_gray_65x65_3.png')]private static var wall23:Class;
		[Embed(source = 'wall_tile_type2_gray_65x65_4.png')]private static var wall24:Class;
		[Embed(source = 'wall_tile_type4_gray_65x65_1.png')]private static var wall41:Class;
		[Embed(source = 'wall_tile_type4_gray_65x65_2.png')]private static var wall42:Class;
		[Embed(source = 'wall_tile_type6_gray_65x65.png')]private static var wall43:Class;
		[Embed(source = 'wall_tile_type4_gray_65x65_4.png')]private static var wall44:Class;
		[Embed(source = 'wall_tile_type5_gray_65x65.png')]private static var wall5:Class;
		[Embed(source = 'Floors/wall_tile_type6_gray_65x65_with_shadow_dark.png')]private static var wallDarkRCorner:Class;
		private const TILE_WIDTH:uint = 65;
		private const TILE_HEIGHT:uint = 65;
		public function Wall(x:int, y:int, label:int)
		{
			super(x,y);
			if(label == 1){
				super.loadGraphic(wall01, true, true, TILE_WIDTH, TILE_HEIGHT);
			}
			else if(label == 2){
				super.loadGraphic(wall02, true, true, TILE_WIDTH, TILE_HEIGHT);
			}
			else if(label == 3){
				super.loadGraphic(wall03, true, true, TILE_WIDTH, TILE_HEIGHT);
			}
			else if(label == 4){
				super.loadGraphic(wall04, true, true, TILE_WIDTH, TILE_HEIGHT);
			}
			else if(label == 5){
				super.loadGraphic(wall21, true, true, TILE_WIDTH, TILE_HEIGHT);
			}
			else if(label == 6){
				super.loadGraphic(wall22, true, true, TILE_WIDTH, TILE_HEIGHT);
			}
			else if(label == 7){
				super.loadGraphic(wall23, true, true, TILE_WIDTH, TILE_HEIGHT);
			}
			else if(label == 8){
				super.loadGraphic(wall24, true, true, TILE_WIDTH, TILE_HEIGHT);
			}
			else if(label == 9){
				super.loadGraphic(wall41, true, true, TILE_WIDTH, TILE_HEIGHT);
			}
			else if(label == 10){
				super.loadGraphic(wall42, true, true, TILE_WIDTH, TILE_HEIGHT);
			}
			else if(label == 11){
				super.loadGraphic(wall43, true, true, TILE_WIDTH, TILE_HEIGHT);
			}
			else if(label == 12){
				super.loadGraphic(wall44, true, true, TILE_WIDTH, TILE_HEIGHT);
			}
			else if(label == 0){
				super.loadGraphic(wallDarkRCorner, true, true, TILE_WIDTH, TILE_HEIGHT);
			}
		}
	}
}