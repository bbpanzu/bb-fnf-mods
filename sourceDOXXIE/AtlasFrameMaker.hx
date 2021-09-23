package;
import openfl.display.PixelSnapping;
import openfl.display.Bitmap;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import sys.io.File;

import openfl.Assets;
import haxe.Json;
import openfl.display.BitmapData;
import animateatlas.JSONData.AtlasData;
import animateatlas.JSONData.AnimationData;
import animateatlas.displayobject.SpriteAnimationLibrary;
import animateatlas.displayobject.SpriteMovieClip;
import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxFramesCollection;
import flixel.graphics.frames.FlxFrame;
class AtlasFrameMaker extends FlxFramesCollection{


        public static var widthoffset:Int = 0;
        public static var heightoffset:Int = 0;
        public static var excludeArray:Array<String>;
        /**
		Turns all TextureAtlas frames into bitmaps, to give it directly to the braindead Flixel animation system.(THIS IS AN EARLY EARLY EARLY SUPER FUCKING EARLY BUILD MORE SHIT AND FIXES SOON!)
                This is early as shit im just sayin!

	
	**/

        public static function construct(key:String,_widthoffset:Int = 0,_heightoffset:Int = 0,_excludeArray:Array<String> = null):FlxFramesCollection{

                widthoffset = _widthoffset;
                heightoffset = _heightoffset;
                if(_excludeArray == null){
                _excludeArray = [];
                }
                excludeArray = _excludeArray;

                var frameCollection:FlxFramesCollection;
                var frameArray:Array<Array<FlxFrame>> = [];
				#if desktop
                var animationData:AnimationData = Json.parse(File.getContent(key + "/Animation.json"));
                var atlasData:AtlasData = Json.parse(File.getContent(key + "/spritemap.json"));
                var bitmapData:BitmapData = BitmapData.fromFile(key + "/spritemap.png");
				
				#else
                var animationData:AnimationData = Json.parse(Assets.getText(key + "/Animation.json"));
                var atlasData:AtlasData = Json.parse(Assets.getText(key + "/spritemap.json"));
                var bitmapData:BitmapData = Assets.getBitmapData(key + "/spritemap.png");
				
				
				
				
				#end
                var ss = new SpriteAnimationLibrary(animationData, atlasData, bitmapData);
                var t = ss.createAnimation();
                frameCollection = new FlxFramesCollection(FlxGraphic.fromBitmapData(bitmapData),FlxFrameCollectionType.IMAGE);

                
                for(x in t.getFrameLabels()){

                        frameArray.push(getFramesArray(t, x));


                }

                for(x in frameArray){
                        for(y in x){
                                frameCollection.pushFrame(y);
                        }
                }

                
                return frameCollection;

        }

        static function getFramesArray(t:SpriteMovieClip,animation:String):Array<FlxFrame>
        {
                t.currentLabel = animation;
                var bitMapArray:Array<BitmapData> = [];
                var daFramez:Array<FlxFrame> = [];
                var firstPass = true;
                var frameSize:FlxPoint = new FlxPoint(0,0);
                trace('Excluding frames: ' + excludeArray);

                

                for (i in 0...t.numFrames){
                        t.currentFrame = i;
                        if (t.currentLabel == animation){
                                if (!excludeArray.contains(animation)){
                                        //trace('creating frames for: ' + animation);
                                        var bitmapShit:BitmapData = new BitmapData(Std.int(t.width + widthoffset),Std.int(t.height + heightoffset),true,0);
                                        bitmapShit.draw(t, null, null, null, null, true);
                                        bitMapArray.push(bitmapShit);
                                        if (firstPass){
                                        frameSize.set(bitmapShit.width - widthoffset,bitmapShit.height - heightoffset);
                                        firstPass = false;
                                        }
                                }
                        }
                }
                //trace(bitMapArray);

                for (i in 0...bitMapArray.length){
                        var theFrame = new FlxFrame(FlxGraphic.fromBitmapData(bitMapArray[i]));
                        theFrame.parent = FlxGraphic.fromBitmapData(bitMapArray[i]);
                        theFrame.name = animation + i;
                        theFrame.sourceSize.set(frameSize.x,frameSize.y);
                        theFrame.frame = new FlxRect(0, 0, bitMapArray[i].width, bitMapArray[i].height);
                        theFrame.offset.x = 0;
                        theFrame.offset.y = 0;
                        daFramez.push(theFrame);
                        
                        //trace(daFramez);
                }

                return daFramez;
        }

        /*public static function renderTest(key:String, animation:String, ?frame:Int = 0):Void
        {
                var animationData:AnimationData = Json.parse(Assets.getText(key + "/Animation.json"));
                var atlasData:AtlasData = Json.parse(Assets.getText(key + "/spritemap.json"));
                var bitmapData:BitmapData = Assets.getBitmapData(key + "/spritemap.png");
                var ss = new SpriteAnimationLibrary(animationData, atlasData, bitmapData);
                var t = ss.createAnimation();
                var bitMapArray:Array<BitmapData> = [];

                for (i in 0...t.numFrames){
                        t.currentFrame = i;
                        if (t.currentLabel == animation){
                        //trace(t.currentFrame);
                        var bitmapShit:BitmapData = new BitmapData(Std.int(t.width),Std.int(t.height),true,0);
                        //bitmapShit.drawWithQuality(t,null,null,null,null,true);
                        bitmapShit.draw(t, new Matrix(1, 0, 0, 1, t.width/2, t.height/2), null, null, null, false);
                        bitMapArray.push(bitmapShit);
                        }
                }

                saveImage(bitMapArray[frame]);

        }

        public static function saveImage(bitmapData:BitmapData)
        {
                var b:ByteArray = new ByteArray();
                b = bitmapData.encode(bitmapData.rect, new PNGEncoderOptions(true), b);
                new FileDialog().save(b, "png", null, "file");
        }
        */
        

}
