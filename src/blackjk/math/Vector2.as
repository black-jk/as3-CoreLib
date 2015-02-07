/***************************************
	ActionScript 3.0
	Version: 2.0.0
	Author: BlackJK
	Date: 2008/09/02
	
	Last edited: by BlackJK on 2008-11-29 at 12:35
	
	(x, y) Vector.
***************************************/
package blackjk.math {
	
	// ----------------------------------------------------------------------------------------------------
	
	public class Vector2 extends Point2 {
		
		// ----------------------------------------------------------------------------------------------------
		
		public static function sum(...rest):Vector2 {
			var x:Number = 0, y:Number = 0;
			for each (var v:Point2 in rest) {
				if (!v)
					continue;
				
				x += v.x;
				y += v.y;
			}
			return new Vector2(x, y);
		}
		
		
		
		// ====================================================================================================
		
		public function Vector2(x:Number=0, y:Number=0) {
			super(x, y);
			
			_className = "Vector2";
		}
		
		
		
		// ----------------------------------------------------------------------------------------------------
		
		protected var _length_cache:Number = NaN;  // cache of length
		protected var _length_cache2:Number = NaN; // cache of length^2
		
		
		
		// ----------------------------------------------------------------------------------------------------
		
		override public function set x(value:Number):void {
			_x = value;
			_length_cache = _length_cache2 = NaN;
		}
		
		// --------------------------------------------------
		
		override public function set y(value:Number):void {
			_y = value;
			_length_cache = _length_cache2 = NaN;
		}
		
		
		
		// ----------------------------------------------------------------------------------------------------
		
		public function get width():Number {
			return _x;
		}
		
		// --------------------------------------------------
		
		public function get height():Number {
			return _y;
		}
		
		
		
		// ----------------------------------------------------------------------------------------------------
		
		public function clone():Vector2 {
			return new Vector2(_x, _y);
		}
		
		
		
		// ----------------------------------------------------------------------------------------------------
		
		public function toValue():Point2 {
			return new Point2(_x, _y);
		}
		
		
		
		// ----------------------------------------------------------------------------------------------------
		
		public function asign(x:Number, y:Number):void {
			_x = x;
			_y = y;
			_length_cache = _length_cache2 = NaN;
		}
		
		// --------------------------------------------------
		
		public function asignWith(p:Point2):void {
			_x = p.x;
			_y = p.y;
			_length_cache = _length_cache2 = NaN;
		}
		
		
		
		// ----------------------------------------------------------------------------------------------------
		// [Length]
		// ----------------------------------------------------------------------------------------------------
		
		public function get length():Number {
			if (isNaN(_length_cache)) {
				return _length_cache = Math.sqrt(Math.pow(_x, 2) + Math.pow(_y, 2));
			} else {
				return _length_cache;
			}
		}
		
		// --------------------------------------------------
		
		public function set length(value:Number):void {
			if (length == 0) {
				throw new Error("Divided by zero!");
			}
			
			_length_cache = value;
			_length_cache2 = NaN;
			scale(value / length);
		}
		
		// --------------------------------------------------
		
		public function get lengthP2():Number {
			if (isNaN(_length_cache2)) {
				_length_cache2 = _x * _x + _y * _y;
			}
			return _length_cache2;
		}
		
		
		
		// ----------------------------------------------------------------------------------------------------
		
		public function concat(v:Point2, sign:Boolean=true):void {
			if (sign) {
				_x += v.x;
				_y += v.y;
			} else {
				_x -= v.x;
				_y -= v.y;
			}
			_length_cache = _length_cache2 = NaN;
		}
		
		// --------------------------------------------------
		
		public function concatValue(x:Number, y:Number):void {
			_x += x;
			_y += y;
			
			_length_cache = _length_cache2 = NaN;
		}
		
		
		
		// ----------------------------------------------------------------------------------------------------
		
		public function operate(o:Matrix2d):void {
			var xx:Number = o.n11 * _x + o.n12 * _y;
			var yy:Number = o.n21 * _x + o.n22 * _y;
			
			_x = xx;
			_y = yy;
			_length_cache = _length_cache2 = NaN;
		}
		
		
		
		// ----------------------------------------------------------------------------------------------------
		
		public function fixToInteger():void {
			_x = Math.round(_x);
			_y = Math.round(_y);
		}
		
		
		
		// ----------------------------------------------------------------------------------------------------
		
		public function deltaV(v:Point2):Vector2 {
			return new Vector2(v.x - _x, v.y - _y);
		}
		
		// ----------------------------------------------------------------------------------------------------
		
		public function dot(v:Point2):Number {
			return v.x * _x + v.y * _y;
		}
		
		// ----------------------------------------------------------------------------------------------------
		
		public function cross(v:Point2):Number {
			return  _x * v.y - _y * v.x;
		}
		
		// ----------------------------------------------------------------------------------------------------
		
		public function scale(s:Number):void {
			_x *= s;
			_y *= s;
			
			_length_cache = _length_cache2 = NaN;
		}
		
		// ----------------------------------------------------------------------------------------------------
		
		public function normalize():void {
			scale(1 / length);
			
			_length_cache = _length_cache2 = NaN;
		}
		
		
		
		// ----------------------------------------------------------------------------------------------------
		
		public function validate():Boolean {
			return !(isNaN(_x) || isNaN(_y));
		}
		
		// ----------------------------------------------------------------------------------------------------
		
		public function isEqual(p:Point2):Boolean {
			return (_x == p.x && _y == p.y);
		}
		
		
		
		// ----------------------------------------------------------------------------------------------------
		// [Line]
		// ----------------------------------------------------------------------------------------------------
		
		// slope of line
		public function get m():Number {
			if (_x != 0) {
				return _y / _x;
			} else {
				// vertical
				if (_y == 0) {
					return NaN;
				} else {
					return _y > 0 ?
						Number.POSITIVE_INFINITY :
						Number.NEGATIVE_INFINITY;
				}
			}
		}
		
		
		
		// ----------------------------------------------------------------------------------------------------
		
	}
}
