/***************************************
	ActionScript 3.0
	Version: 2.0.0
	Author: BlackJK
	Date: 2008/09/02
	
	2 x 2 Matrix.
***************************************/
package blackjk.math {
	
	// ----------------------------------------------------------------------------------------------------
	
	public class Matrix2d {
		
		// ----------------------------------------------------------------------------------------------------
		
		public static function scale(x:Number, y:Number):Matrix2d {
			return new Matrix2d(x, 0, 0, y);
		}
		
		
		
		// ----------------------------------------------------------------------------------------------------
		
		public static function rotate(z:Number):Matrix2d {
			//  cz  sz
			// -sz  cz
			var sz:Number = Math.sin(z);
			var cz:Number = Math.cos(z);
			return new Matrix2d(cz, sz, -sz, cz);
		}
		
		
		
		// ====================================================================================================
		
		public function Matrix2d(num11:Number=1, num12:Number=0,
								 num21:Number=0, num22:Number=1) {
			_n11 = num11;
			_n12 = num12;
			
			_n21 = num21;
			_n22 = num22;
		}
		
		
		
		// ----------------------------------------------------------------------------------------------------
		
		protected var _n11:Number;
		protected var _n12:Number;
		protected var _n21:Number;
		protected var _n22:Number;
		
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
		
		
		
		// --------------------------------------------------
		// [Axis]
		// --------------------------------------------------
		
		public function get axiX():Vector2 {
			return new Vector2(n11, n21);
		}
		
		public function get axiY():Vector2 {
			return new Vector2(n12, n22);
		}
		
		// --------------------------------------------------
		
		public function get negativeAxiX():Vector2 {
			return new Vector2(-n11, -n21);
		}
		
		public function get negativeAxiY():Vector2 {
			return new Vector2(-n12, -n22);
		}
		
		
		
		// ----------------------------------------------------------------------------------------------------
		
		public function identity():void{
			_n11 = 1;
			_n12 = 0;
			
			_n21 = 0;
			_n22 = 1;
		}
		
		
		
		// ----------------------------------------------------------------------------------------------------
		
		public function add(m:Matrix2d, sign:Boolean):void{
			if (sign) {
				_n11 += m.n11;
				_n12 += m.n12;
				
				_n21 += m.n21;
				_n22 += m.n22;
			} else {
				_n11 -= m.n11;
				_n12 -= m.n12;
				
				_n21 -= m.n21;
				_n22 -= m.n22;
			}
		}
		
		
		
		// ----------------------------------------------------------------------------------------------------
		
		public function concat(o:Matrix2d):void {
			var o11:Number = o.n11;
			var o12:Number = o.n12;
			
			var o21:Number = o.n21;
			var o22:Number = o.n22;
			
			var nn11:Number = o11 * _n11 + o12 * _n21;
			var nn12:Number = o11 * _n12 + o12 * _n22;
			
			var nn21:Number = o21 * _n11 + o22 * _n21;
			var nn22:Number = o21 * _n12 + o22 * _n22;
			
			_n11 = nn11;
			_n12 = nn12;
			
			_n21 = nn21;
			_n22 = nn22;
		}
		
		
		
		// ----------------------------------------------------------------------------------------------------
		
		public function diag():void {
			asign(_n11, _n21,
				  _n12, _n22);
		}
		
		
		// ----------------------------------------------------------------------------------------------------
		
		public function asign(num11:Number, num12:Number, num21:Number, num22:Number):void {
			_n11 = num11;
			_n12 = num12;
			
			_n21 = num21;
			_n22 = num22;
		}
		
		// --------------------------------------------------
		
		public function asignWith(m:Matrix2d):void{
			_n11 = m.n11;
			_n12 = m.n12;
			
			_n21 = m.n21;
			_n22 = m.n22;
		}
		
		
		
		// ----------------------------------------------------------------------------------------------------
		
		public function compareTo(m:Matrix3d):Boolean {
			return  _n11 == m.n11 && _n12 == m.n12 &&
					_n11 == m.n21 && _n22 == m.n22;
		}
		
		
		
		// ----------------------------------------------------------------------------------------------------
		
		public function fixToInteger():void {
			_n11 = Math.round(_n11);
			_n11 = Math.round(_n12);
			
			_n11 = Math.round(_n21);
			_n11 = Math.round(_n22);
		}
		
		
		
		// ----------------------------------------------------------------------------------------------------
		
		public function clone():Matrix2d{
			return new Matrix2d(_n11, _n12, _n21, _n22);
		}
		
		
		
		// ----------------------------------------------------------------------------------------------------
		
		public function toString():String {
			return "Matrix2d[" + _n11 + ", " + _n12 + "\n" +
				   "         " + _n21 + ", " + _n22 + "]" ;
		}
		
		// ----------------------------------------------------------------------------------------------------
		
	}
}
