package com.ictbram.timer {
	import feathers.controls.ScrollText;

	import starling.display.Stage;

	import flash.display.Stage;
	/**
	 * @author Bram Joris - ictbram.com
	 */
	public class ViewConstants {
		
		public static const VERSION:String ="1.0.4"; //versionNumber in app.xml
		public static const DEBUG:Boolean = false;
		
		public static var STAGE:flash.display.Stage;
		public static var STARLING_STAGE:starling.display.Stage;

		public static var MAIN:MainTimerICTBram;
		public static var STARLINGMAIN:StarlingMain;
		
		public static var zoomFactor:Number;
		
		public static var sScreenApp:String =  "appScreen";
		public static var sScreenSetting:String =  "settingsScreen";
		public static var sScreenInfo:String =  "infoScreen";
		
		public static var saveSettings:SaveSettings;
		
		public static var TRUE:String = "true";
		public static var FALSE:String = "false";
		
		public static var notifications:Notifications;
		public static var txtDebug:ScrollText;
		
		
		
	}
}