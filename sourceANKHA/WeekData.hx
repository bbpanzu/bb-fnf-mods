package;

class WeekData {
	//Song names, used on both Story Mode and Freplay
	//Go to FreeplayState.hx and add the head icons
	//Go to StoryMenuState.hx and add the characters/backgrounds
	public static var songsNames:Array<Dynamic> = [
		['Camel'],
	];

	// Custom week number, used for your week's score not being overwritten by a new vanilla week when the game updates
	// I'd recommend setting your week as -99 or something that new vanilla weeks will probably never ever use
	// null = Don't change week number, it follows the vanilla weeks number order
	public static var weekNumber:Array<Dynamic> = [
		null,
	];

	//Tells which assets directory should it load
	//Reminder that you have to add the directories on Project.xml too or they won't be compiled!!!
	//Just copy week6/week6_high mentions and rename it to whatever your week will be named
	//It ain't that hard, i guess

	//Oh yeah, quick reminder that files inside the folder that ends with _high are only loaded
	//if you have the Low Quality option disabled on "Preferences"
	public static var loadDirectory:Array<String> = [
		'Camel',
	];

	//The only use for this is to display a different name for the Week when you're on the score reset menu.
	//Set it to null to make the Week be automatically called "Week (Number)"

	//Edit: This now also messes with Discord Rich Presence, so it's kind of relevant.
	public static var weekResetName:Array<String> = [
		"Ankha",
	];


	//   FUNCTIONS YOU WILL PROBABLY NEVER NEED TO USE

	//To use on PlayState.hx or Highscore stuff
	public static function getCurrentWeekNumber():Int {
		return getWeekNumber(PlayState.storyWeek);
	}

	public static function getWeekNumber(num:Int):Int {
		var value:Int = 0;
		if(num < weekNumber.length) {
			value = num;
			if(weekNumber[num] != null) {
				value = weekNumber[num];
				//trace('Cur value: ' + value);
			}
		}
		return value;
	}

	//Used on LoadingState, nothing really too relevant
	public static function getWeekDirectory():String {
		var value:String = loadDirectory[PlayState.storyWeek];
		if(value == null) {
			value = "week" + getCurrentWeekNumber();
		}
		return value;
	}
}