 /******************************************************************************
 * 
 * [FPSCounter]  FPS Counter Label (Flex Version)
 * 
 * Version: 1.0.0
 * 
 * Language: ActionScript 3.0 (Flex 3)
 * 
 * Author: BlackJK
 * Date: 2008/12/06
 * 
 * Last edited: by BlackJK on 2008-12-06
 * 
 ******************************************************************************/
package blackjk.controls {
	import flash.events.Event;
	import flash.utils.getTimer;
	import mx.controls.Label;
	
	// ----------------------------------------------------------------------------------------------------
	
	public class FPSCounter extends Label {
		
		// ----------------------------------------------------------------------------------------------------
		
		public function FPSCounter(leng:uint=4, headstr:String='FPS:') {
			length = leng;
			headerStr = headstr;
			for (var i:uint=0; i<=FRAMES; i++) {
				_time_buffer.push(i);
			}
			addEventListener(Event.ENTER_FRAME, tick);
		}
		
		
		
		// ----------------------------------------------------------------------------------------------------
		
		public const FRAMES:uint = 3;
		
		public var length:uint;
		public var headerStr:String;
		
		private var _time_buffer:Array = new Array;
		private var _ticks:uint = 0;
		private var _fps:Number = 0;
		
		// ----------------------------------------------------------------------------------------------------
		
		private var _1000_FRAMES:uint = 1000 * FRAMES;
		
		public function tick(event:Event):void {
			_ticks++;
			_time_buffer.push(getTimer());
			_time_buffer.shift();
			_fps = _1000_FRAMES / (_time_buffer[FRAMES] - _time_buffer[1]);
			
			text = headerStr + _fps.toPrecision(length);
		}
		
		// ----------------------------------------------------------------------------------------------------
		
	}
}
