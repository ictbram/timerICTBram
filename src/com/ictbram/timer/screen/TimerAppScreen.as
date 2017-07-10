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
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.LayoutGroup;
	import feathers.controls.ScrollContainer;
	import feathers.controls.ScrollText;
	import feathers.controls.SpinnerList;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.data.ListCollection;
	import feathers.layout.HorizontalAlign;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.VerticalAlign;
	import feathers.layout.VerticalLayout;

	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	import utility.DurationTimer;

	import com.adobe.nativeExtensions.Vibration;
	import com.demonsters.debugger.MonsterDebugger;
	import com.ictbram.timer.Notifications;
	import com.ictbram.timer.ViewConstants;
	import com.ictbram.timer.entity.Sound;

	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	 
	public class TimerAppScreen extends Sprite {
		
		private var lblContainer:LayoutGroup;
		private var btnContainer:ScrollContainer;
		
		private var startBtn:Button;
		private var resetBtn:Button;
		private var secSpinnerlist: SpinnerList;
		private var sec10talSpinnerlist: SpinnerList;
		private var minSpinnerlist: SpinnerList;
		private var min10talSpinnerlist: SpinnerList;
		
		private var lblSec:Label;
		private var lblSec10tal:Label;
		private var lblMin:Label;
		private var lblMin10tal:Label;
		private var lblDubbelpunt:Label;
			
		private var buttonContainer2:LayoutGroup;
		private var buttonContainer3:LayoutGroup;
		
	
		private var totalSeconds:int;
		
		private var minutes:int;
		private var seconds:int;
		
		private var durationTimer:DurationTimer;
		
		private var running:Boolean = false;
		
		private var soundIntervalID:int;
		private var vibrateIntervalID:int;
		
		private var boxAni:MovieClip;
		private var cirkeltjesAni:MovieClip;
		
		private var startPoint:Point;
		
		public var txtDebug:ScrollText;
			
		public function TimerAppScreen() {
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onStageReady);		
		}

		private function onStageReady(event : starling.events.Event) : void {
			
			boxAni = new MovieClip(ViewConstants.STARLINGMAIN.assets.getTextures("box"), 30);
			cirkeltjesAni  = new MovieClip(ViewConstants.STARLINGMAIN.assets.getTextures("cirkeltjes"), 30);
			
			ViewConstants.MAIN.removeSplash();
			
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
		
			lblMin10tal = new Label();
			lblMin10tal.text = " m ";
			lblContainer.addChild(lblMin10tal);
		
			lblMin = new Label();
			lblMin.text = " m ";
			lblContainer.addChild(lblMin);
			
			lblDubbelpunt = new Label();
			lblDubbelpunt.text = " : ";
			lblContainer.addChild(lblDubbelpunt);
			
			lblSec10tal = new Label();
			lblSec10tal.text = " s ";
			lblContainer.addChild(lblSec10tal);
		
			lblSec = new Label();
			lblSec.text = " s ";
			lblContainer.addChild(lblSec);
			
			verticalContainer.addChild(lblContainer);

			btnContainer = new ScrollContainer();
			btnContainer.layout = horizontalLayout;
			
			verticalContainer.addChild(btnContainer);
			
			btnContainer.width = ViewConstants.STARLING_STAGE.stageWidth;
			
			var labelsTot6:ListCollection = new ListCollection();
			for (var i : int = 0; i < 6; i++) {
				labelsTot6.addItem({text:String(i)});
			}
			
			var labels:ListCollection = new ListCollection();
			for (var i : int = 0; i < 10; i++) {
				labels.addItem({text:String(i)});
			}
			
			min10talSpinnerlist = new SpinnerList();
			min10talSpinnerlist.dataProvider = labels;
			
			//imem rendere setup
			min10talSpinnerlist.itemRendererFactory = function():IListItemRenderer
			{
			    var itemRenderer:DefaultListItemRenderer = new DefaultListItemRenderer();
			    itemRenderer.labelField = "text";
			    itemRenderer.iconSourceField = "thumbnail";
			    return itemRenderer;
			};
			
			
			btnContainer.addChild(min10talSpinnerlist);
			
			minSpinnerlist = new SpinnerList();
			minSpinnerlist.dataProvider = labels;
			
			//imem rendere setup
			minSpinnerlist.itemRendererFactory = function():IListItemRenderer
			{
			    var itemRenderer:DefaultListItemRenderer = new DefaultListItemRenderer();
			    itemRenderer.labelField = "text";
			    itemRenderer.iconSourceField = "thumbnail";
			    return itemRenderer;
			};
			
			
			btnContainer.addChild(minSpinnerlist);
			
			//TODO : er nog tussen of iet
			var labelDubbelpunt:Label = new Label();
			labelDubbelpunt.text = ":";
			btnContainer.addChild(labelDubbelpunt);
			
			
			sec10talSpinnerlist = new SpinnerList();
			sec10talSpinnerlist.dataProvider = labelsTot6;
			
			//imem rendere setup
			sec10talSpinnerlist.itemRendererFactory = function():IListItemRenderer
			{
			    var itemRenderer:DefaultListItemRenderer = new DefaultListItemRenderer();
			    itemRenderer.labelField = "text";
			    itemRenderer.iconSourceField = "thumbnail";
			    return itemRenderer;
			};
			
			
			btnContainer.addChild(sec10talSpinnerlist);
			
			secSpinnerlist = new SpinnerList();
			secSpinnerlist.dataProvider = labels;
			
			//imem rendere setup
			secSpinnerlist.itemRendererFactory = function():IListItemRenderer
			{
			    var itemRenderer:DefaultListItemRenderer = new DefaultListItemRenderer();
			    itemRenderer.labelField = "text";
			    itemRenderer.iconSourceField = "thumbnail";
			    return itemRenderer;
			};
			
			btnContainer.addChild(secSpinnerlist);
			
			startBtn = new Button();
			resetBtn = new Button();
			
			
			//skin btn
			//startBtn.styleProvider = null; //no theme!
		
			//startBtn.fontStyles = new TextFormat( "_sans", 20, 0x4c4c4c );
			//startBtn.defaultSkin = new Quad( 100, 30, 0xcccccc );
			//startBtn.padding = 10;
			
			//startBtn.width
			
			startBtn.label = "Start";
			//startBtn.x = (this.stage.stageWidth - startBtn.width) / 2;
			//startBtn.y = (this.stage.stageHeight - startBtn.height) / 2;
			
			buttonContainer2 = new LayoutGroup();
			buttonContainer2.layout = horizontalLayout;
			buttonContainer2.width = ViewConstants.STARLING_STAGE.stageWidth;

			verticalContainer.addChild(buttonContainer2);
			
			
			
			buttonContainer2.addChild(startBtn);
			
			buttonContainer3 = new LayoutGroup();
			buttonContainer3.layout = horizontalLayout;
			buttonContainer3.width = ViewConstants.STARLING_STAGE.stageWidth;
			verticalContainer.addChild(buttonContainer3);

			resetBtn.label = "Reset";
			buttonContainer3.addChild(resetBtn);
			resetBtn.visible = false;
			
			MonsterDebugger.trace(this, "initDelayed");

			startBtn.addEventListener(starling.events.Event.TRIGGERED, start_triggered);
			resetBtn.addEventListener(starling.events.Event.TRIGGERED, reset_triggered);

			setAniPos();
			
			addChild(boxAni);
			addChild(cirkeltjesAni);
			
			Starling.juggler.add(boxAni);
			Starling.juggler.add(cirkeltjesAni);
			boxAni.stop();
			cirkeltjesAni.stop();
			
			boxAni.visible = false;
			cirkeltjesAni.visible = false;
			
			

			cirkeltjesAni.addEventListener(TouchEvent.TOUCH, touchBox);

			MonsterDebugger.trace("starttime", ViewConstants.saveSettings.startTime);
			if(ViewConstants.saveSettings.startTime == 0){				
				setSpinners(ViewConstants.saveSettings.lastTotalSeconds);
			}else{
				resumeCountDown(ViewConstants.saveSettings.startTime, ViewConstants.saveSettings.lastTotalSeconds);
			}
			
			//ViewConstants.STAGE.addEventListener(TransformGestureEvent.GESTURE_SWIPE, onSwipe);
			
			txtDebug = new ScrollText();
			
			lblContainer.addChild(txtDebug);
			
			verticalContainer.addChild(txtDebug);
			ViewConstants.txtDebug = txtDebug;
			
			txtDebug.visible = ViewConstants.DEBUG;
			
			try{
				ViewConstants.notifications = new Notifications();
			}catch(error:Error){
				MonsterDebugger.trace(this, "error init notification: "+error.toString());	
				ViewConstants.txtDebug.text += "error init notification: "+error.toString(); 
			}
			//tmp 
		}
		
		private function setAniPos():void{
			var factor : Number = ViewConstants.STARLING_STAGE.width / boxAni.width;
			boxAni.width = ViewConstants.STARLING_STAGE.width;
			boxAni.height *= factor;
			
			cirkeltjesAni.width = ViewConstants.STARLING_STAGE.width;
			cirkeltjesAni.height *= factor;
			
		
			//boxAni.x = ViewConstants.STARLING_STAGE.width / 2;
			//boxAni.y = (ViewConstants.STARLING_STAGE.height) / 2;
			//cirkeltjesAni.y = boxAni.y;
		}
		
		private function resumeCountDown(fromTime:Number, seconds:int) : void {
			var currentTime:Number = new Date().time;
			var toTime:Number = fromTime + seconds*1000;
			MonsterDebugger.trace("resumeCountDown", "currentTime:"+currentTime + " toTime:"+toTime);
			if(toTime > currentTime) {
				//countdown door laten gaan
				var toSeconds:int = Math.round((toTime - currentTime)/1000);
				setSpinners(toSeconds);
				start_triggered();
			}else{
				//niet meer binnen de minuut, niet starten
				ViewConstants.saveSettings.startTime = 0;
			}
		}

		private function reset_triggered(event : starling.events.Event) : void {
			setSpinners(ViewConstants.saveSettings.lastTotalSeconds);
		}

		private function touchBox(e : TouchEvent) : void {
			var touch:Touch = e.getTouch(stage);
			//mss nog nen if ertussen ala if(e.currentTarget is C_card){
			var localPos:Point = touch.getLocation(boxAni);
			if(touch.phase == TouchPhase.BEGAN)
			{
				startPoint = localPos;
			}
			else if(touch.phase == TouchPhase.ENDED)
			{
				var distance:Number = Math.sqrt( ( localPos.x - startPoint.x ) * (localPos.x - startPoint.x ) + (localPos.y - startPoint.y ) * (localPos.y - startPoint.y ));
				MonsterDebugger.trace("distance", distance);
				if(int(distance) > 100){
					stopBoxAni();
				}
			}
		}
		
		public function resize() : void {
			setAniPos();
			lblContainer.width = ViewConstants.STARLING_STAGE.stageWidth;
			
			btnContainer.width = ViewConstants.STARLING_STAGE.stageWidth;
			buttonContainer2.width = ViewConstants.STARLING_STAGE.stageWidth;
			buttonContainer3.width = ViewConstants.STARLING_STAGE.stageWidth;
		}


		private function stopBoxAni() : void {
			boxAni.visible = false;
			boxAni.stop();
			cirkeltjesAni.visible = false;
			cirkeltjesAni.stop();
			stopAlarm();
		}

		private function start_triggered(event : starling.events.Event=null) : void {
			
			var overwriteLastTotalSeconds:Boolean = true;
			if(event == null)overwriteLastTotalSeconds = false;
			if(!running){
				resetBtn.visible = false;
				var secSpinner:int = int(secSpinnerlist.selectedItem.text);
				var sec10talSpinner:int = int(sec10talSpinnerlist.selectedItem.text);
				var minSpinner:int = int(minSpinnerlist.selectedItem.text);
				var min10talSpinner:int = int(min10talSpinnerlist.selectedItem.text);
			
				MonsterDebugger.trace(this, "start_triggered"+min10talSpinner+minSpinner + ":"+ sec10talSpinner+secSpinner);
				
				var lMinutes:int = (min10talSpinner *10 + minSpinner);
				var lSeconds:int =  sec10talSpinner*10 + secSpinner;
				totalSeconds = lMinutes *60 + lSeconds;
				
				if(overwriteLastTotalSeconds){
					ViewConstants.saveSettings.lastTotalSeconds = totalSeconds;
				}
				
				
				//MonsterDebugger.trace(this, "minutes:"+lMinutes + "seconds:"+lSeconds);
				if(totalSeconds>0){
					ViewConstants.saveSettings.startTime = new Date().time;
					try{
						if(ViewConstants.notifications){
							ViewConstants.notifications.timedNotification(totalSeconds);
						}
					}catch(error:Error){
						MonsterDebugger.trace(this, "error init notification: "+error.toString());	
						if(ViewConstants.txtDebug)
							ViewConstants.txtDebug.text += "error timerappscreen init notification: "+error.toString(); 
					}
					
					durationTimer= new DurationTimer(1000, totalSeconds);
					durationTimer.addEventListener(TimerEvent.TIMER, duratonTimerHandler);
					durationTimer.addEventListener(TimerEvent.TIMER_COMPLETE, completeHandler);
					durationTimer.start();
					
					running = true;
					startBtn.label = "stop";
				}			
			} else {
				resetBtn.visible = true;
				stopTimer();
			}
		}

		
		private function duratonTimerHandler(event : flash.events.Event) : void {
			var durationSeconds:int = int(durationTimer.duration/1000);
			var lSeconds:int = totalSeconds - durationSeconds;
			
			if(lSeconds<=0){
				minutes = 0;
				seconds = 0;
				completeHandler();
				durationTimer.removeEventListener(TimerEvent.TIMER, duratonTimerHandler);
				durationTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, completeHandler);
			}
			
			
			setSpinners(lSeconds);
			
			//MonsterDebugger.trace(this, "tienSecVar:"+ tienSecVar + " singleSecVar:"+singleSecVar);
		}
		
		private function setSpinners(lSeconds:int):void{
			//MonsterDebugger.trace("timerHandler", "totalSeconds:" + totalSeconds + "minutes:"+minutes +" seconds"+seconds);
			if(lSeconds<0)lSeconds = 0;
			
			minutes = Math.abs(lSeconds / 60);			
			seconds = lSeconds - minutes*60;
			
			var tienMinVar:int = Math.abs(minutes / 10); 
			min10talSpinnerlist.selectedIndex = tienMinVar;
			min10talSpinnerlist.scrollToDisplayIndex(tienMinVar);
			
			var singleMinVar:int = minutes - tienMinVar *10;
			
			minSpinnerlist.selectedIndex = singleMinVar; 
			minSpinnerlist.scrollToDisplayIndex(singleMinVar);
			
			var tienSecVar:int = Math.abs(seconds / 10); 
			sec10talSpinnerlist.selectedIndex = tienSecVar;
			sec10talSpinnerlist.scrollToDisplayIndex(tienSecVar);
			
			var singleSecVar:int = seconds - tienSecVar *10; 
			
			secSpinnerlist.selectedIndex = singleSecVar; 
			secSpinnerlist.scrollToDisplayIndex(singleSecVar);
			
		
		}

		private function completeHandler(event : TimerEvent = null) : void {
			resetBtn.visible = true;
			ViewConstants.STARLINGMAIN.switchToApp();
			stopTimer();
			MonsterDebugger.trace(this, "tuut tuut, time's up");

			turnOnScreen(); 
			if(ViewConstants.saveSettings.sound == ViewConstants.TRUE){
				soundIntervalID = setInterval(beep, 400);
			}
			if(ViewConstants.saveSettings.vibrate == ViewConstants.TRUE){
				vibrateIntervalID = setInterval(vibrate, 2000);
			}
			
			boxAni.visible = true;
			boxAni.play();
			cirkeltjesAni.visible = true;
			cirkeltjesAni.play();			
		}
		
		private function stopAlarm():void{
			clearInterval(soundIntervalID);
			clearInterval(vibrateIntervalID);
		}
		
		private function vibrate():void{
			
			var vibe:Vibration; 
            if (Vibration.isSupported)
            {
                vibe = new Vibration();
                vibe.vibrate(1000);
			}
		}
		
		private function beep():void{
			
			Sound.play(Sound.Beep);
		}
		
		private function turnOnScreen():void{
			//vind ik niet direct hoe te doen
			//alarm.startAlarm();			
		}
		
		private function stopTimer():void{
			ViewConstants.saveSettings.startTime = 0;
			running = false;
			//myTimer.stop();
			if(durationTimer)durationTimer.stop();
			startBtn.label = "start";
			try{
				if(ViewConstants.notifications){
					ViewConstants.notifications.stopTimedNotification();
				}
			}catch(error:Error){
				MonsterDebugger.trace(this, "error init notification: "+error.toString());	
				if(ViewConstants.txtDebug)
					ViewConstants.txtDebug.text += "error timerappscreen init notification: "+error.toString(); 
			}
		}
	}
}