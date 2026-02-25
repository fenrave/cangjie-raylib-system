package raylib.system

// import raylib.system.{Image, Vector2, IntVector2, ConfigFlags}
import std.collection.{ArrayList}

foreign {
	func InitWindow(width: Int32, height: Int32, title: CString): Unit
	func CloseWindow(): Unit
	func WindowShouldClose(): Bool
	func IsWindowReady(): Bool
	func IsWindowFullscreen(): Bool
	func IsWindowHidden(): Bool
	func IsWindowMinimized(): Bool
	func IsWindowMaximized(): Bool
	func IsWindowFocused(): Bool
	func IsWindowResized(): Bool
	func IsWindowState(flag: Int32): Bool
	func SetWindowState(flag: Int32): Unit
	func ClearWindowState(flag: Int32): Unit
	func ToggleFullscreen(): Unit
	func ToggleBorderlessWindowed(): Unit
	func MaximizeWindow(): Unit
	func MinimizeWindow(): Unit
	func RestoreWindow(): Unit
	func SetWindowIcon(image: Image): Unit
	func SetWindowTitle(title: CString): Unit
	func SetWindowPosition(x: Int32, y: Int32): Unit
	func SetWindowMonitor(monitor: Int32): Unit
	func SetWindowMinSize(width: Int32, height: Int32): Unit
	func SetWindowMaxSize(width: Int32, height: Int32): Unit
	func SetWindowSize(width: Int32, height: Int32): Unit
	func SetWindowOpacity(opacity: Float32): Unit
	func SetWindowFocused(): Unit
	func GetWindowHandle(): CPointer<Unit>
	func GetWindowPosition(): Vector2
	func GetWindowScaleDPI(): Vector2
	func GetCurrentMonitor(): Int32
	func GetScreenWidth(): Int32
	func GetScreenHeight(): Int32
	func GetRenderWidth(): Int32
	func GetRenderHeight(): Int32
	func GetMonitorCount(): Int32
	func GetMonitorPosition(monitor: Int32): Vector2
	func GetMonitorWidth(monitor: Int32): Int32
	func GetMonitorHeight(monitor: Int32): Int32
	func GetMonitorPhysicalWidth(monitor: Int32): Int32
	func GetMonitorPhysicalHeight(monitor: Int32): Int32
	func GetMonitorRefreshRate(monitor: Int32): Int32
	func GetMonitorName(monitor: Int32): CString
}

private type Callback = () -> Unit

// cjlint-ignore -start !G.NAM.05
/*
---------------------------
non-callable static class

methods are called by type
---------------------------
*/
public class Window {
	//--------------------------------------------------------//
	//These properties do not store any localized state.
	//These can all be determined independently of the program itself, which could lead to problems.

	public static prop shouldClose: Bool {
		get() {
			return unsafe { WindowShouldClose() }
		}
	}

	public static prop isHidden: Bool {
		get() {
			return unsafe { IsWindowHidden() }
		}
	}

	public static prop isReady: Bool {
		get() {
			return unsafe { IsWindowReady() }
		}
	}

	public static prop isResized: Bool {
		get() {
			return unsafe { IsWindowResized() }
		}
	}

	//---------------------//
	public static mut prop maximized: Bool {
		get() {
			return unsafe { IsWindowMaximized() }
		}
		set(value) {
			unsafe { if (!maximized && value) {
				MaximizeWindow()
			} else {
				ClearWindowState(ConfigFlags.WINDOW_MAXIMIZED)
			} }
		}
	}

	public static mut prop minimized: Bool {
		get() {
			return unsafe { IsWindowMinimized() }
		}
		set(value) {
			unsafe { if (!minimized && value) {
				MinimizeWindow()
			} else {
				ClearWindowState(ConfigFlags.WINDOW_MINIMIZED)
			} }
		}
	}

	public static mut prop fullScreen: Bool {
		get() {
			return unsafe { IsWindowFullscreen() }
		}
		set(value) {
			unsafe { if (!fullScreen && value) {
				ToggleFullscreen()
			} else {
				ClearWindowState(ConfigFlags.FULLSCREEN_MODE)
			} }
		}
	}

	public static mut prop borderless: Bool {
		get() {
			return unsafe { IsWindowState(ConfigFlags.BORDERLESS_WINDOWED_MODE) }
		}
		set(value) {
			unsafe { if (!borderless && value) {
				ToggleBorderlessWindowed()
			} else {
				ClearWindowState(ConfigFlags.BORDERLESS_WINDOWED_MODE)
			} }
		}
	}

	public static mut prop focused: Bool {
		get() {
			return unsafe { IsWindowFocused() }
		}
		set(value) {
			unsafe { if (!focused && value) {
				SetWindowFocused()
			} else {
				SetWindowState(ConfigFlags.WINDOW_UNFOCUSED)
			} }
		}
	}

	public static func checkState(flag: Int32): Bool {
		return unsafe { IsWindowState(flag) }
	}

	public static mut prop monitor: Int32 {
		get() {
			return unsafe { GetCurrentMonitor() }
		}
		set(value) {
			unsafe { SetWindowMonitor(value) }
		}
	}

	//This property does not work properly on Wayland Linux as of February 2026
	//Work is being done to provide support for setting/getting position,
	//And it should have support by the end of the year on all up to date distributions of Linux with Wayland.
	public static mut prop position: Vector2 {
		get() {
			return unsafe { GetWindowPosition() }
		}
		set(value) {
			//This may also work presently if the chosen backend (SDL, RGFW, GLFW) support the Wayland Ext Zones protocol
			//on a desktop environment which currently bundles support for the protocol via an Extension, such as KDE.
			unsafe { SetWindowPosition(Int32(value.x), Int32(value.y)) }
		}
	}

	public static prop screenWidth: Int32 {
		get() {
			return unsafe { GetScreenWidth() }
		}
	}

	public static prop screenHeight: Int32 {
		get() {
			return unsafe { GetScreenHeight() }
		}
	}

	public static prop renderWidth: Int32 {
		get() {
			return unsafe { GetRenderWidth() }
		}
	}

	public static prop renderHeight: Int32 {
		get() {
			return unsafe { GetRenderHeight() }
		}
	}

	public static prop monitorCount: Int32 {
		get() {
			return unsafe { GetMonitorCount() }
		}
	}

	public static prop monitorWidth: Int32 {
		get() {
			return unsafe { GetMonitorWidth(monitor) }
		}
	}

	public static prop monitorHeight: Int32 {
		get() {
			return unsafe { GetMonitorHeight(monitor) }
		}
	}

	public static prop monitorPosition: Vector2 {
		get() {
			return unsafe { GetMonitorPosition(monitor) }
		}
	}

	public static prop monitorPhysicalDimensions: IntVector2 {
		get() {
			return unsafe { IntVector2(GetMonitorPhysicalHeight(monitor), GetMonitorPhysicalWidth(monitor)) }
		}
	}

	public static prop refreshRate: Int32 {
		get() {
			return unsafe { GetMonitorRefreshRate(monitor) }
		}
	}

	public static prop monitorName: CString {
		get() {
			return unsafe { GetMonitorName(monitor) }
		}
	}
	//--------------------------------------------------------//
	private static var InternalMinSize = IntVector2(0, 0)
	public static mut prop minSize: IntVector2 {
		get() {
			return InternalMinSize
		}
		set(value) {
			unsafe { SetWindowMinSize(value.x, value.y) }
			InternalMinSize = value
		}
	}

	private static var InternalMaxSize = IntVector2(7680, 4320)
	public static mut prop maxSize: IntVector2 {
		get() {
			return InternalMaxSize
		}
		set(value) {
			unsafe { SetWindowMaxSize(value.x, value.y) }
			InternalMaxSize = value
		}
	}

	private static var InternalIcon = Image()
	public static mut prop icon: Image {
		get() {
			return InternalIcon
		}
		set(Img) {
			unsafe { SetWindowIcon(Img) }
			InternalIcon = Img
		}
	}

	private static var InternalWindowSize = IntVector2(0, 0)
	public static mut prop windowSize: IntVector2 {
		get() {
			return InternalWindowSize
		}
		set(value) {
			unsafe { SetWindowSize(value.x, value.y) }
			InternalWindowSize.x = value.x
			InternalWindowSize.y = value.y
		}
	}

	private static var InternalOpacity: Float32 = 0.0
	public static mut prop opacity: Float32 {
		get() {
			return InternalOpacity
		}
		set(value) {
			unsafe { SetWindowOpacity(value) }
			InternalOpacity = value
		}
	}

	private static var InternalAllocTitle: CString = unsafe { LibC.mallocCString("") }
	private static var InternalTitle: String = ""
	public static mut prop title: String {
		get() {
			return InternalTitle
		}
		set(value) {
			InternalTitle = value
			InternalAllocTitle = unsafe { LibC.mallocCString(value) }
			unsafe { SetWindowTitle(InternalAllocTitle) }
		}
	}
	//--------------------------------------------------------//

	private static let Openers = ArrayList<Callback>()
	private static let Closers = ArrayList<Callback>()
	private static func invoke(Arr: ArrayList<Callback>) {
		for (callback in Arr) {
			callback()
		}
	}

	public static func bindToOpen(fn: Callback): Unit {
		Openers.add(fn)
	}

	public static func bindToClose(fn: Callback): Unit {
		Closers.add(fn)
	}

	public static func open(Size: IntVector2, WindowTitle: String): CPointer<Unit> {
		InternalWindowSize = Size

		InternalTitle = WindowTitle
		unsafe {
			InitWindow(
				InternalWindowSize.x,
				InternalWindowSize.y,
				InternalAllocTitle
			)
		}
		invoke(Openers)
		return unsafe { GetWindowHandle() }
	}

	public static func open(X: Int32, Y: Int32, WindowTitle: String): CPointer<Unit> {
		InternalWindowSize = IntVector2(X, Y)

		InternalTitle = WindowTitle
		unsafe {
			InitWindow(
				InternalWindowSize.x,
				InternalWindowSize.y,
				InternalAllocTitle
			)
		}
		invoke(Openers)
		return unsafe { GetWindowHandle() }
	}

	public static func open(Size: (Int32, Int32), WindowTitle: String): CPointer<Unit> {
		InternalWindowSize = IntVector2(Size[0], Size[1])

		InternalTitle = WindowTitle
		unsafe {
			InitWindow(
				InternalWindowSize.x,
				InternalWindowSize.y,
				InternalAllocTitle
			)
		}
		invoke(Openers)
		return unsafe { GetWindowHandle() }
	}

	public static func close(): Unit {
		unsafe { CloseWindow() }
	}
}

// cjlint-ignore -end
