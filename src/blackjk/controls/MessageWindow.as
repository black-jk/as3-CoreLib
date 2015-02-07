package blackjk.controls {
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.SecurityErrorEvent;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	
	import mx.controls.Button;
	import mx.controls.TextArea;
	import mx.core.Application;
	import mx.core.UIComponent;
	
	// ----------------------------------------------------------------------------------------------------
	
	public class MessageWindow extends SuperTitleWindow {
		
		// ----------------------------------------------------------------------------------------------------
		
		private static const textArea:TextArea = new TextArea;
		
		private static var _currentWindow:MessageWindow;
		
		public static function get currentWindow():MessageWindow {
			return _currentWindow;
		}
		
		
		public static var level:int = 1;
		
		public static var IOErrorLevel:int = 1;
		public static var SecurityErrorLevel:int = 1;
		
		
		
		// ----------------------------------------------------------------------------------------------------
		
		public static function get errorMessage():String {
			return textArea.text;
		}
		
		public static function set errorMessage(val:String):void {
			textArea.text = val;
			
			clearTimeout(_timeoutId);
			setTimeout(scrollToNewst, 200);
			
			if (_currentWindow == null) {
				_currentWindow = new MessageWindow;
				//PopUpManager.addPopUp(_currentWindow, UIComponent(Application.application));
				UIComponent(Application.application).addChild(_currentWindow);
			}
		}
		
		// ----------------------------------------------------------------------------------------------------
		
		private static var _timeoutId:uint;
		private static function scrollToNewst():void {
			textArea.verticalScrollPosition = textArea.maxVerticalScrollPosition;
		}
		
		// ----------------------------------------------------------------------------------------------------
		
		public static function showIOError(evt:IOErrorEvent):void {
			appendText(evt.text, IOErrorLevel);
		}
		
		public static function showSecurityError(evt:SecurityErrorEvent):void { 
			appendText(evt.text, SecurityErrorLevel);
		}
		
		public static function appendDebugText(val:String, _level:int=2, newLine:Boolean=true):void {
			appendText(val, _level, newLine);
		}
		public static function appendText(val:String, _level:int=1, newLine:Boolean=true):void {
			trace(val);
			if (newLine) val += "\n";
			if (_level <= level) errorMessage += val;
		}
		
		
		public static function clean():void {
			textArea.text = "";
		}
		
		public static var beginX:Number = 50;
		public static var beginY:Number = 50;
		
		public static var beginW:Number = 550;
		public static var beginH:Number = 400;
		
		
		
		// ====================================================================================================
		
		public function MessageWindow() {
			super();
			super.width = beginW;
			super.height = beginH;
			super.move(beginX, beginY);
			minWidth = 200;
			minHeight = 110;
			title = "Message Window";
			horizontalScrollPolicy = verticalScrollPolicy = "off";
		}
		
		
		
		// ----------------------------------------------------------------------------------------------------
		
		public var clearButton:Button = new Button;
		public var closeButton:Button = new Button;
		
		
		
		// ----------------------------------------------------------------------------------------------------
		
		override protected function createChildren():void {
			clearButton.label = "Clear";
			clearButton.setStyle("right", 65);
			clearButton.setStyle("bottom", 5);
			clearButton.addEventListener(MouseEvent.CLICK, clear);
			
			closeButton.label="close";
			closeButton.setStyle("right",  5);
			closeButton.setStyle("bottom", 5);
			closeButton.addEventListener(MouseEvent.CLICK, closeClickHandler);
			
			textArea.editable = false;
			textArea.setStyle("top", 0);
			textArea.setStyle("left", 0);
			textArea.setStyle("right", 0);
			textArea.setStyle("bottom", 30);
			
			addChild(textArea);
			addChild(clearButton);
			addChild(closeButton);
			
			super.createChildren();
		}
		
		
		
		// ----------------------------------------------------------------------------------------------------
		
		override public function closeClickHandler(event:MouseEvent):void {
			removeChild(textArea);
			_currentWindow = null;
			super.closeClickHandler(event);
			//PopUpManager.removePopUp(this);
		}
		
		
		
		// ----------------------------------------------------------------------------------------------------
		
		override public function set x(value:Number):void {
			super.x = beginX = value;
		}
		
		override public function set y(value:Number):void {
			super.y = beginY = value;
		}
		
		override public function set width(value:Number):void {
			super.width = beginW = value;
		}
		
		override public function set height(value:Number):void {
			super.height = beginH = value;
		}
		
		override public function move(x:Number, y:Number):void {
			beginX = x;
			beginY = y;
			super.move(x, y);
		}
		
		
		
		// ----------------------------------------------------------------------------------------------------
		
		public function clear(evt:Event):void {
			errorMessage = "";
		}
		
		
		
		// ----------------------------------------------------------------------------------------------------
		
	}
}
