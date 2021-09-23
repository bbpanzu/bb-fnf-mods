package;
import flixel.*;

/**
 * ...
 * @author bbpanzu
 */
class End extends MusicBeatState
{

	public function new() 
	{
		super();
	}
	
	override function create() 
	{
		super.create();
		
		var bg:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image("doxxie/end"));
		add(bg);
		FlxG.sound.playMusic(Paths.music("music_guys_intro"));
		
		
	}
	
	
	override function update(elapsed:Float) 
	{
		super.update(elapsed);
		
		
		if (controls.ACCEPT){
		FlxG.sound.playMusic(Paths.music("freakyMenu"));
			FlxG.switchState(new StoryMenuState());
		}
	}
	
}