/***************************************
	ActionScript 3.0
	Version: 2.0.0
	Author: BlackJK
	Date: 2008/09/02
	
	Last edited: by BlackJK on 2008-11-29 at 12:35
	
	(x, y, z) vector.
***************************************/
package blackjk.math {
	
	// ----------------------------------------------------------------------------------------------------
	
	public class Vector3 extends Point3 {
		
		// ----------------------------------------------------------------------------------------------------
		
		public static function sum(...rest):Vector3 {
			var x:Number = 0, y:Number = 0, z:Number = 0;
			for each (var v:Point3 in rest) {
				if (!v)
					continue;
				
				x += v.x;
				y += v.y;
				z += v.z;
			}
			return new Vector3(x, y, z);
		}
		
		
		
		// ====================================================================================================
		
		public function Vector3(x:Number=0, y:Number=0, z:Number=0) {
			super(x, y, z);
			
			_className = "Vector3";
		}
		
		
		
		// ----------------------------------------------------------------------------------------------------
		
		protected var _length_cache:Number = NaN;  // cache of length
		protected var _length_cache2:Number = NaN; // cache of length^2
		
		
		
		// ----------------------------------------------------------------------------------------------------
		
		override public function set x(x:Number):void {
			_x = x;
			_length_cache = _length_cache2 = NaN;
		}
		
		override public function set y(y:Number):void {
			_y = y;
			_length_cache = _length_cache2 = NaN;
		}
		
		override public function set z(z:Number):void {
			_z = z;
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
		
		// --------------------------------------------------
		
		public function get depth():Number {
			return _z;
		}
		
		
		
		// ----------------------------------------------------------------------------------------------------
		
		public function clone():Vector3 {
			return new Vector3(_x, _y, _z);
		}
		
		
		
		// ----------------------------------------------------------------------------------------------------
		
		public function toValue():Point3 {
			return new Point3(_x, _y, _z);
		}
		
		
		
		// ----------------------------------------------------------------------------------------------------
		
		public function asign(x:Number, y:Number, z:Number):void {
			_x = x;
			_y = y;
			_z = z;
			_length_cache = _length_cache2 = NaN;
		}
		
		// --------------------------------------------------
		
		public function asignWith(p:Point3):void {
			_x = p.x;
			_y = p.y;
			_z = p.z;
			_length_cache = _length_cache2 = NaN;
		}
		
		
		
		// ----------------------------------------------------------------------------------------------------
		// [Length]
		// ----------------------------------------------------------------------------------------------------
		
		public function get length():Number {
			if (isNaN(_length_cache)) {
				_length_cache = Math.sqrt(lengthP2);
			}
			return _length_cache;
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
				_length_cache2 = _x * _x + _y * _y + _z * _z;
			}
			return _length_cache2;
		}
		
		
		
		// ----------------------------------------------------------------------------------------------------
		
		public function concat(v:Point3, sign:Boolean=true):void {
			if (sign) {
				_x += v.x;
				_y += v.y;
				_z += v.z;
			} else {
				_x -= v.x;
				_y -= v.y;
				_z -= v.z;
			}
			_length_cache = _length_cache2 = NaN;
		}
		
		// --------------------------------------------------
		
		public function concatValue(x:Number, y:Number, z:Number):void {
			_x += x;
			_y += y;
			_z += z;
			_length_cache = _length_cache2 = NaN;
		}
		
		
		
		// ----------------------------------------------------------------------------------------------------
		
		public function operate(o:Matrix3d):void {
			var xx:Number = o.n11 * _x + o.n12 * _y + o.n13 * _z;
			var yy:Number = o.n21 * _x + o.n22 * _y + o.n23 * _z;
			var zz:Number = o.n31 * _x + o.n32 * _y + o.n33 * _z;
			
			_x = xx;
			_y = yy;
			_z = zz;
			_length_cache = _length_cache2 = NaN;
		}
		
		
		
		// ----------------------------------------------------------------------------------------------------
		
		public function fixToInteger():void {
			_x = Math.round(_x);
			_y = Math.round(_y);
			_z = Math.round(_z);
		}
		
		
		
		// ----------------------------------------------------------------------------------------------------
		
		public function deltaV(v:Point3):Vector3 {
			return new Vector3(v.x - _x, v.y - _y, v.z - _z);
		}
		
		// ----------------------------------------------------------------------------------------------------
		
		public function dot(v:Point3):Number {
			return v.x * _x + v.y * _y + v.z * _z;
		}
		
		// ----------------------------------------------------------------------------------------------------
		
		public function cross(v:Point3):Vector3 {
			return new Vector3(_y * v.z - _z * v.y, _z * v.x - _x * v.z, _x * v.y - _y * v.x);
		}
		
		// ----------------------------------------------------------------------------------------------------
		
		public function scale(s:Number):void {
			_x *= s;
			_y *= s;
			_z *= s;
			
			_length_cache = _length_cache2 = NaN;
		}
		
		// ----------------------------------------------------------------------------------------------------
		
		public function normalize():void {
			scale(1 / length);
			
			_length_cache = _length_cache2 = 1;
		}
		
		
		
		// ----------------------------------------------------------------------------------------------------
		
		public function validate():Boolean {
			return !(isNaN(_x) || isNaN(_y) || isNaN(_z));
		}
		
		// ----------------------------------------------------------------------------------------------------
		
		public function isEqual(p:Point3):Boolean {
			return (_x == p.x && _y == p.y && _z == p.z);
		}
		
		// ----------------------------------------------------------------------------------------------------
		
	}
}
