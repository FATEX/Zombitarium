package objects
{
	import org.flixel.FlxSprite;
	public class Wall extends FlxSprite
	{
		[Embed(source = 'Walls/wall_tile_corner_gray_65x65_1.png')]private static var wallC1:Class;
		[Embed(source = 'Walls/wall_tile_corner_gray_65x65_2.png')]private static var wallC2:Class;
		[Embed(source = 'Walls/wall_tile_corner_gray_65x65_3.png')]private static var wallC3:Class;
		[Embed(source = 'Walls/wall_tile_corner_gray_65x65_4.png')]private static var wallC4:Class;
		[Embed(source = 'Walls/wall_tile_type1_gray_65x65_up.png')]private static var wall1Up:Class;
		[Embed(source = 'Walls/wall_tile_type1_gray_65x65_left.png')]private static var wall1Left:Class;
		[Embed(source = 'Walls/wall_tile_type1_gray_65x65_right.png')]private static var wall1Right:Class;
		[Embed(source = 'Walls/wall_tile_type1_gray_65x65_down.png')]private static var wall1Down:Class;
		[Embed(source = 'Walls/wall_tile_type2_gray_65x65_up.png')]private static var wall2Up:Class;
		[Embed(source = 'Walls/wall_tile_type2_gray_65x65_left.png')]private static var wall2Left:Class;
		[Embed(source = 'Walls/wall_tile_type2_gray_65x65_right.png')]private static var wall2Right:Class;
		[Embed(source = 'Walls/wall_tile_type2_gray_65x65_down.png')]private static var wall2Down:Class;
		
		/*[Embed(source = 'wall_tile_type1_gray_65x65_2.png')]private static var wall12:Class;
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
		[Embed(source = 'wall_tile_type5_gray_65x65.png')]private static var wall5:Class;*/
		[Embed(source = 'Walls/wall_tile_type6_gray_65x65_with_shadow_dark.png')]private static var wallDarkRCorner:Class;
		[Embed(source = 'Walls/wall_tile_corner2_gray_65x65_left.png')]private static var wallDarkCornerL:Class;
		[Embed(source = 'Walls/wall_tile_corner2_gray_65x65_right.png')]private static var wallDarkCornerR:Class;
		[Embed(source = 'Walls/wall_tile_type5_gray_65x65.png')]private static var wall5:Class;
		
		private const TILE_WIDTH:uint = 65;
		private const TILE_HEIGHT:uint = 65;
		public function Wall(x:int, y:int, label:String)
		{
			super(x,y);
			if(label == "A"){
				super.loadGraphic(wallC1, true, true, TILE_WIDTH, TILE_HEIGHT);
			}
			else if(label == "B"){
				super.loadGraphic(wallC2, true, true, TILE_WIDTH, TILE_HEIGHT);
			}
			else if(label == "C"){
				super.loadGraphic(wallC3, true, true, TILE_WIDTH, TILE_HEIGHT);
			}
			else if(label == "D"){
				super.loadGraphic(wallC4, true, true, TILE_WIDTH, TILE_HEIGHT);
			}
			else if(label == "E"){
				super.loadGraphic(wall1Up, true, true, TILE_WIDTH, TILE_HEIGHT);
			}
			else if(label == "F"){
				super.loadGraphic(wall1Left, true, true, TILE_WIDTH, TILE_HEIGHT);
			}
			else if(label == "G"){
				super.loadGraphic(wall1Right, true, true, TILE_WIDTH, TILE_HEIGHT);
			}
			else if(label == "H"){
				super.loadGraphic(wall1Down, true, true, TILE_WIDTH, TILE_HEIGHT);
			}
			else if(label == "1"){
				super.loadGraphic(wall2Up, true, true, TILE_WIDTH, TILE_HEIGHT);
			}
			else if(label == "2"){
				super.loadGraphic(wall2Left, true, true, TILE_WIDTH, TILE_HEIGHT);
			}
			else if(label == "3"){
				super.loadGraphic(wall2Right, true, true, TILE_WIDTH, TILE_HEIGHT);
			}
			else if(label == "4"){
				super.loadGraphic(wall2Down, true, true, TILE_WIDTH, TILE_HEIGHT);
			}
			else if(label == "5"){
				super.loadGraphic(wallDarkRCorner, true, true, TILE_WIDTH, TILE_HEIGHT);
			}
			else if(label == "6"){
				super.loadGraphic(wall5, true, true, TILE_WIDTH, TILE_HEIGHT);
			}
			else if(label == "7"){
				super.loadGraphic(wallDarkCornerL, true, true, TILE_WIDTH, TILE_HEIGHT);
			}
			else if(label == "8"){
				super.loadGraphic(wallDarkCornerR, true, true, TILE_WIDTH, TILE_HEIGHT);
			}
		}
	}
}