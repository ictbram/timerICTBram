package {
	import starling.core.Starling;
	import starling.utils.RectangleUtil;
	import starling.utils.ScaleMode;

	import com.demonsters.debugger.MonsterDebugger;
	import com.ictbram.timer.SaveSettings;
	import com.ictbram.timer.StarlingMain;
	import com.ictbram.timer.ViewConstants;

	import flash.desktop.NativeApplication;
	import flash.desktop.SystemIdleMode;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	import flash.display3D.Context3DProfile;
	import flash.display3D.Context3DRenderMode;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.utils.setTimeout;

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
	 
	[SWF(frameRate="60", backgroundColor="#4a4137")]
	public class MainTimerICTBram extends Sprite {
		[Embed(source = './data/loadingIcon.png')] private var SplashPNG:Class;
		public var splash;

		private var starling : Starling;
		
		public function MainTimerICTBram() {
			if(ViewConstants.DEBUG){
				MonsterDebugger.initialize(this);
			}		
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStage);
			//Multitouch.inputMode = MultitouchInputMode.GESTURE;
			
		}
		
		private function addedToStage(event : Event) : void {
			MonsterDebugger.trace(this,"addedToStage");
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			ViewConstants.STAGE = stage;	
			ViewConstants.MAIN = this;
			
			splash = new SplashPNG();
			splash.x = (stage.stageWidth -splash.width)/2;
			splash.y = (stage.stageHeight -splash.height)/2;
			addChild(splash);
			
			stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
			
			ViewConstants.saveSettings= new SaveSettings();
			
			if(ViewConstants.saveSettings.screenOn == ViewConstants.TRUE){
				NativeApplication.nativeApplication.systemIdleMode = SystemIdleMode.KEEP_AWAKE;
			}
			
			
			
			//ViewConstants.saveSettings.scale =  getDefaultZoom();
			//ViewConstants.saveSettings.vibrate = ViewConstants.TRUE;
			//ViewConstants.saveSettings.sound = ViewConstants.TRUE;
			//ViewConstants.saveSettings.screenOn = ViewConstants.TRUE;
			//ViewConstants.saveSettings.lastTotalSeconds = 0;
			//ViewConstants.saveSettings.startTime = 0;
			
			loaderInfo.addEventListener(Event.COMPLETE, onLoadComplete);
		}

		private function onLoadComplete(event : Event) : void {
			// 
			setTimeout(delayedInit, 1000);
			
		}

		private function delayedInit() : void {
			//hier loaderimg  weggepakt, eventueel hier terugzetten bij problemen
			starlingStartWithResize();
			stage.addEventListener(Event.RESIZE, onStageResize);
		}
		
		public function onStageResize(event : Event = null) : void {
			var stageWidth:int =  stage.stageWidth/ViewConstants.saveSettings.scale;
			var stageHeight:int  =  stage.stageHeight/ViewConstants.saveSettings.scale;
			
			starling.stage.stageWidth =  stageWidth;
			starling.stage.stageHeight =  stageHeight;
			 
			var viewPort:Rectangle = RectangleUtil.fit(
			    new Rectangle(0, 0, stageWidth, stageHeight),
			    new Rectangle(0, 0, stage.fullScreenWidth, stage.fullScreenHeight),
			    ScaleMode.SHOW_ALL);
				
			starling.viewPort = viewPort;
			
			
			if(ViewConstants.STARLINGMAIN){
				ViewConstants.STARLINGMAIN.resize();
			}

		}
		
		private function starlingStartWithResize():void{
			MonsterDebugger.trace(this, "starlingStartWithResize");
			
			var stageWidth:int =  stage.stageWidth/ViewConstants.saveSettings.scale;
			var stageHeight:int  =  stage.stageHeight/ViewConstants.saveSettings.scale;
			
			var viewPort:Rectangle = RectangleUtil.fit(
			    new Rectangle(0, 0, stageWidth, stageHeight),
			    new Rectangle(0, 0, stage.fullScreenWidth, stage.fullScreenHeight),
			    ScaleMode.SHOW_ALL);
			
			starling = new Starling(StarlingMain, this.stage, viewPort, null, Context3DRenderMode.AUTO, Context3DProfile.BASELINE);
			starling.stage.stageWidth  = stageWidth;  		
			starling.stage.stageHeight = stageHeight; 
			
			ViewConstants.STARLING_STAGE = starling.stage;
			starling.supportHighResolutions = true;
			
			starling.start();
			ViewConstants.STARLING_STAGE = starling.stage;
		}
		
		public function removeSplash():void{
			removeChild(splash);
		}
		
		public function getDefaultZoom():int{
			var scale:int = 3;
			if (ViewConstants.STAGE.stageWidth < 600 || ViewConstants.STAGE.stageHeight < 873){
				scale = 2;
			}
			
			if (ViewConstants.STAGE.stageWidth < 400 || ViewConstants.STAGE.stageHeight < 584){
				scale = 1;
			}
			
			return scale;
		}
		
		
	}
}