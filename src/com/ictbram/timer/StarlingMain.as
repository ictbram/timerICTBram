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
	import feathers.controls.LayoutGroup;
	import feathers.controls.TabBar;
	import feathers.data.ListCollection;
	import feathers.layout.HorizontalAlign;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.VerticalAlign;
	import feathers.themes.MetalWorksMobileTheme;

	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.AssetManager;

	import com.demonsters.debugger.MonsterDebugger;
	import com.ictbram.timer.screen.InfoScreen;
	import com.ictbram.timer.screen.SettingsScreen;
	import com.ictbram.timer.screen.TimerAppScreen;

	public class StarlingMain extends Sprite {
		public var assets:AssetManager = new AssetManager();
		private var appScreen:TimerAppScreen;
		private var settingsScreen:SettingsScreen;
		private var infoScreen:InfoScreen;
		
		private var tabContainer:LayoutGroup;
		
		public function StarlingMain() {
			ViewConstants.STARLINGMAIN = this;
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onStageReady);
		}
		
		public function initDelayed() : void {
			assets.enqueue(EmbeddedAssets);
			assets.loadQueue(function(ratio:Number):void
			 {
			    MonsterDebugger.trace("Loading assets, progress:", ratio); //track the progress with this ratio
				if (ratio == 1.0)
					initApp();
			});	
		}

		private function initApp() : void {
			var horizontalLayout:HorizontalLayout = new HorizontalLayout();
			horizontalLayout.gap = 5;
			horizontalLayout.horizontalAlign =  HorizontalAlign.CENTER;
			horizontalLayout.verticalAlign = VerticalAlign.MIDDLE;
			
			tabContainer = new LayoutGroup();
			tabContainer.layout = horizontalLayout;
			tabContainer.width = ViewConstants.STARLING_STAGE.stageWidth;
			
			addChild(tabContainer);
			
			var tabs:TabBar = new TabBar();
			tabs.dataProvider = new ListCollection(
			[
			    { label: "Timer" },
			    { label: "Settings" },
			    { label: "Info" },
			]);
			this.addChild( tabs);

			tabs.addEventListener(Event.CHANGE, tabs_changeHandler);

			tabContainer.addChild(tabs);
			
			appScreen = new TimerAppScreen();
			addChild(appScreen);
			
			settingsScreen = new SettingsScreen();
			addChild(settingsScreen);
			settingsScreen.visible = false;
			
			infoScreen = new InfoScreen();
			addChild(infoScreen);
			infoScreen.visible = false;
		}
		
		public function resize(event = null) : void {
			if(appScreen!=null){
				tabContainer.width = ViewConstants.STARLING_STAGE.stageWidth;
				appScreen.resize();
				settingsScreen.resize();
				infoScreen.resize();
			}
		}

		private function tabs_changeHandler(event : Event) : void {
			var tabs:TabBar = TabBar( event.currentTarget );
			
			var screen:Sprite;
   			switch(tabs.selectedIndex){
				case 0:
					screen = appScreen;					
					break;
				case 1:
					screen = settingsScreen;
					break;
				case 2:
					screen =infoScreen;
					break;
			}
			
			appScreen.visible =false;
			settingsScreen.visible =false;
			infoScreen.visible =false;
			
			screen.visible = true;
			
			MonsterDebugger.trace(this, "tabs_changeHandler id: "+ tabs.selectedIndex + " screen:"+ screen);	
		}
		
		public function switchToApp(){
			appScreen.visible =true;
			settingsScreen.visible =false;
			infoScreen.visible =false;
		}
		
		private function onStageReady(event: starling.events.Event ) : void {
			new MetalWorksMobileTheme();
			MonsterDebugger.trace(this, "onStageReady");
			ViewConstants.STARLINGMAIN.initDelayed();
		}
	}
	
}