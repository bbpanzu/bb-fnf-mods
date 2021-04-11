package;
import flixel.*;

/**
 * ...
 * @author bbpanzu
 */
class WarningState extends MusicBeatState
{

	public function new() 
	{
		super();
	}
	override function create() 
	{
		super.create();
		
		var bg:FlxSprite = new FlxSprite();
		
		bg.loadGraphic(Paths.image("warning"));
		add(bg);
		
		
	}
	
	
	override function update(elapsed:Float) 
	{
		super.update(elapsed);
		
		
		if (controls.ACCEPT){
			PlayState.sez = true;
			FlxG.switchState(new MainMenuState());
		}
		if (controls.BACK){
			PlayState.sez = false;
			FlxG.switchState(new MainMenuState());
		}
		
		
	}
}