package com.ictbram.timer {
	import com.demonsters.debugger.MonsterDebugger;
	import com.juankpro.ane.localnotif.Notification;
	import com.juankpro.ane.localnotif.NotificationEvent;
	import com.juankpro.ane.localnotif.NotificationManager;
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
	public class Notifications {
		private var notificationManager:NotificationManager;
		private static const NOTIFICATION_CODE:String = "NOTIFICATION_CODE_001";
		private var notification:Notification = new Notification();
		
		public function Notifications() {
			try{
				if(NotificationManager.isSupported) {
			        notificationManager = new NotificationManager();
					notificationManager.addEventListener(NotificationEvent.NOTIFICATION_ACTION, notificationActionHandler);
				}		
			}catch(error:Error){
				MonsterDebugger.trace(this, "error init notification: "+error.toString());	
				if(ViewConstants.txtDebug)
					ViewConstants.txtDebug.text += "error notifications class init notification: "+error.toString();
			}
			
		}
		
		public function timedNotification(seconds:Number):void {
			notification = new Notification();
        	notification.actionLabel = "OK";
	        notification.body = "Timer fininished";
	        notification.title = "ICBram Timer  ";
	        notification.fireDate = new Date((new Date()).time + (seconds * 1000));
	        notification.numberAnnotation = 1;
	        notification.actionData = {sampleData:"Hello World!"}
	 
	        notificationManager.notifyUser(NOTIFICATION_CODE, notification);
		}
		
		public function stopTimedNotification():void {
			notificationManager.cancelAll();
		}
		

		private function notificationActionHandler(event : NotificationEvent) : void {
			var n:String = "Notification Code: " + event.notificationCode + "\nSample Data: {" + event.actionData.sampleData + "}\n\n";
			ViewConstants.txtDebug.text = n;
			//notificationManager.cancelAll();
		}
		
		
	}
}