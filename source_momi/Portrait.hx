package;

import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.animation.FlxBaseAnimation;
import flixel.graphics.frames.FlxAtlasFrames;

using StringTools;

class Portrait extends FlxSprite
{

    private var refx:Float;
    private var refy:Float;

    private var resize = 0.35;

    private var characters:Array<String> = ["bf", "gf", "dad", "spooky", "monster", "pico", "darnell", "nene", 'mom', 'imps'];

    var posTween:FlxTween;
    var alphaTween:FlxTween;
	
    public function new(_x:Float, _y:Float){

        super(_x, _y);

        defineCharacter();
       // setGraphicSize(Std.int(width * resize));
        updateHitbox();
        scrollFactor.set();
        antialiasing = true;

        refx = x;
        refy = y + height;

        playFrame();
        posTween = FlxTween.tween(this, {x: x}, 0.1);
        alphaTween = FlxTween.tween(this, {alpha: alpha}, 0.1);
        hide();

    }

    function defineCharacter(){

       // _character = characters.contains(_character) ? _character : "bf";

        frames = Paths.getSparrowAtlas("port");

                addAnim("bf", 1);
                addAnim("momi", 0);
                addAnim("gf", 2);
                addAnim("pico", 3);
                addAnim("nekomomi", 4);

     

    }
    
    function addAnim(anim:String, ind:Int){
        animation.addByIndices(anim,"port",[ind],"", 0, false);
    }    

    public function playFrame(?_frame:String = "default"){

        visible = true;

        animation.play(_frame);
        flipX = false;
        updateHitbox();

        x = refx;
        y = refy - height;

    }

    public function hide(){

        alphaTween.cancel();
        posTween.cancel();
        alpha = 1;
        visible = false;

    }

    public function effectFadeOut(?time:Float = 1){

        alphaTween.cancel();
        alpha = 1;
        alphaTween = FlxTween.tween(this, {alpha: 0}, time);

    }

    public function effectFadeIn(?time:Float = 1){

        alphaTween.cancel();
        alpha = 0;
        alphaTween = FlxTween.tween(this, {alpha: 1}, time);

    }

    public function effectExitStageLeft(?time:Float = 1){

        posTween.cancel();
        posTween = FlxTween.tween(this, {x: 0 - width}, time, {ease: FlxEase.circIn});

    }

    public function effectExitStageRight(?time:Float = 1){

        posTween.cancel();
        posTween = FlxTween.tween(this, {x: FlxG.width}, time, {ease: FlxEase.circIn});

    }

    public function effectFlipRight(){

        x = FlxG.width - refx - width;
        y = refy - height;

    }

    public function effectFlipDirection(){
        
        flipX = true;

    }

    public function effectEnterStageLeft(?time:Float = 1){
        
        posTween.cancel();
        var finalX = x;
        x = 0 - width;
        posTween = FlxTween.tween(this, {x: finalX}, time, {ease: FlxEase.circOut});

    }

    public function effectEnterStageRight(?time:Float = 1){
        
        posTween.cancel();
        var finalX = x;
        x = FlxG.width;
        posTween = FlxTween.tween(this, {x: finalX}, time, {ease: FlxEase.circOut});
    }

    public function effectToRight(?time:Float = 1){
        
        posTween.cancel();
        var finalX = FlxG.width - refx - width;
        x = refx;
        y = refy - height;
        posTween = FlxTween.tween(this, {x: finalX}, time, {ease: FlxEase.quintOut});
    }

    public function effectToLeft(?time:Float = 1){
        
        posTween.cancel();
        var finalX = refx;
        x = FlxG.width - refx - width;
        y = refy - height;
        posTween = FlxTween.tween(this, {x: finalX}, time, {ease: FlxEase.quintOut});
    }

   
}
