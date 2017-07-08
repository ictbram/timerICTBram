package com.ictbram.timer {
	import com.demonsters.debugger.MonsterDebugger;
	import com.juankpro.ane.localnotif.Notification;
	import com.juankpro.ane.localnotif.NotificationEvent;
	import com.juankpro.ane.localnotif.NotificationManager;
	/**
	 * @author Bram Joris - ictbram.com
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