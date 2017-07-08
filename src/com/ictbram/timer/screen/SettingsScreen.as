package com.ictbram.timer.screen {
	import feathers.controls.Button;
	import feathers.controls.Check;
	import feathers.controls.Label;
	import feathers.controls.LayoutGroup;
	import feathers.controls.Slider;
	import feathers.layout.HorizontalAlign;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.VerticalAlign;
	import feathers.layout.VerticalLayout;

	import starling.display.Sprite;
	import starling.events.Event;

	import com.demonsters.debugger.MonsterDebugger;
	import com.ictbram.Utils;
	import com.ictbram.timer.ViewConstants;

	import flash.desktop.NativeApplication;
	import flash.desktop.SystemIdleMode;

	/**
	 * @author Bram Joris - ictbram.com
	 */
	public class SettingsScreen extends Sprite {
		
		private var checkVibrate:Check;
		private var checkSound:Check;
		private var checkScreenOn:Check;
			
		private var sliderZoom:Slider;
		private var resizeBtn:Button ;
		private var lblZoom:Label;
		private var lblZoomValue:Label;
		
		private var sliderContainer:LayoutGroup;
		private var resizeBtnContainer:LayoutGroup;
		private var lblContainer : LayoutGroup;
		private var lblContainer2:LayoutGroup;
		private var lblContainer3:LayoutGroup;
		
		
		public function SettingsScreen() {
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onStageReady);
		}

		private function onStageReady(event : starling.events.Event) : void {
			
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
			//spacer.addchild
			verticalContainer.addChild(spacerContainer);
			
			var horizontalLayout:HorizontalLayout = new HorizontalLayout();
			horizontalLayout.gap = 5;
			horizontalLayout.horizontalAlign =  HorizontalAlign.CENTER;
			horizontalLayout.verticalAlign = VerticalAlign.MIDDLE;
			
			
			sliderContainer = new LayoutGroup();
			sliderContainer.layout = horizontalLayout;
			sliderContainer.width = ViewConstants.STARLING_STAGE.stageWidth;
			verticalContainer.addChild(sliderContainer);
			
			
			//eerst nog slider
			sliderZoom = new Slider();
			lblZoom = new Label;
			lblZoom.paddingTop = 5;
			lblZoom.text = "Zoom";
			
			lblZoomValue = new Label;
			lblZoomValue.paddingTop = 5;
			lblZoomValue.text = "" + ViewConstants.saveSettings.scale ;

			//waarden worden naargelang ingesteld, 100 is dubbel zo groot
			sliderZoom.minimum = 1;
			
			//resizen nog sliderZoom.width = sliderZoom.width /2;
			
			sliderZoom.maximum = Utils.calculateMaximumZoom();
			
			sliderZoom.value = ViewConstants.saveSettings.scale;

			sliderZoom.addEventListener(Event.CHANGE, slider_changeHandler);

			sliderContainer.addChild(lblZoom);
			sliderContainer.addChild(sliderZoom);
			sliderContainer.addChild(lblZoomValue);

			resizeBtnContainer = new LayoutGroup();
			resizeBtnContainer.layout = horizontalLayout;
			resizeBtnContainer.width = ViewConstants.STARLING_STAGE.stageWidth;
			verticalContainer.addChild(resizeBtnContainer);
			
			//TODO mss nog showen en verbergen naargelang value veranderd is
			resizeBtn = new Button();
			resizeBtn.label = "apply";
			resizeBtn.visible = false;
			resizeBtnContainer.addChild(resizeBtn);

			resizeBtn.addEventListener(Event.TRIGGERED, resizeButton_triggeredHandler);

			lblContainer = new LayoutGroup();
			lblContainer.layout = horizontalLayout;
			lblContainer.width = ViewConstants.STARLING_STAGE.stageWidth;
			verticalContainer.addChild(lblContainer);
			
			var lblCheckSound:Label = new Label();
			lblCheckSound.text = "Sound";
			lblContainer.addChild(lblCheckSound);
			checkSound = new Check();
			lblContainer.addChild(checkSound);
			
			lblContainer2 = new LayoutGroup();
			lblContainer2.layout = horizontalLayout;
			lblContainer2.width = ViewConstants.STARLING_STAGE.stageWidth;
			verticalContainer.addChild(lblContainer2);
			 
			var lblCheckVibrate:Label = new Label();
			lblCheckVibrate.text = "Vibrate";
			lblContainer2.addChild(lblCheckVibrate);
			checkVibrate = new Check();
			lblContainer2.addChild(checkVibrate);
			
			lblContainer3 = new LayoutGroup();
			lblContainer3.layout = horizontalLayout;
			lblContainer3.width = ViewConstants.STARLING_STAGE.stageWidth;
			verticalContainer.addChild(lblContainer3);
			 
			var lblCheckScreenOn:Label = new Label();
			lblCheckScreenOn.text = "Screen always on";
			lblContainer3.addChild(lblCheckScreenOn);
			checkScreenOn = new Check();
			lblContainer3.addChild(checkScreenOn);

			MonsterDebugger.trace(this + "ViewConstants.saveSettings.sound", ViewConstants.saveSettings.sound);
			MonsterDebugger.trace(this + "ViewConstants.saveSettings.vibrate", ViewConstants.saveSettings.vibrate);
			
			checkSound.isSelected = convertValueToBool(ViewConstants.saveSettings.sound);
			checkVibrate.isSelected = convertValueToBool(ViewConstants.saveSettings.vibrate);
			checkScreenOn.isSelected = convertValueToBool(ViewConstants.saveSettings.screenOn);
			
			
			checkSound.addEventListener(Event.CHANGE, toggle_changeHandler);
			checkVibrate.addEventListener(Event.CHANGE, toggle_changeHandler);
			checkScreenOn.addEventListener(Event.CHANGE, toggle_changeHandlerScreen);

			MonsterDebugger.trace("checkVibrate.isSelected", checkVibrate.isSelected);
		}

		private function toggle_changeHandlerScreen(event : Event) : void {
			if(checkScreenOn.isSelected){
				ViewConstants.saveSettings.screenOn = ViewConstants.TRUE;
				NativeApplication.nativeApplication.systemIdleMode = SystemIdleMode.KEEP_AWAKE;  
			}else{
				ViewConstants.saveSettings.screenOn = ViewConstants.FALSE;
				NativeApplication.nativeApplication.systemIdleMode = SystemIdleMode.NORMAL;  
			}
			
		}
		
		public function resize() : void {
			sliderContainer.width = ViewConstants.STARLING_STAGE.stageWidth;
			resizeBtnContainer.width = ViewConstants.STARLING_STAGE.stageWidth;
			lblContainer.width = ViewConstants.STARLING_STAGE.stageWidth;
			lblContainer2.width = ViewConstants.STARLING_STAGE.stageWidth;
			lblContainer3.width = ViewConstants.STARLING_STAGE.stageWidth;
		}

		private function resizeButton_triggeredHandler(event : Event) : void {
			ViewConstants.saveSettings.scale = int(sliderZoom.value);
			ViewConstants.MAIN.onStageResize();
			resizeBtn.visible = false;
		}

		private function slider_changeHandler(event : Event) : void {
			var sliderVal:int = int(sliderZoom.value);
			
			if(sliderVal==ViewConstants.saveSettings.scale){
				resizeBtn.visible = false;
			}else{
				resizeBtn.visible = true;
			}
			
			lblZoomValue.text = String(sliderVal);
			
		}

		private function toggle_changeHandler(event : Event) : void {
			MonsterDebugger.trace(this, "toggle_changeHandler");			
			
			var check:Check = Check( event.currentTarget );
			
			if(checkBothNotSelected()){
				switch(check){
					case checkSound:
						checkVibrate.isSelected = true;
						break;
					case checkVibrate:
						checkSound.isSelected = true;
						break;
				}
			}
			

    		MonsterDebugger.trace( "toggle.isSelected has changed:", check.isSelected );

			saveValues();
		}

		private function saveValues() : void {
			ViewConstants.saveSettings.sound = convertValue(checkSound.isSelected);
			ViewConstants.saveSettings.vibrate = convertValue(checkVibrate.isSelected);
		}
		
		public static function convertValue(bool:Boolean):String{
			if (bool)return ViewConstants.TRUE;
			else return ViewConstants.FALSE;
		}
		
		public static function convertValueToBool(bool:String):Boolean{
			if (bool == ViewConstants.TRUE)return true;
			else return false;
		}
		
		private function checkBothNotSelected():Boolean{
			if (checkSound.isSelected == false && checkVibrate.isSelected == false){
				return true;
			}else{
				return false;
			}
		}
	}
}