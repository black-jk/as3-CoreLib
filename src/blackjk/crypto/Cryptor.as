package blackjk.crypto {
	import blackjk.controls.MessageWindow;
	import blackjk.math.MathTools;
	
	import com.adobe.crypto.MD5;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.utils.ByteArray;
	
	// ----------------------------------------------------------------------------------------------------
	
	public class Cryptor extends EventDispatcher {
		
		// ----------------------------------------------------------------------------------------------------
		
		public static function string2ByteArray(sourceString:String):ByteArray {
			var bytes:ByteArray = new ByteArray;
			bytes.writeUTFBytes(sourceString);
			return bytes;
		}
		
		
		
		// ====================================================================================================
		
		public function Cryptor(target:IEventDispatcher=null) {
			super(target);
		}
		
		
		
		// ----------------------------------------------------------------------------------------------------
		
		public static function encode(sourceString:String, passwdString:String="", compress:Boolean=true):String {
			
			var passwdMD5String:String = MD5.hash(passwdString);
			var passwdMD5Bytes:ByteArray = MathTools.hexString2ByteArray(passwdMD5String);
			
			var sourceBytes:ByteArray = string2ByteArray(sourceString);
			
			
			// Begin encode
			var md5ByteIndex:uint = passwdMD5Bytes.length;
			for (var i:uint=0; i<sourceBytes.length; i++) {
				md5ByteIndex = (md5ByteIndex + 1) % passwdMD5Bytes.length;
				
				sourceBytes[i] = (sourceBytes[i] + passwdMD5Bytes[md5ByteIndex]) % 0xFF;
			}
			
			if (compress) {
				sourceBytes.compress();
			}
			
			var result:String = "";
			for (var j:uint=0; j<sourceBytes.length; j++) {
				result += MathTools.byte2Hex(sourceBytes[j]);
			}
			
			return result;
		}
		
		
		
		// ----------------------------------------------------------------------------------------------------
		
		public static function decode(sourceString:String, passwdString:String="", compress:Boolean=true):String {
			for each (var filterString:String in ["\n", "\r"]) {
				while (sourceString.indexOf(filterString) > -1) {
					sourceString = sourceString.replace(filterString, "");
				}
			}
			
			var passwdMD5String:String = MD5.hash(passwdString);
			var passwdMD5Bytes:ByteArray = MathTools.hexString2ByteArray(passwdMD5String);
			
			var sourceBytes:ByteArray = MathTools.hexString2ByteArray(sourceString);
			
			if (compress) {
				try {
					sourceBytes.uncompress();
				} catch (e:Error) {
					MessageWindow.appendText(e.message);
					return "";
				}
			}
			
			// Begin decode
			var md5ByteIndex:uint = passwdMD5Bytes.length;
			for (var i:uint=0; i<sourceBytes.length; i++) {
				md5ByteIndex = (md5ByteIndex + 1) % passwdMD5Bytes.length;
				
				sourceBytes[i] = (0xFF + sourceBytes[i] - passwdMD5Bytes[md5ByteIndex]) % 0xFF;
			}
			
			var result:ByteArray = new ByteArray;
			for (i=0; i<sourceBytes.length; i++) {
				result.writeByte(int(sourceBytes[i]));
			}
			return result.toString();
		}
		
		// ----------------------------------------------------------------------------------------------------
		
	}
}
