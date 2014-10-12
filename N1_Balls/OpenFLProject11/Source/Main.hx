package;

import openfl.display.StageScaleMode;
import openfl.display.StageAlign;
import openfl.display.Bitmap;

import openfl.display.Sprite;
import openfl.events.Event;
import openfl.Lib;
import openfl.events.MouseEvent;
import openfl.Assets;
import motion.Actuate;

class Main extends Sprite 
{
	var inited:Bool;
	
 	function resize(e)
 	{
 		if (!inited) init();
 	}

	var i: Int;
 	var circle:Sprite;
 	var hercle:Sprite;
// 	var myImage:Bitmap;
	
	var c:Float;
 	var d:Float;
	var corx:Float;
	var cory:Float;
	var radius:Float;
	
	var max_radius:Float = 70;
	
	var circles:Array<Sprite> = [];
	var cosarg:Array<Float> = [];
	var sinarg:Array<Float> = [];
	
 	function init () 
 	{
 		if (inited) return;
 		inited = true;
	
 		useHandCursor = true;
 		buttonMode = true;
		
		//addChild(new Bitmap (Assets.getBitmapData ("img/Android_robot.png"))); //фон

		for (i in 0 ... 20)
			{
				var minon : Sprite;
				minon = new Sprite();
				
				c = 9*Math.random()/40;
				d = 6*Math.random()/35;
				
				corx = Math.random();
				cory = Math.random();
 				radius = 10+Math.random()*30;
				
				minon.x = 200+370*corx;
				minon.y = 50+300*cory;
				
				minon.graphics.beginFill(Std.int(Math.random()*0xffffff), Math.random());
				minon.graphics.drawCircle(0, 0, radius);
				circles.push(minon);
				
				cosarg.push(c);
				sinarg.push(d);
				
				addChild(minon);
			}
		
		
		myImage = new Bitmap (Assets.getBitmapData ("img/AWESOME_FACE!!!.png"));
		
		myImage.x = 0;
		myImage.y = 0;
		myImage.alpha = 0;
		//Actuate.tween (myImage, 30, {alpha : 1});
		
		addChild (myImage);
		
 		circle = new Sprite();
 		hercle = new Sprite();
				
 		//hercle.x = 0;
 		//hercle.y = 0;
		
 		hercle.graphics.beginFill(0xff0000);
 		hercle.graphics.drawCircle(0, 0, 50);
		
 		//circle.x = 400;
 		//circle.y = 240;
		
 		circle.graphics.beginFill(0xff0000);
 		circle.graphics.drawCircle(400, 240, 50);
		
 		addChild(circle);
 		addChild(hercle);
		
 		addEventListener(Event.ENTER_FRAME, onFrame);
 		
     	circle.addEventListener(MouseEvent.CLICK, circle_click); //мышь нажали - круг исчез
		
 	    hercle.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
     	hercle.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
 	}
	
 	public var FrameCount:Int = 0;

 	public function onMouseDown(e:MouseEvent):Void 
 	{
   		e.target.startDrag();
 	}

 	public function onMouseUp(e:MouseEvent):Void 
 	{
     	e.target.stopDrag();
 	}
	
 	public function circle_click(e:MouseEvent) //исчезание
 	{
 		circle.removeEventListener(MouseEvent.CLICK, circle_click);
 		trace('false');
 		circle.visible = false;
 		stage.addEventListener(MouseEvent.CLICK, stage_click);
 	}
	
 	public function stage_click(e:MouseEvent) //появление
 	{
 		if (e.target == circle) return;
 		stage.removeEventListener(MouseEvent.CLICK, stage_click);
 		trace('true');
 		circle.visible = true;
 		circle.addEventListener(MouseEvent.CLICK, circle_click);
 	}
	
 	public function onFrame(e:Event)
 	{
 		FrameCount++;
 		
 		for (i in 0 ... circles.length)
			{
		 		circles[i].x = circles[i].x + 5*Math.cos(FrameCount*cosarg[i]);
 				circles[i].y = circles[i].y + 5*Math.sin(FrameCount*sinarg[i]);
				
 				if (FrameCount % 5 == 0) circles[i].alpha = circles[i].alpha + 0.05;
				
			}

 		//trace(FrameCount);
			
		circle.x = 400 + 100*Math.cos(FrameCount*0.05);
 		circle.y = 240 + 100*Math.sin(FrameCount*0.05);
		
		
	
	
		//trace(circles.length);
		
		//myImage.x = 100*Math.cos(FrameCount*c*0.5);
 		//myImage.y = 100*Math.sin(FrameCount*d/2);
		
		//circles[3].x = 100*Math.cos(FrameCount*c*0.5);
 		//circles[3].y = 100*Math.sin(FrameCount*d/2);
		
		
		
 	}
	
 	public function new () 
 	{
 		super ();
 		addEventListener(Event.ADDED_TO_STAGE, added);	
 	}
	
 	function added(e)
 	{
 		removeEventListener(Event.ADDED_TO_STAGE, added);
 		stage.addEventListener(Event.RESIZE, resize);
  		#if ios
 		haxe.Timer.delay(init, 100);
  		#else
 		init();
 		#end		
 	}

 	public static function main()
 	{
 		Lib.current.stage.align = StageAlign.TOP_LEFT;
 		Lib.current.stage.scaleMode = StageScaleMode.NO_SCALE;
 		Lib.current.addChild(new Main());
 	}
}