package blackjk.controls {
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import mx.containers.TitleWindow;
	import mx.controls.Button;
	import mx.core.Application;
	import mx.core.UIComponent;
	import mx.effects.Resize;
	import mx.events.DragEvent;
	import mx.events.EffectEvent;
	import mx.events.FlexEvent;
	import mx.managers.CursorManager;
	
	// ----------------------------------------------------------------------------------------------------
	
	public class SuperTitleWindow extends TitleWindow {
		
		// ----------------------------------------------------------------------------------------------------
		
		[Bindable] public var showControls:Boolean = true;
		[Bindable] public var enableResize:Boolean = true;
		
		//[Embed(source="/assets/image/resizeCursor.png")]
		//private static var resizeCursor:Class;
		
		public static var headerColor1:uint = 0x7777AA;
		public static var headerColor2:uint = 0x333355;
		public static var borderColor:uint  = 0x333355;
		public static var headerColorFocus1:uint = 0xCCCCFF;
		public static var headerColorFocus2:uint = 0x8888CC;
		public static var borderColorFocus:uint  = 0x8888CC;
		
		
		
		// ----------------------------------------------------------------------------------------------------
		
		private var pTitleBar:UIComponent;
		private var oW:Number;
		private var oH:Number;
		private var oX:Number;
		private var oY:Number;
		private var normalMaxButton:Button	= new Button;
		private var closeButton:Button		= new Button;
		private var resizeHandler:Button	= new Button;
		private var upMotion:Resize			= new Resize;
		private var downMotion:Resize		= new Resize;
		private var oPoint:Point			= new Point;
		private var resizeCur:Number		= 0;
		
		
		
		// ----------------------------------------------------------------------------------------------------
		
		public function SuperTitleWindow() {
			super();
			layout = "absolute";
			minWidth = 160;
			minHeight = 80;
			addEventListener(FlexEvent.CREATION_COMPLETE, creationCompleteHandler);
		}
		
		
		
		// ----------------------------------------------------------------------------------------------------
		
		private function creationCompleteHandler(evt:FlexEvent):void {
			removeEventListener(FlexEvent.CREATION_COMPLETE, creationCompleteHandler);
			titleBar.setStyle("color", 0x50AACC);
		}
		
		
		
		// ----------------------------------------------------------------------------------------------------
		
		override protected function createChildren():void {
			super.createChildren();
			pTitleBar = super.titleBar;
			setStyle("headerColors", [headerColor1, headerColor2]);
			setStyle("borderColor", borderColor);
			doubleClickEnabled = true;
			
			if (enableResize) {
				resizeHandler.alpha = 0.2;
				resizeHandler.width = 12;
				resizeHandler.height = 12;
				resizeHandler.styleName = "resizeHndlr";
				rawChildren.addChild(resizeHandler);
				initPos();
			}
			
			if (showControls) {
				normalMaxButton.width		= 10;
				normalMaxButton.height		= 10;
				normalMaxButton.styleName	= "increaseBtn";
				closeButton.width			= 10;
				closeButton.height			= 10;
				closeButton.styleName		= "closeBtn";
				pTitleBar.addChild(normalMaxButton);
				pTitleBar.addChild(closeButton);
			}
			
			positionChildren();
			addListeners();
		}
		
		
		
		// ----------------------------------------------------------------------------------------------------
		
		public function initPos():void {
			oW = width;
			oH = height;
			oX = x;
			oY = y;
		}
		
		
		
		// ----------------------------------------------------------------------------------------------------
		
		public function positionChildren():void {
			if (showControls) {
				normalMaxButton.buttonMode	= true;
				normalMaxButton.useHandCursor = true;
				normalMaxButton.x = unscaledWidth - normalMaxButton.width - 24;
				normalMaxButton.y = 8;
				closeButton.buttonMode		= true;
				closeButton.useHandCursor = true;
				closeButton.x = unscaledWidth - closeButton.width - 8;
				closeButton.y = 8;
			}
			
			if (enableResize) {
				resizeHandler.y = unscaledHeight - resizeHandler.height - 1;
				resizeHandler.x = unscaledWidth - resizeHandler.width - 1;
			}
		}
		
		
		
		// ----------------------------------------------------------------------------------------------------
		
		public function addListeners():void {
			addEventListener(MouseEvent.CLICK, panelClickHandler);
			pTitleBar.addEventListener(MouseEvent.MOUSE_DOWN, titleBarDownHandler);
			pTitleBar.addEventListener(MouseEvent.DOUBLE_CLICK, titleBarDoubleClickHandler);
			
			if (showControls) {
				closeButton.addEventListener(MouseEvent.CLICK, closeClickHandler);
				normalMaxButton.addEventListener(MouseEvent.CLICK, normalMaxClickHandler);
			}
			
			if (enableResize) {
				resizeHandler.addEventListener(MouseEvent.MOUSE_OVER, resizeOverHandler);
				resizeHandler.addEventListener(MouseEvent.MOUSE_OUT, resizeOutHandler);
				resizeHandler.addEventListener(MouseEvent.MOUSE_DOWN, resizeDownHandler);
			}
		}
		
		
		
		// ----------------------------------------------------------------------------------------------------
		
		public function panelClickHandler(event:MouseEvent):void {
			pTitleBar.removeEventListener(MouseEvent.MOUSE_MOVE, titleBarMoveHandler);
			parent.setChildIndex(this, parent.numChildren - 1);
			panelFocusCheckHandler();
		}
		
		
		
		// ----------------------------------------------------------------------------------------------------
		
		public function titleBarDownHandler(event:MouseEvent):void {
			pTitleBar.addEventListener(MouseEvent.MOUSE_MOVE, titleBarMoveHandler);
		}
		
		
		
		// ----------------------------------------------------------------------------------------------------
		
		public function titleBarMoveHandler(event:MouseEvent):void {
			if (width < screen.width) {
				Application.application.parent.addEventListener(MouseEvent.MOUSE_UP, titleBarDragDropHandler);
				pTitleBar.addEventListener(DragEvent.DRAG_DROP,titleBarDragDropHandler);
				parent.setChildIndex(this, parent.numChildren - 1);
				panelFocusCheckHandler();
				alpha = 0.5;
				startDrag(false, new Rectangle(0, 0, screen.width - width, screen.height - height));
			}
		}
		
		
		
		// ----------------------------------------------------------------------------------------------------
		
		public function titleBarDragDropHandler(event:MouseEvent):void {
			pTitleBar.removeEventListener(MouseEvent.MOUSE_MOVE, titleBarMoveHandler);
			alpha = 1.0;
			stopDrag();
		}
		
		
		
		// ----------------------------------------------------------------------------------------------------
		
		public function panelFocusCheckHandler():void {
			for (var i:int = 0; i < parent.numChildren; i++) {
				var child:UIComponent = UIComponent(parent.getChildAt(i));
				if (parent.getChildIndex(child) < parent.numChildren - 1) {
					child.setStyle("headerColors", [headerColor1, headerColor2]);
					child.setStyle("borderColor", borderColor);
				} else
				if (parent.getChildIndex(child) == parent.numChildren - 1) {
					child.setStyle("headerColors", [headerColorFocus1, headerColorFocus2]);
					child.setStyle("borderColor", borderColorFocus);
				}
			}
		}
		
		
		
		// ----------------------------------------------------------------------------------------------------
		
		public function titleBarDoubleClickHandler(event:MouseEvent):void {
			pTitleBar.removeEventListener(MouseEvent.MOUSE_MOVE, titleBarMoveHandler);
			Application.application.parent.removeEventListener(MouseEvent.MOUSE_UP, resizeUpHandler);
			
			upMotion.target = this;
			upMotion.duration = 300;
			upMotion.heightFrom = oH;
			upMotion.heightTo = 28;
			upMotion.end();
			
			downMotion.target = this;
			downMotion.duration = 300;
			downMotion.heightFrom = 28;
			downMotion.heightTo = oH;
			downMotion.end();
			
			if (width < screen.width) {
				if (height == oH) {
					upMotion.play();
					resizeHandler.visible = false;
				} else {
					downMotion.play();
					downMotion.addEventListener(EffectEvent.EFFECT_END, endEffectEventHandler);
				}
			}
		}
		
		
		
		// ----------------------------------------------------------------------------------------------------
		
		public function endEffectEventHandler(event:EffectEvent):void {
			resizeHandler.visible = true;
		}
		
		
		
		// ----------------------------------------------------------------------------------------------------
		
		public function normalMaxClickHandler(event:MouseEvent):void {
			if (normalMaxButton.styleName == "increaseBtn") {
				if (height > 28) {
					initPos();
					x = 0;
					y = 0;
					width = screen.width;
					height = screen.height;
					normalMaxButton.styleName = "decreaseBtn";
					positionChildren();
				}
			} else {
				x = oX;
				y = oY;
				width = oW;
				height = oH;
				normalMaxButton.styleName = "increaseBtn";
				positionChildren();
			}
		}
		
		
		
		// ----------------------------------------------------------------------------------------------------
		
		public function closeClickHandler(event:MouseEvent):void {
			removeEventListener(MouseEvent.CLICK, panelClickHandler);
			parent.removeChild(this);
		}
		
		
		
		// ----------------------------------------------------------------------------------------------------
		
		public function resizeOverHandler(event:MouseEvent):void {
			//resizeCur = CursorManager.setCursor(resizeCursor);
		}
		
		
		
		// ----------------------------------------------------------------------------------------------------
		
		public function resizeOutHandler(event:MouseEvent):void {
			CursorManager.removeCursor(CursorManager.currentCursorID);
		}
		
		
		
		// ----------------------------------------------------------------------------------------------------
		
		public function resizeDownHandler(event:MouseEvent):void {
			Application.application.parent.addEventListener(MouseEvent.MOUSE_MOVE, resizeMoveHandler);
			Application.application.parent.addEventListener(MouseEvent.MOUSE_UP, resizeUpHandler);
			resizeHandler.addEventListener(MouseEvent.MOUSE_OVER, resizeOverHandler);
			panelClickHandler(event);
			//resizeCur = CursorManager.setCursor(resizeCursor);
			oPoint.x = mouseX;
			oPoint.y = mouseY;
			oPoint = localToGlobal(oPoint);
		}
		
		
		
		// ----------------------------------------------------------------------------------------------------
		
		public function resizeMoveHandler(event:MouseEvent):void {
			stopDragging();
			
			var xPlus:Number = Application.application.parent.mouseX - oPoint.x;
			var yPlus:Number = Application.application.parent.mouseY - oPoint.y;
			
			if (oW + xPlus > minWidth) {
				width = oW + xPlus;
			}
			
			if (oH + yPlus > minHeight) {
				height = oH + yPlus;
			}
			positionChildren();
		}
		
		// ----------------------------------------------------------------------------------------------------
		
		public function resizeUpHandler(event:MouseEvent):void {
			Application.application.parent.removeEventListener(MouseEvent.MOUSE_MOVE, resizeMoveHandler);
			Application.application.parent.removeEventListener(MouseEvent.MOUSE_UP, resizeUpHandler);
			CursorManager.removeCursor(CursorManager.currentCursorID);
			resizeHandler.addEventListener(MouseEvent.MOUSE_OVER, resizeOverHandler);
			initPos();
		}
		
		// ----------------------------------------------------------------------------------------------------
		
	}
}
