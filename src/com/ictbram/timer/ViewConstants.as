package com.ictbram.timer {
	import feathers.controls.ScrollText;

	import starling.display.Stage;

	import flash.display.Stage;
	/**
	 * Timer ICTBram
	 * Copyright (C) 2017 Bram Joris - ictbram.com 
	 * 
	 * This program is free software: you can redistribute it and/or modify
	 * it under the terms of the GNU General Public License as published by
	 * the Free Software Foundation, either version 3 of the License, or
	 * (at your option) any later version.

	 * This program is distributed in the hope that it will be useful,
	 * but WITHOUT ANY WARRANTY; without even the implied warranty of
	 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	 * GNU General Public License for more details.

	 * You should have received a copy of the GNU General Public License
	 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
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