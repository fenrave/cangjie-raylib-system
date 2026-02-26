package raylib.system

// import raylib.system.{Vector2, IntVector2}
import std.collection.ArrayList

foreign {
	func IsKeyPressed(key: Int32): Bool
	func IsKeyPressedRepeat(key: Int32): Bool
	func IsKeyDown(key: Int32): Bool
	func IsKeyReleased(key: Int32): Bool
	func IsKeyUp(key: Int32): Bool
	func GetKeyPressed(): Int32
	func GetCharPressed(): Int32
	// func GetKeyName(key: Int32): CString
	func SetExitKey(key: Int32): Unit
	//-----//

	//-----\\
	//unused
	// func IsGamepadAvailable(gamepad: Int32): Bool
	// func GetGamepadName(gamepad: Int32): CString
	// func IsGamePadButtonPressed(gamepad: Int32, button: Int32): Bool
	// func IsGamepadButtonDown(gamepad: Int32, button: Int32): Bool
	// func IsGamepadButtonReleased(gamepad: Int32, button: Int32): Bool
	// func IsGamepadButtonUp(gamepad: Int32, button: Int32): Bool
	// func GetGamepadButtonPressed(): Int32
	// func GetGamepadAxisCount(gamepad: Int32): Int32
	// func GetGamepadAxisMovement(gamepad: Int32, axis: Int32): Float32
	// func SetGamepadMappings(mappings: CString): Int32
	// func SetGamepadVibration(gamepad: Int32, leftMotor: Float32, rightMotor: Float32, duration: Float32): Unit
	///-----//

	//-----\\
	func IsMouseButtonPressed(button: Int32): Bool
	func IsMouseButtonDown(button: Int32): Bool
	func IsMouseButtonReleased(button: Int32): Bool
	func IsMouseButtonUp(button: Int32): Bool
	func GetMouseX(): Int32
	func GetMouseY(): Int32
	func GetMousePosition(): Vector2
	func GetMouseDelta(): Vector2
	func SetMousePosition(x: Int32, y: Int32): Unit
	func SetMouseOffset(offsetX: Int32, offsetY: Int32): Unit
	func SetMouseScale(scaleX: Float32, scaleY: Float32): Unit
	func GetMouseWheelMove(): Float32
	func GetMouseWheelMoveV(): Vector2
	func SetMouseCursor(cursor: Int32): Unit
	//-----//

	//-----\\
	// func GetTouchX(): Int32
	// func GettouchY(): Int32
	// func GetTouchPosition(index: Int32): Vector2
	// func GetTouchPointId(index: Int32): Int32
	// func GetTouchPointCount(): Int32
	//-----//

	//-----\\
	// func SetGesturesEnabled(flags: UInt32): Unit
	// func IsGestureDetected(gesture: UInt32): Bool
	// func GetGestureDetected(): Int32
	// func GetGestureHoldDuration(): Float32
	// func GetGestureDragVector(): Vector2
	// func GetGestureDragAngle(): Float32
	// func GetGesturePinchAngle(): Float32

	func GetFrameTime(): Float32
}

private type Callback = (DT: Float32) -> Unit

// callable non-static class with static members
open class Input {
	protected static let DEFAULTCB = { _: Float32 => }
	protected static let KEYREGISTER = ArrayList<KeyInput>()
	protected static let MOUSEREGISTER = ArrayList<MouseInput>()

	protected let onDown: Callback
	protected let onUp: Callback

	public let keyCode: Int32

	init(Key: Int32, Down: Callback, Up: Callback) {
		keyCode = Key
		onDown = Down
		onUp = Up
	}
}

public class KeyInput <: Input {
	public static func check(DeltaTime!: Float32 = unsafe{ GetFrameTime() }): Unit {
		for (InputObj in KEYREGISTER) {
			let key: Int32 = InputObj.keyCode

			unsafe {
				if (IsKeyDown(key)) { InputObj.onDown(DeltaTime) }
				if (IsKeyUp(key)) { InputObj.onUp(DeltaTime) }
			}
		}
	}

	public init(
		Key!: Int32,
		Down!:	Callback = DEFAULTCB,
		Up!:	Callback = DEFAULTCB
		) {
		super(Key, Down, Up)
		KEYREGISTER.add(this)
	}
}

public class MouseInput <: Input {
	public static func check(DeltaTime!: Float32 = unsafe{ GetFrameTime() }): Unit {
		for (InputObj in KEYREGISTER) {
			let key: Int32 = InputObj.keyCode

			unsafe {
				if (IsMouseButtonDown(key)) { InputObj.onDown(DeltaTime) }
				if (IsMouseButtonUp(key)) { InputObj.onUp(DeltaTime) }
			}
		}
	}

	private static var InternalMouseOffset: IntVector2 = IntVector2(0,0)
	public static mut prop MouseOffset: IntVector2 {
		get() { return InternalMouseOffset }

		set(Offset) {
			unsafe { SetMouseOffset(Offset.x, Offset.y) }
			InternalMouseOffset = Offset
		}
	}

	private static var InternalMouseScale: Vector2 = Vector2(0.0,0.0)
	public static mut prop MouseScale: Vector2 {
		get() { return InternalMouseScale }

		set(Offset) {
			unsafe { SetMouseScale(Offset.x, Offset.y) }
			InternalMouseScale = Offset
		}
	}

	public static mut prop MousePosition: IntVector2 {
		get() { return unsafe { IntVector2(GetMouseX(), GetMouseY()) } }

		set(Position) {
			unsafe { SetMousePosition(Position.x, Position.y)}
		}
	}

	public static prop MOUSEWHEELMOVE: Vector2 {
		get() { return unsafe { GetMouseWheelMoveV() } }
	}

	public static prop MOUSEDELTA: Vector2 {
		get() { return unsafe { GetMouseDelta() } }
	}

	public init(
		Key!: Int32,
		Down!:	Callback = DEFAULTCB,
		Up!:	Callback = DEFAULTCB
		) {
		super(Key, Down, Up)
		MOUSEREGISTER.add(this)
	}
}

public class InputGlobal {
	private static var AssignedExitKey: Int32 = Keyboard.ESCAPE
	public static mut prop ExitKey: Int32 {
		get() { return AssignedExitKey }

		set(NewKey) {
			unsafe { SetExitKey(NewKey) }
			AssignedExitKey = NewKey
		}
	}

	public static prop CURRENTINPUT: Int32 {
		get() { return unsafe { GetKeyPressed() } }
	}

	public static prop CURRENTINPUTCHAR: Int32 {
		get() { return unsafe { GetCharPressed() } }
	}

	public func setCursor(Cursor: Int32): Unit {
		unsafe { SetMouseCursor(Cursor) }
	}
}