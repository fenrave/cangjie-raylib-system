package rayl.system

foreign {
	func InitWindow(width: Int32, height: Int32, title: CString): Unit
	func CloseWindow(): Unit
	func WindowShouldClose(): Bool
	func IsWindowReady(): Bool
	func IsWindowFullScreen(): Bool
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
	//-----//

	//-----\\
	func SetWindowIcon(image: Image): Unit
	func SetWindowIcons(image: CPointer<Image>, count: Int32): Unit
	func SetWindowTitle(title: CString): Unit
	// V currently does not work on wayland linux, but will sometime in mid 2026
	func SetWindowPosition(x: Int32, y: Int32): Unit
	func SetWindowMonitor(monitor: Int32): Unit
	func SetWindowMinSize(width: Int32, height: Int32): Unit
	func SetWindowMaxSize(width: Int32, height: Int32): Unit
	func SetWindowSize(width: Int32, height: Int32): Unit
	func SetWindowOpacity(opacity: Float32): Unit
	func SetWindowFocused(): Unit
	func GetWindowHandle(): CPointer<Unit>
	func GetScreenWidth(): Int32
	func GetScreenHeight(): Int32
	func GetRenderWidth(): Int32
	func GetRenderHeight(): Int32
	func GetMonitorCount(): Int32
	func GetCurrentMonitor(): Int32
	func GetMonitorPosition(monitor: Int32): Vector2
	func GetMonitorWidth(monitor: Int32): Int32
	func GetMonitorHeight(monitor: Int32): Int32
	func GetMonitorPhysicalWidth(monitor: Int32): Int32
	func GetMonitorPhysicalHeight(monitor: Int32): Int32
	func GetMonitorRefreshRate(monitor: Int32): Int32
	func GetWindowPosition(): Vector2
	func GetWindowScaleDPI(): Vector2
	func GetMonitorName(monitor: Int32): CString
}

public struct IntVector2 {
    var x = 0_i32
    var y = 0_i32
}

public class Window {
    private var InternalSize = IntVector2()
    public mut prop WindowSize: IntVector2 {
        get() {
            return InternalSize
        }

        set(value) {
            unsafe { SetWindowSize(value.x, value.y) }
            InternalSize.x = value.x
            InternalSize.y = value.y
        }
    }

    private var InternalOpacity = 0.0_f32
    public mut prop Opacity: Float32 {
        get() {
            return InternalOpacity
        }

        set(value) {
            unsafe { SetWindowOpacity(value) }
            InternalOpacity = value
        }
    }

    private var InternalAllocTitle: CString = unsafe { LibC.mallocCString("") }
    private var InternalTitle: String = ""
    public mut prop Title: String {
        get() {
            return InternalTitle
        }

        set(value) {
            InternalTitle = value
            InternalAllocTitle = unsafe { LibC.mallocCString(Title) }
            unsafe {SetWindowTitle(InternalAllocTitle)}
        }
    }

    public func OpenWindow(Size: IntVector2, WindowTitle: String): CPointer<Unit> {
        InternalSize = Size

        InternalTitle = WindowTitle

        unsafe { InitWindow(InternalSize.x, InternalSize.y, InternalAllocTitle) }

        return unsafe { GetWindowHandle() }
    }
}

let window2 = Window()