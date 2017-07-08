package com.ictbram {
	/**
	 * @author Bram Joris - ictbram.com
	 */
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