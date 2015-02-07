package blackjk.math {
	
	public class Point2 extends Object {
		
		// ----------------------------------------------------------------------------------------------------
		
		public function Point2(x:Number=0, y:Number=0) {
			super();
			
			_x = x;
			_y = y;
		}
		
		
		
		// ----------------------------------------------------------------------------------------------------
		
		protected var _className:String = "Point3";
		
		protected var _x:Number;
		protected var _y:Number;
		
		// --------------------------------------------------
		
		public function get x():Number {
			return _x;
		}
		public function set x(value:Number):void {
			_x = value;
		}
		
		public function get y():Number {
			return _y;
		}
		public function set y(value:Number):void {
			_y = value;
		}
		
		
		
		// ----------------------------------------------------------------------------------------------------
		
		public function toString():String {
			return _className + "(" + _x + ", " + _y + ")";
		}
		
		// ----------------------------------------------------------------------------------------------------
		
	}
}
