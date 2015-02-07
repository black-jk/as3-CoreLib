package blackjk.math {
	import flash.geom.Matrix;
	import flash.utils.ByteArray;
	
	// ----------------------------------------------------------------------------------------------------
	
	public class MathTools extends Object{
		
		// ----------------------------------------------------------------------------------------------------
		
		private static const _nybHexString:String = "0123456789ABCDEF";
		public static function byte2Hex(n:int):String {
    		return String(_nybHexString.substr((n >> 4) & 0x0F, 1)) + _nybHexString.substr(n & 0x0F, 1);
		}
		
		// ----------------------------------------------------------------------------------------------------
		
		public static function hex2uint(hex:String):uint {
			if (hex.indexOf("0x") < 0) {
				hex = "0x" + hex;
			}
			return int(hex);
		}
		
		// ----------------------------------------------------------------------------------------------------
		
		public static function hexString2ByteArray(hex:String):ByteArray {
			var resultBtyes:ByteArray = new ByteArray;
			for (var i:uint=0; i<hex.length-1; i+=2) {
				resultBtyes.writeByte(MathTools.hex2uint(hex.charAt(i) + hex.charAt(i+1)));
			}
			return resultBtyes;
		}
		
		
		
		// ----------------------------------------------------------------------------------------------------
		
		public static function numberFormat(value:Number, numCount:uint):String {
			numCount = Math.min(numCount, 10);
			
			var str:String = value.toString();
			var index:int = str.indexOf(".");
			
			str += (index > -1) ?
				"0000000000" :
				".0000000000";
			
			index = str.indexOf(".");
			return str.slice(0, index + 1 + numCount);
		}
		
		
		
		// ----------------------------------------------------------------------------------------------------
		
		public static const MATH_180_PI:Number = 180 * Math.PI;
		public static const MATH_180_D_PI:Number = 180 / Math.PI;
		public static const MATH_PI_D_180:Number = Math.PI / 180;
		
		// --------------------------------------------------
		
		public static function deg2Radian(deg:Number):Number {
			//return deg / 180 * Math.PI;
			return deg * MATH_PI_D_180;
		}
		
		// --------------------------------------------------
		
		public static function radian2Deg(r:Number):Number {
			//return r * 180 / Math.PI;
			return r * MATH_180_D_PI;
		}
		
		
		
		// ----------------------------------------------------------------------------------------------------
		
		public static function limit(value:Number, min:Number, max:Number):Number {
			if (min > max) { min = max; }
			return Math.min(Math.max(value, min), max);
		}
		
		
		// ----------------------------------------------------------------------------------------------------
		// [3D Engine]
		// ----------------------------------------------------------------------------------------------------
		
		// normalV is NormalVector
		// axiX is the axi X of plane
		//
		// Use normailized vector.
		//
		public static function matrix(normalV:Point3, axiX:Point3, tx:Number=0, ty:Number=0):Matrix {
			var xscale:Number = -normalV.z; //-target.position.z / radius;  //note. xscale == cos(z)
			var outerArc:Number  = Math.atan2(normalV.y, normalV.x);
			var targetArc:Number = Math.atan2(axiX.y, axiX.x) - outerArc;
			var inertArc:Number  = Math.atan2(Math.sin(targetArc), Math.cos(targetArc)/xscale); // + Math.PI/2;
			var M:Matrix2d = Matrix2d.rotate(outerArc);
			M.n11 *= xscale;  M.n12 *= xscale;  //M.concat(Matrix2d.scale(xscale, 1));
			M.concat(Matrix2d.rotate(inertArc));
			
			return new Matrix(M.n11, M.n12, M.n21, M.n22, tx, ty);
		}
		
		
		
		// ----------------------------------------------------------------------------------------------------
		
		/*/
		public static var resolution:Number = 300;  // default = 300 dpi
		
		public static function mm2pix(mm:Number):Number {
			return mm * resolution / 25.4;
		}
		public static function pix2mm(pix:Number):Number {
			return pix * 25.4 / resolution ;
		}
		
		// ----------------------------------------------------------------------------------------------------
		
		public static var mmScale:Number = 2;  // default  1 mm == 2 pix  at Editor
		
		public static function mm2PagePix(mm:Number):Number {
			return mm * mmScale;
		}
		public static function pagePix2mm(pp:Number):Number {
			return pp / mmScale;
		}
		
		// ----------------------------------------------------------------------------------------------------
		
		public static function resolution2PagePix(res:Number):Number {
			return mm2PagePix(pix2mm(res));
		}
		public static function pagePix2resolution(pp:Number):Number {
			return  mm2pix(pagePix2mm(pp));
		}
		//*/
		
		// ----------------------------------------------------------------------------------------------------
		
	}
}
