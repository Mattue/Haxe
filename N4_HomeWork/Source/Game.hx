package ;
//
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.Lib;

import openfl.display.BitmapData;
import openfl.display.Sprite;
import openfl.Assets;
import openfl.display.Bitmap;

/**
 * @author Mattue
 */

class Game extends Sprite
{
	
	var map:Array<Int> = [];
	
	public function new() 
	{
		super();
		setMapFromBitmap();
		drawMap();
		addChild(tilesSprite);

	}

	var tilesSprite:Sprite = new Sprite();
	
	public function drawMap()
	{
		while (tilesSprite.numChildren > 0) tilesSprite.removeChildAt(0);
		for (iy in 0 ... 15)
			for (ix in 0 ... 25)
			{
				var bmpData:BitmapData = switch (map[ix + iy*25])
					{
						case 1: Assets.getBitmapData("img/brick.png");

						default: null;
				}
				if (bmpData != null)
				{
					var bmp = new Bitmap (bmpData);
					bmp.scaleX = 4;
					bmp.scaleY = 4;
					bmp.x = ix * 32;
					bmp.y = iy * 32;
					tilesSprite.addChild(bmp);
				}
			}
	}

	
	public function setMapFromBitmap()
	{
		var bitmapData:BitmapData = Assets.getBitmapData("img/level.png");
		
		for (iy in 0 ... bitmapData.height)
			for (ix in 0 ... bitmapData.width)
				{
					var color:UInt = bitmapData.getPixel(ix, iy);
					var cell:Int = switch (color)
						{
							case 0xffffff: 1;

							default: 0;
						}
					map.push(cell);

				}
	}

}