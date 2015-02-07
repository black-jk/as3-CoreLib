package blackjk.math {
	import blackjk.controls.MessageWindow;
	
	// ----------------------------------------------------------------------------------------------------
	
	public class Line extends Object {
		
		// ----------------------------------------------------------------------------------------------------
		
		public static function isVertical(m:Number):Boolean {
			return m == Number.NEGATIVE_INFINITY || m == Number.POSITIVE_INFINITY;
		}
		
		
		
		// ====================================================================================================
		
		// m, b (Number) : y = m * x + b
		//
		// m, b (Number) : x = b
		//                 m = Number.POSITIVE_INFINITY | Number.NEGATIVE_INFINITY;
		
		// p, v (Vector) : (x, y) = p + v.scale(t)
		
		public function Line(m:Number=0, b:Number=0, p:Vector2=null, v:Vector2=null) {
			super();
			
			if (p && v) {
				var vecM:Number = v.m;
				if (isVertical(vecM)) {
					_m = vecM;
					_b = p.x;
				} else {
					_m = vecM;
					_b = p.y - _m * p.x;
				}
			} else {
				_b = b;
				_m = m;
			}
		}
		
		
		
		// ----------------------------------------------------------------------------------------------------
		
		protected var _m:Number;
		protected var _b:Number;
		
		public function get vertical():Boolean {
			return isVertical(_m);
		}
		
		public function get m():Number {
			return _m;
		}
		public function set m(val:Number):void {
			_m = val;
		}
		
		// b | x (when vertical == true)
		public function get b():Number {
			return _b;
		}
		public function set b(val:Number):void {
			_b = val;
		}
		
		
		
		// ----------------------------------------------------------------------------------------------------
		
		public function calcY(x:Number):Number {
			if (vertical) {
				return x == _b ? 0 : NaN;
			} else {
				return _m * x + b;
			}
		}
		
		// --------------------------------------------------
		
		public function clacX(y:Number):Number {
			if (vertical) {
				return _b;
			} else {
				return (y - _b) / _m;
			}
		}
		
		
		
		// ----------------------------------------------------------------------------------------------------
		
		public function cross(line:Line):Vector2 {
			if (vertical) {
				if (line.vertical) {
					/*/
					if (_b == line.b) {
						return new Vector2(_b, 0); // 重疊
					} else {
						return null; // 平行
					}
					/*/
					return null;
					//*/
				} else {
					return new Vector2(_b, line.calcY(_b));
				}
			} else {
				if (line.vertical) {
					return line.cross(this);
				} else {
					if (line.m == _m) {
						// 重疊
						/*/
						var y:Number = calcY(0);
						if (line.calcY(0) == y) {
							return new Vector2(0, y);
						} else {
							return null;
						}
						/*/
						return null;
						//*/
					} else {
						var x:Number = (line.b - _b) / (_m - line.m);
						return new Vector2(x, calcY(x));
					}
				}
			}
		}
		
		
		
		// ----------------------------------------------------------------------------------------------------
		
		public function perpendicularLine(v:Point2):Line {
			if (vertical) {
				return new Line(0, v.y);
			} else {
				if (_m == 0) {
					return new Line(Number.POSITIVE_INFINITY, v.x);
				} else {
					var newM:Number = - 1 / _m;
					var newB:Number = v.y - newM * v.x;
					return new Line(newM, newB);
				}
			}
		}
		
		
		
		// ----------------------------------------------------------------------------------------------------
		
		public function mirror(v:Vector2):Vector2 {
			var pLine:Line = perpendicularLine(v);
			var inversePoint:Vector2 = cross(pLine);
			var arrow:Vector2 = v.deltaV(inversePoint);
			return new Vector2(v.x + 2 * arrow.x, v.y + 2 * arrow.y);
		}
		
		
		
		// ----------------------------------------------------------------------------------------------------
		
		public function toString():String {
			return "Line(" + _m + ", " + _b + ")";
		}
		
		// ----------------------------------------------------------------------------------------------------
		
	}
}
