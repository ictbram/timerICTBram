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
	 
package com.ictbram.timer {
	import com.demonsters.debugger.MonsterDebugger;
	import com.levelxgames.flixelx.data.FlxSaveWrapper;

	 
	public class SaveSettings {
		private const SAVE_NAME:String = "com.ictbram.timer";
		private var save : FlxSaveWrapper;
		
		public function SaveSettings(){
			save = new FlxSaveWrapper();
			save.init(SAVE_NAME, defaults);
		}
		
		public function defaults():void
		{
			MonsterDebugger.trace(this, "DEFAULTS");

			vibrate = ViewConstants.TRUE;
			sound = ViewConstants.TRUE;
			screenOn = ViewConstants.TRUE;
			lastTotalSeconds = 0;
			startTime = 0;
			scale = ViewConstants.MAIN.getDefaultZoom(); 
		}
		
		public function get startTime():Number{
			return Number(save.data.startTime);
		}
		
		public function set startTime(m:Number):void
		{
			save.data.startTime = m;
			save.updateLocalCopy();
		}
		
		public function get lastTotalSeconds():int
		{
			return int(save.data.lastTotalSeconds);
		}

		public function set lastTotalSeconds(m:int):void
		{
			save.data.lastTotalSeconds = m;
			save.updateLocalCopy();
		}
		
		public function get screenOn():String
		{
			return String(save.data.screenOn);
		}

		public function set screenOn(m:String):void
		{
			save.data.screenOn = String(m);
			save.updateLocalCopy();
		}
		
		public function get vibrate():String
		{
			return String(save.data.vibrate);
		}

		public function set vibrate(m:String):void
		{
			save.data.vibrate = String(m);
			save.updateLocalCopy();
		}
		
		public function get sound():String
		{
			return String(save.data.sound);
		}

		public function set sound(m:String):void
		{
			save.data.sound = String(m);
			save.updateLocalCopy();
		}
		
		
		public function get scale() : Number {
			return save.data.scale;
		}

		public function set scale(scale : Number) : void {
			save.data.scale = scale;
			save.updateLocalCopy();
		}
	}
	
	
}