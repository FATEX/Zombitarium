package objects
{
	import org.flixel.FlxSprite;
	public class Floors extends FlxSprite
	{
		private const TILE_WIDTH:uint = 65;
		private const TILE_HEIGHT:uint = 65;
		
		[Embed(source = 'Floors/floor_tile_type1_gray.png')]private static var floor1:Class;
		[Embed(source = 'Floors/floor_tile_type2_gray.png')]private static var floor2:Class;
		[Embed(source = 'Floors/floor_tile_type3_gray.png')]private static var floor3:Class;
		[Embed(source = 'Floors/floor_tile_type4_gray.png')]private static var floor4:Class;
		[Embed(source = 'Floors/floor_tile_type5_gray.png')]private static var floor5:Class;
		
		[Embed(source = 'Floors/floor_tile_type1_gray_with_shadow_up.png')]private static var floorUp1:Class;
		[Embed(source = 'Floors/floor_tile_type2_gray_with_shadow_up.png')]private static var floorUp2:Class;
		[Embed(source = 'Floors/floor_tile_type3_gray_with_shadow_up.png')]private static var floorUp3:Class;
		[Embed(source = 'Floors/floor_tile_type4_gray_with_shadow_up.png')]private static var floorUp4:Class;
		[Embed(source = 'Floors/floor_tile_type5_gray_with_shadow_up.png')]private static var floorUp5:Class;
		
		[Embed(source = 'Floors/floor_tile_type1_gray_with_shadow_left.png')]private static var floorLeft1:Class;
		[Embed(source = 'Floors/floor_tile_type2_gray_with_shadow_left.png')]private static var floorLeft2:Class;
		[Embed(source = 'Floors/floor_tile_type3_gray_with_shadow_left.png')]private static var floorLeft3:Class;
		[Embed(source = 'Floors/floor_tile_type4_gray_with_shadow_left.png')]private static var floorLeft4:Class;
		[Embed(source = 'Floors/floor_tile_type5_gray_with_shadow_left.png')]private static var floorLeft5:Class;
		
		[Embed(source = 'Floors/floor_tile_type1_gray_with_shadow_right.png')]private static var floorRight1:Class;
		[Embed(source = 'Floors/floor_tile_type2_gray_with_shadow_right.png')]private static var floorRight2:Class;
		[Embed(source = 'Floors/floor_tile_type3_gray_with_shadow_right.png')]private static var floorRight3:Class;
		[Embed(source = 'Floors/floor_tile_type4_gray_with_shadow_right.png')]private static var floorRight4:Class;
		[Embed(source = 'Floors/floor_tile_type5_gray_with_shadow_right.png')]private static var floorRight5:Class;
		
		[Embed(source = 'Floors/floor_tile_type1_gray_with_shadow_down.png')]private static var floorDown1:Class;
		[Embed(source = 'Floors/floor_tile_type2_gray_with_shadow_down.png')]private static var floorDown2:Class;
		[Embed(source = 'Floors/floor_tile_type3_gray_with_shadow_down.png')]private static var floorDown3:Class;
		[Embed(source = 'Floors/floor_tile_type4_gray_with_shadow_down.png')]private static var floorDown4:Class;
		[Embed(source = 'Floors/floor_tile_type5_gray_with_shadow_down.png')]private static var floorDown5:Class;
		
		[Embed(source = 'Floors/basic_floor_with_shadow_up.png')]private static var floorBasicUp:Class;
		[Embed(source = 'Floors/basic_floor_with_shadow_left.png')]private static var floorBasicLeft:Class;
		[Embed(source = 'Floors/basic_floor_with_shadow_right.png')]private static var floorBasicRight:Class;
		[Embed(source = 'Floors/basic_floor_with_shadow_down.png')]private static var floorBasicDown:Class;
		[Embed(source = 'Floors/basic_floor_tile.png')]private static var floorBasic:Class;
		
		[Embed(source = 'Floors/floor_tile_type1_gray_with_shadow_dark_up.png')]private static var floorDarkUp:Class;
		[Embed(source = 'Floors/floor_tile_type1_gray_with_shadow_dark_left.png')]private static var floorDarkLeft:Class;
		[Embed(source = 'Floors/floor_tile_corner_gray_with_shadow_dark.png')]private static var floorDarkCorner:Class;
		
		public function Floors(x:int, y:int, label:String)
		{
			super(x,y);
			if(label == "A"){
				super.loadGraphic(floor1, true, true, TILE_WIDTH, TILE_HEIGHT);
			}
			else if(label == "B"){
				super.loadGraphic(floor2, true, true, TILE_WIDTH, TILE_HEIGHT);
			}
			else if(label == "C"){
				super.loadGraphic(floor3, true, true, TILE_WIDTH, TILE_HEIGHT);
			}
			else if(label == "D"){
				super.loadGraphic(floor4, true, true, TILE_WIDTH, TILE_HEIGHT);
			}
			else if(label == "E"){
				super.loadGraphic(floor5, true, true, TILE_WIDTH, TILE_HEIGHT);
			}
			else if(label == "up1"){
				super.loadGraphic(floorUp1, true, true, TILE_WIDTH, TILE_HEIGHT);
			}
			else if(label == "up2"){
				super.loadGraphic(floorUp2, true, true, TILE_WIDTH, TILE_HEIGHT);
			}
			else if(label == "up3"){
				super.loadGraphic(floorUp3, true, true, TILE_WIDTH, TILE_HEIGHT);
			}
			else if(label == "up4"){
				super.loadGraphic(floorUp4, true, true, TILE_WIDTH, TILE_HEIGHT);
			}
			else if(label == "up5"){
				super.loadGraphic(floorUp5, true, true, TILE_WIDTH, TILE_HEIGHT);
			}
			else if(label == "left1"){
				super.loadGraphic(floorLeft1, true, true, TILE_WIDTH, TILE_HEIGHT);
			}
			else if(label == "left2"){
				super.loadGraphic(floorLeft2, true, true, TILE_WIDTH, TILE_HEIGHT);
			}
			else if(label == "left3"){
				super.loadGraphic(floorLeft3, true, true, TILE_WIDTH, TILE_HEIGHT);
			}
			else if(label == "left4"){
				super.loadGraphic(floorLeft4, true, true, TILE_WIDTH, TILE_HEIGHT);
			}
			else if(label == "left5"){
				super.loadGraphic(floorLeft5, true, true, TILE_WIDTH, TILE_HEIGHT);
			}
			else if(label == "right1"){
				super.loadGraphic(floorRight1, true, true, TILE_WIDTH, TILE_HEIGHT);
			}
			else if(label == "right2"){
				super.loadGraphic(floorRight2, true, true, TILE_WIDTH, TILE_HEIGHT);
			}
			else if(label == "right3"){
				super.loadGraphic(floorRight3, true, true, TILE_WIDTH, TILE_HEIGHT);
			}
			else if(label == "right4"){
				super.loadGraphic(floorRight4, true, true, TILE_WIDTH, TILE_HEIGHT);
			}
			else if(label == "right5"){
				super.loadGraphic(floorRight5, true, true, TILE_WIDTH, TILE_HEIGHT);
			}
			else if(label == "down1"){
				super.loadGraphic(floorDown1, true, true, TILE_WIDTH, TILE_HEIGHT);
			}
			else if(label == "down2"){
				super.loadGraphic(floorDown2, true, true, TILE_WIDTH, TILE_HEIGHT);
			}
			else if(label == "down3"){
				super.loadGraphic(floorDown3, true, true, TILE_WIDTH, TILE_HEIGHT);
			}
			else if(label == "down4"){
				super.loadGraphic(floorDown4, true, true, TILE_WIDTH, TILE_HEIGHT);
			}
			else if(label == "down5"){
				super.loadGraphic(floorDown5, true, true, TILE_WIDTH, TILE_HEIGHT);
			}
			else if(label == "bup"){
				super.loadGraphic(floorBasicUp, true, true, TILE_WIDTH, TILE_HEIGHT);
			}
			else if(label == "bleft"){
				super.loadGraphic(floorBasicLeft, true, true, TILE_WIDTH, TILE_HEIGHT);
			}
			else if(label == "bright"){
				super.loadGraphic(floorBasicRight, true, true, TILE_WIDTH, TILE_HEIGHT);
			}
			else if(label == "bdown"){
				super.loadGraphic(floorBasicDown, true, true, TILE_WIDTH, TILE_HEIGHT);
			}
			else if(label == "bf"){
				super.loadGraphic(floorBasic, true, true, TILE_WIDTH, TILE_HEIGHT);
			}
			else if(label == "dup"){
				super.loadGraphic(floorDarkUp, true, true, TILE_WIDTH, TILE_HEIGHT);
			}
			else if(label == "dleft"){
				super.loadGraphic(floorDarkLeft, true, true, TILE_WIDTH, TILE_HEIGHT);
			}
			else if(label == "dc"){
				super.loadGraphic(floorDarkCorner, true, true, TILE_WIDTH, TILE_HEIGHT);
			}
		}
	}
}