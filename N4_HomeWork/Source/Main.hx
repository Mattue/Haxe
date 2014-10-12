package;
// 
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.Lib;

import openfl.display.BitmapData;
import openfl.display.Sprite;
import openfl.Assets;
import openfl.display.Bitmap;


class Main extends Sprite 
{
	var inited:Bool;

	/* ENTRY POINT */

	function resize(e) 
	{
		if (!inited) init();
		// else (resize or orientation change)
	}

	
	var _game:Game;
	
	
	function init() 
	{
		if (inited) return;
		inited = true;

		// (your code here)

		startNewGame();			
		
		// Stage:
		// stage.stageWidth x stage.stageHeight @ stage.dpiScale
		// Assets:
		// nme.Assets.getBitmapData("img/assetname.jpg");
	}
			
	public function startNewGame ()
	{
		if (_game != null)
			{
				//removing game
			}
		_game = new Game();
		addChild(_game);
	}

	

	/* SETUP */

	public function new() 
	{
		super(); 
		addEventListener(Event.ADDED_TO_STAGE, added);
	}

	function added(e) 
	{
		removeEventListener(Event.ADDED_TO_STAGE, added);
		stage.addEventListener(Event.RESIZE, resize);
		#if ios
		haxe.Timer.delay(init, 100); // iOS 6
		#else
		init();
		#end
	}

	public static function main() 
	{
		// static entry point
		Lib.current.stage.align = flash.display.StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;
		Lib.current.addChild(new Main());
	}
}