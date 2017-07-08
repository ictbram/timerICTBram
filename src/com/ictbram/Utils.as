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
	 
package com.ictbram {

	public class Utils {
		
		public static function calculateMaximumZoom() : Number {
			//plan voor maximum van hoogte en breedte te berekenen en de minste value teruggeven
			/*
			var maxWidth:int = ViewConstants.STAGE.stageWidth - ViewConstants.MIN_WIDTH_For_ZOOM;
			var maxHeight:int = ViewConstants.STAGE.stageHeight - ViewConstants.MIN_HEIGHT_For_ZOOM ;
			var maximumValue:int;
			var sizeAgainstMax:int;
			if(maxWidth<maxHeight){
				maximumValue = maxWidth;
				sizeAgainstMax = ViewConstants.MIN_WIDTH_For_ZOOM;
			}else{
				maximumValue = maxHeight;
				sizeAgainstMax = ViewConstants.MIN_HEIGHT_For_ZOOM;
			}
			
			
			var calculatedValue:int = (maximumValue / sizeAgainstMax)*100*1.3;//laatste is nog ne multiplier voor ietske groter
			
			//100 is dubbel zo groot
			return calculatedValue;
			 * */
			 return 5;
		}
	}
	
	
}