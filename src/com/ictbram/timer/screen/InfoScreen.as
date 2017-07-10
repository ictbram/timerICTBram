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
	 
package com.ictbram.timer.screen {
	import feathers.controls.LayoutGroup;
	import feathers.controls.ScrollText;
	import feathers.layout.HorizontalAlign;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.VerticalAlign;
	import feathers.layout.VerticalLayout;

	import starling.display.Sprite;
	import starling.events.Event;

	import com.ictbram.timer.ViewConstants;

	public class InfoScreen extends Sprite {
		private var lblContainer:LayoutGroup;
		
		public function InfoScreen() {
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onStageReady);
		}

		private function onStageReady(event : Event) : void {
			var verticalLayout:VerticalLayout = new VerticalLayout();
			verticalLayout.horizontalAlign =  HorizontalAlign.CENTER;
			verticalLayout.verticalAlign = VerticalAlign.MIDDLE;
			verticalLayout.gap = 10;
			
			var verticalContainer:LayoutGroup = new LayoutGroup();
			verticalContainer.layout = verticalLayout;
			
			addChild(verticalContainer);
			
			var spacer:HorizontalLayout = new HorizontalLayout();
			spacer.padding = 20;
			
			var spacerContainer:LayoutGroup = new LayoutGroup();
			spacerContainer.layout = spacer;
			verticalContainer.addChild(spacerContainer);
			
			var horizontalLayout:HorizontalLayout = new HorizontalLayout();
			horizontalLayout.gap = 5;
			horizontalLayout.horizontalAlign =  HorizontalAlign.CENTER;
			horizontalLayout.verticalAlign = VerticalAlign.MIDDLE;
			
			lblContainer = new LayoutGroup();
			lblContainer.layout = horizontalLayout;
			lblContainer.width = ViewConstants.STARLING_STAGE.stageWidth;
			verticalContainer.addChild(lblContainer);
			
			
			var lblInfo:ScrollText = new ScrollText();
			lblInfo.text = "Timer app that alarms as much as possible\n\nmade with Adobe Air, the Starling framework and Feathers components\n\nby Bram Joris\nictbram.com \nVersion: ";
			lblInfo.text += ViewConstants.VERSION;
			lblContainer.addChild(lblInfo);
		}
		
		public function resize() : void {
			lblContainer.width = ViewConstants.STARLING_STAGE.stageWidth;
		}
	}
}