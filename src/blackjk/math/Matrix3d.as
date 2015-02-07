/***************************************
	ActionScript 3.0
	Version: 2.0.0
	Author: BlackJK
	Date: 2008/09/02
	
	3 x 3 Matrix.
***************************************/
package blackjk.math {
	
	// ----------------------------------------------------------------------------------------------------
	
	public class Matrix3d {
		
		// ----------------------------------------------------------------------------------------------------
		
		public static function scale(x:Number, y:Number, z:Number):Matrix3d {
			return new Matrix3d(x, 0, 0, 0, y, 0, 0, 0, z);
		}
		
		
		
		// ----------------------------------------------------------------------------------------------------
		
		public static function rotate(x:Number, y:Number, z:Number):Matrix3d {
			var num11:Number;
			var num12:Number;
			var num13:Number;
			
			var num21:Number;
			var num22:Number;
			var num23:Number;
			
			var num31:Number;
			var num32:Number;
			var num33:Number;
			
			var m:Matrix3d = new Matrix3d();
			
			if (x) {
				var sx:Number = Math.sin(x), cx:Number = Math.cos(x);
				//  1   0   0
				//  0  cx  sx
				//  0 -sx  cx
				m.n22 = cx;
				m.n23 = sx;
				m.n32 =-sx;
				m.n33 = cx;
			}
			
			if (y) {
				var sy:Number = Math.sin(y), cy:Number = Math.cos(y);
				// cy   0  -sy
				//  0   1    0
				// sy   0   cy
				num11 = cy;     num12 = -sy*m.n32;   num13 = -sy*m.n33;
				num21 = 0;      num22 = m.n22;       num23 = m.n23;
				num31 = sy;     num32 = cy*m.n32;    num33 = cy*m.n33;
				m.asign(num11, num12, num13, num21, num22, num23, num31, num32, num33);
			}
			
			if (z) {
				var sz:Number = Math.sin(z), cz:Number = Math.cos(z);
				//  cz   sz   0
				// -sz   cz   0
				//   0    0   1
				
				m.concat(new Matrix3d(cz, sz,  0,    -sz, cz,  0,     0,  0,  1));
				/*  bug
				num11 =  cz*m.n11;  num12 = cz*m.n12 + sz*m.n22;   num13 = m.n13;
				num21 = -sz*m.n11;  num22 =-sz*m.n12 + cz*m.n22;   num23 = -sz*m.n13 + cz*m.n23;
				num31 = m.n31;      num32 = m.n32;                 num33 = m.n33;
				
				m.n11 = num11;  m.n12 = num12;  m.n13 = num13;
				m.n21 = num21;  m.n22 = num22;  m.n23 = num23;
				*/
			}
			
			return m;
		}
		
		
		
		// ====================================================================================================
		
		public function Matrix3d(num11:Number=1, num12:Number=0, num13:Number=0,
								 num21:Number=0, num22:Number=1, num23:Number=0,
								 num31:Number=0, num32:Number=0, num33:Number=1) {
			_n11 = num11;
			_n12 = num12;
			_n13 = num13;
			
			_n21 = num21;
			_n22 = num22;
			_n23 = num23;
			
			_n31 = num31;
			_n32 = num32;
			_n33 = num33;
		}
		
		
		
		// ----------------------------------------------------------------------------------------------------
		
		protected var _n11:Number;
		protected var _n12:Number;
		protected var _n13:Number;
		
		protected var _n21:Number;
		protected var _n22:Number;
		protected var _n23:Number;
		
		protected var _n31:Number;
		protected var _n32:Number;
		protected var _n33:Number;
		
		// --------------------------------------------------
		
		public function get n11():Number {
			return _n11;
		}
		public function set n11(value:Number):void {
			_n11 = value;
		}
		
		public function get n12():Number {
			return _n12;
		}
		public function set n12(value:Number):void {
			_n12 = value;
		}
		
		public function get n13():Number {
			return _n13;
		}
		public function set n13(value:Number):void {
			_n13 = value;
		}
		
		// ------------------------------
		
		public function get n21():Number {
			return _n21;
		}
		public function set n21(value:Number):void {
			_n21 = value;
		}
		
		public function get n22():Number {
			return _n22;
		}
		public function set n22(value:Number):void {
			_n22 = value;
		}
		
		public function get n23():Number {
			return _n23;
		}
		public function set n23(value:Number):void {
			_n23 = value;
		}
		
		// ------------------------------
		
		public function get n31():Number {
			return _n31;
		}
		public function set n31(value:Number):void {
			_n31 = value;
		}
		
		public function get n32():Number {
			return _n32;
		}
		public function set n32(value:Number):void {
			_n32 = value;
		}
		
		public function get n33():Number {
			return _n33;
		}
		public function set n33(value:Number):void {
			_n33 = value;
		}
		
		
		
		// --------------------------------------------------
		// [Axis]
		// --------------------------------------------------
		
		public function get axiX():Vector3 {
			return new Vector3(n11, n21, n31);
		}
		public function get axiY():Vector3 {
			return new Vector3(n12, n22, n32);
		}
		public function get axiZ():Vector3 {
			return new Vector3(n13, n23, n33);
		}
		
		// --------------------------------------------------
		
		public function get negativeAxiX():Vector3 {
			return new Vector3(-n11, -n21, -n31);
		}
		public function get negativeAxiY():Vector3 {
			return new Vector3(-n12, -n22, -n32);
		}
		public function get negativeAxiZ():Vector3 {
			return new Vector3(-n13, -n23, -n33);
		}
		
		
		
		// ----------------------------------------------------------------------------------------------------
		
		public function identity():void{
			_n11 = 1;
			_n12 = 0;
			_n13 = 0;
			
			_n21 = 0;
			_n22 = 1;
			_n23 = 0;
			
			_n31 = 0;
			_n32 = 0;
			_n33 = 1;
		}
		
		
		
		// ----------------------------------------------------------------------------------------------------
		
		public function add(m:Matrix3d, s:Boolean=true):void{
			if (s) {
				_n11 += m.n11;
				_n12 += m.n12;
				_n13 += m.n13;
				
				_n21 += m.n21;
				_n22 += m.n22;
				_n23 += m.n23;
				
				_n31 += m.n31;
				_n32 += m.n32;
				_n33 += m.n33;
			} else {
				_n11 -= m.n11;
				_n12 -= m.n12;
				_n13 -= m.n13;
				
				_n21 -= m.n21;
				_n22 -= m.n22;
				_n23 -= m.n23;
				
				_n31 -= m.n31;
				_n32 -= m.n32;
				_n33 -= m.n33;
			}
		}
		
		
		
		// ----------------------------------------------------------------------------------------------------
		
		public function concat(o:Matrix3d):void {
			var o11:Number = o.n11;
			var o12:Number = o.n12;
			var o13:Number = o.n13;
			
			var o21:Number = o.n21;
			var o22:Number = o.n22;
			var o23:Number = o.n23;
			
			var o31:Number = o.n31;
			var o32:Number = o.n32;
			var o33:Number = o.n33;
			
			var nn11:Number = o11 * _n11 + o12 * _n21 + o13 * _n31;
			var nn12:Number = o11 * _n12 + o12 * _n22 + o13 * _n32;
			var nn13:Number = o11 * _n13 + o12 * _n23 + o13 * _n33;
			
			var nn21:Number = o21 * _n11 + o22 * _n21 + o23 * _n31;
			var nn22:Number = o21 * _n12 + o22 * _n22 + o23 * _n32;
			var nn23:Number = o21 * _n13 + o22 * _n23 + o23 * _n33;
			
			var nn31:Number = o31 * _n11 + o32 * _n21 + o33 * _n31;
			var nn32:Number = o31 * _n12 + o32 * _n22 + o33 * _n32;
			var nn33:Number = o31 * _n13 + o32 * _n23 + o33 * _n33;
			
			_n11 = nn11;
			_n12 = nn12;
			_n13 = nn13;
			
			_n21 = nn21;
			_n22 = nn22;
			_n23 = nn23;
			
			_n31 = nn31;
			_n32 = nn32;
			_n33 = nn33;
		}
		
		
		
		// ----------------------------------------------------------------------------------------------------
		
		public function diag():void {
			asign(_n11, _n21, _n31,
				  _n12, _n22, _n32,
				  _n13, _n23, _n33);
		}
		
		
		
		// ----------------------------------------------------------------------------------------------------
		
		public function asign(num11:Number, num12:Number, num13:Number,
							  num21:Number, num22:Number, num23:Number,
							  num31:Number, num32:Number, num33:Number):void {
			_n11 = num11;
			_n12 = num12;
			_n13 = num13;
			
			_n21 = num21;
			_n22 = num22;
			_n23 = num23;
			
			_n31 = num31;
			_n32 = num32;
			_n33 = num33;
		}
		
		// --------------------------------------------------
		
		public function asignWith(m:Matrix3d):void{
			_n11 = m.n11;
			_n12 = m.n12;
			_n13 = m.n13;
			
			_n21 = m.n21;
			_n22 = m.n22;
			_n23 = m.n23;
			
			_n31 = m.n31;
			_n32 = m.n32;
			_n33 = m.n33;
		}
		
		
		
		// ----------------------------------------------------------------------------------------------------
		
		public function compareTo(m:Matrix3d):Boolean {
			return  _n11 == m.n11 && _n12 == m.n12 && _n13 == m.n13 &&
					_n11 == m.n21 && _n22 == m.n22 && _n23 == m.n23 &&
					_n11 == m.n31 && _n32 == m.n32 && _n33 == m.n33;
		}
		
		
		
		// ----------------------------------------------------------------------------------------------------
		
		public function fixToInteger():void {
			_n11 = Math.round(_n11);
			_n11 = Math.round(_n12);
			_n11 = Math.round(_n13);
			
			_n11 = Math.round(_n21);
			_n11 = Math.round(_n22);
			_n11 = Math.round(_n23);
			
			_n11 = Math.round(_n31);
			_n11 = Math.round(_n32);
			_n11 = Math.round(_n33);
		}
		
		
		
		// ----------------------------------------------------------------------------------------------------
		
		public function clone():Matrix3d {
			return new Matrix3d(_n11, _n12, _n13, _n21, _n22, _n23, _n31, _n32, _n33);
		}
		
		
		
		// ----------------------------------------------------------------------------------------------------
		
		public function toString():String {
			return "Matrix2d[" + _n11 + ", " + _n12 + ", " + _n13 + "\n" +
				   "         " + _n21 + ", " + _n22 + ", " + _n23 + "\n" +
				   "         " + _n31 + ", " + _n32 + ", " + _n33 + "]";
		}
		
		// ----------------------------------------------------------------------------------------------------
		
	}
}
