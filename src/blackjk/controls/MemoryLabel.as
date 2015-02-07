package blackjk.controls {
	import blackjk.math.MathTools;
	
	import flash.events.Event;
	import flash.system.System;
	
	import mx.controls.Label;
	
	// ----------------------------------------------------------------------------------------------------
	
	public class MemoryLabel extends Label {
		
		// ----------------------------------------------------------------------------------------------------
		
		public static function getMemoryString():String {
			var mem:uint = System.totalMemory;
			var kbNum:Number = mem / 1024;
			var kb:String = MathTools.numberFormat(kbNum, 1);
			var mb:String = MathTools.numberFormat(kbNum / 1024, 1);
			return "System.totalMemory: " + mb + "MB (" + kb + "kb  " + mem + ")";
		}
		
		
		
		// ====================================================================================================
		
		public function MemoryLabel() {
			super();
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		// ----------------------------------------------------------------------------------------------------
		
		protected function onEnterFrame(evt:Event):void {
			text = getMemoryString();
		}
		
		
		
		// ----------------------------------------------------------------------------------------------------
		
		private var _killed:Boolean = false;
		
		public function kill():void {
			if (_killed) {
				MessageWindow.appendDebugText("[Error] MemoryLabel.kill(): already killed!");
				return;
			}
			
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			
			if (parent)
				parent.removeChild(this);
		}
		
		// ----------------------------------------------------------------------------------------------------
	}
}
