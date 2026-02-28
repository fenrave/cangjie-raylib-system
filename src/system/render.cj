package raylib.system

// import raylib.system.{Color, Camera2D, RenderTexture, Camera3D, Shader, VrStereoConfig, Vector2, Matrix, Ray, Texture, VrDeviceInfo, Vector3}
import std.collection.ArrayList


foreign {
	func ClearBackground(color: Color): Unit
	func BeginDrawing(): Unit
	func EndDrawing(): Unit
	func BeginMode2D(camera: Camera2D): Unit
	func EndMode2D(): Unit
	func BeginMode3D(camera: Camera3D): Unit
	func EndMode3D(): Unit
	func BeginTextureMode(target: RenderTexture): Unit
	func EndTextureMode(): Unit
	func BeginShaderMode(shader: Shader): Unit
	func EndShaderMode(): Unit
	func BeginBlendMode(mode: Int32): Unit
	func EndBlendMode(): Unit
	func BeginScissorMode(x: Int32, y: Int32, width: Int32, height: Int32): Unit
	func EndScissorMode(): Unit
	//-----//

	//-----\\
	func LoadShader(vsFileName: CString, fsFileName: CString): Shader
	func LoadShaderFromMemory(vsCode: CString, fsCode: CString): Shader
	//-----//

	//-----\\
	func IsShaderValid(shader: Shader): Bool
	func GetShaderLocation(Shader: Shader, uniformName: CString): Int32
	func GetShaderLocationAttrib(shader: Shader, attribName: CString): Int32
	func SetShaderValue(shader: Shader, locIndex: Int32, value: CPointer<Unit>, uniformType: Int32): Unit
	func SetShaderValueV(shader: Shader, locIndex: Int32, value: CPointer<Unit>, uniformType: Int32, count: Int32): Unit
	func SetShaderValueMatrix(shader: Shader, locIndex: Int32, mat: Matrix): Unit
	func SetShaderValueTexture(shader: Shader, locIndex: Int32, texture: Texture): Unit
	func UnloadShader(shader: Shader): Unit
	//-----//

	//-----\\
	func GetScreenToWorldRay(position: Vector2, camera: Camera3D): Ray
	func GetScreenToWorldRayEx(position: Vector2, camera: Camera3D, width: Int32, height: Int32): Ray
	func GetWorldToScreen(position: Vector3, camera: Camera3D): Vector2
	func GetWorldToScreenEx(position: Vector3, camera: Camera3D, width: Int32, height: Int32): Vector2
	func GetWorldToScreen2d(position: Vector2, camera: Camera2D): Vector2
	func GetScreenToWorld2d(position: Vector2, camera: Camera2D): Vector2
	func GetCameraMatrix(camera: Camera3D): Matrix
	func GetCameraMatrix2D(camera: Camera2D): Matrix
	//-----//

	//-----\\
	func SetTargetFPS(fps: Int32): Unit
	// func GetFrameTime(): Float32
	func GetTime(): Float64
	func GetFPS(): Int32

	func DrawPixel(posX: Int32, posY: Int32, color: Color): Unit
	func DrawPixelV(position: Vector2, color: Color): Unit
	func DrawLine(startPosX: Int32, startPosY: Int32, endPosX: Int32, endPosY: Int32, color: Color): Unit
	func DrawLineV(startPos: Vector2, endPos: Vector2, color: Color): Unit
	func DrawLineEx(startPos: Vector2, endPos: Vector2, thick: Float32, color: Color): Unit
	func DrawLineStrip(points: CPointer<Vector2>, pointCount: Int32, color: Color): Unit
	func DrawLineBezier(startPos: Vector2, endPos: Vector2, thick: Float32, color: Color): Unit
	func DrawLineDashed(startPos: Vector2, endPos: Vector2, dashSize: Int32, spaceSize: Int32, color: Color): Unit
	func DrawCircle(centerX: Int32, centerY: Int32, radius: Float32, color: Color): Unit
	func DrawCircleSector(center: Vector2, radius: Float32, startAngle: Float32, endAngle: Float32, segments: Int32, color: Color): Unit
	func DrawCircleSectorLines(center: Vector2, radius: Float32, startAngle: Float32, endAngle: Float32, segments: Int32, color: Color): Unit
	func DrawCircleGradient(centerX: Int32, centerY: Int32, radius: Float32, inner: Color, outer: Color): Unit
	func DrawCircleV(center: Vector2, radius: Float32, color: Color): Unit
	func DrawCircleLines(centerX: Int32, centerY: Int32, radius: Float32, color: Color): Unit
	func DrawEllipse(centerX: Int32, centerY: Int32, radiusH: Float32, radiusV: Float32, color: Color): Unit
	func DrawEllipseV(center: Vector2, radiusH: Float32, radiusV: Float32, color: Color): Unit
	func DrawEllipseLines(centerX: Int32, centerY: Int32, radiusH: Float32, radiusV: Float32, color: Color): Unit
	func DrawEllipseLinesV(center: Vector2, radiusH: Float32, radiusV: Float32, color: Color): Unit
	func DrawRing(center: Vector2, innerRadius: Float32, outerRadius: Float32, startAngle: Float32, endAngle: Float32, segments: Int32, color: Color): Unit
	func DrawRingLines(center: Vector2, innerRadius: Float32, outerRadius: Float32, startAngle: Float32, endAngle: Float32, segments: Int32, color: Color): Unit
	func DrawRectangle(posX: Int32, posY: Int32, width: Int32, height: Int32, color: Color): Unit
	func DrawRectangleV(position: Vector2, Size: Vector2, color: Color): Unit
	func DrawRectangleRec(rec: Rectangle, color: Color): Unit
	func DrawRectanglePro(rec: Rectangle, origin: Vector2, rotation: Float32, color: Color): Unit
	func DrawRectangleGradientV(posX: Int32, posY: Int32, width: Int32, height: Int32, top: Color, bottom: Color): Unit
	func DrawRectangleGradientH(posX: Int32, posY: Int32, width: Int32, height: Int32, right: Color, left: Color): Unit
	func DrawRectangleGradientEx(rec: Rectangle, topLeft: Color, bottomLeft: Color, bottomRight: Color, topRight: Color): Unit
	func DrawRectangleLines(posX: Int32, posY: Int32, width: Int32, height: Int32, color: Color): Unit
	func DrawRectangleRounded(rec: Rectangle, roundness: Float32, segments: Int32, color: Color): Unit
	func DrawRectangleRoundedLines(rec: Rectangle, lineThick: Float32, color: Color): Unit
	func DrawRectangleRoundedLinesEx(rec: Rectangle, roundness: Float32, segments: Int32, lineThick: Float32, color: Color): Unit
	func DrawTriangle(v1: Vector2, v2: Vector2, v3: Vector2, color: Color): Unit
	func DrawTriangleLines(v1: Vector2, v2: Vector2, v3: Vector2, color: Color): Unit
	func DrawTriangleFan(points: CPointer<Vector2>, pointCount: Int32, color: Color): Unit
	func DrawTriangleStrip(points: CPointer<Vector2>, pointCount: Int32, color: Color): Int32
	func DrawPoly(center: Vector2, sides: Int32, radius: Float32, rotation: Float32, color: Color): Unit
	func DrawPolyLines(center: Vector2, sides: Int32, radius: Float32, rotation: Float32, color: Color): Unit
	func DrawPolyLinesEx(center: Vector2, sides: Int32, radius: Float32, rotation: Float32, lineThick: Float32, color: Color): Unit

}

private type Callback = (DT: Float32) -> Unit

public class Draw2D {
	public static func drawPixel(X: Int32, Y: Int32, Color: Color): Unit {
		unsafe { DrawPixel(X, Y, Color) }
	}

	public static func drawPixel(Position: Vector2, Color: Color): Unit {
		unsafe { DrawPixelV(Position, Color) }
	}

	public static func drawLine(StartX: Int32, StartY: Int32, EndX: Int32, EndY: Int32, Color: Color): Unit {
		unsafe { DrawLine(StartX, StartY, EndX, EndY, Color) }
	}

	public static func drawLine(Start: Vector2, End: Vector2, Color: Color): Unit {
		unsafe { DrawLineV(Start, End, Color) }
	}

	public static func drawCircle(CenterX: Int32, CenterY: Int32, Radius: Float32, Color: Color): Unit {
		unsafe { DrawCircle(CenterX, CenterY, Radius, Color) }
	}

	public static func drawCircle(Center: Vector2, Radius: Float32, Color: Color): Unit {
		unsafe { DrawCircleV(Center, Radius, Color) }
	}

	public static func drawRectangle(PosX: Int32, PosY: Int32, Width: Int32, Height: Int32, Color: Color): Unit {
		unsafe { DrawRectangle(PosX, PosY, Width, Height, Color) }
	}

	public static func drawRectangle(Pos: Vector2, Size: Vector2, Color: Color): Unit {
		unsafe { DrawRectangleV(Pos, Size, Color) }
	}

	public static func drawRectangle(Rec: Rectangle, Color: Color): Unit {
		unsafe { DrawRectangleRec(Rec, Color) }
	}
}

public class Render2D {
	private static let PRERENDER = ArrayList<Callback>()
	private static let WHILERENDER = ArrayList<Callback>()
	private static let POSTRENDER = ArrayList<Callback>()

	/*
	-V----------------V-
	|0 -> 	preRender
	|1 -> 	whileRender
	|2 -> 	postRender
	--------------------
	*/
	public static func bindTo(SchedulerState!: Int32 = 1, OnState!: Callback): Unit {
		match (SchedulerState) {
			case 0 => PRERENDER.add(OnState)
			case 1 => WHILERENDER.add(OnState)
			case 2 => POSTRENDER.add(OnState)
			case _ => throw Exception("${SchedulerState} is not a valid state")
		}
	}

	public static var mainCamera: Camera2D = Camera2D()

	public unsafe static func draw(): Unit {
		let DT: Float32 = GetFrameTime()

		for (PRECB in PRERENDER) { PRECB(DT) }

		BeginMode2D(mainCamera)

		for (WHILECB in WHILERENDER) { WHILECB(DT) }

		EndMode2D()

		for (POSTCB in POSTRENDER) { POSTCB(DT) }
	}

}

public class Render3D {
	private static let PRERENDER = ArrayList<Callback>()
	private static let WHILERENDER = ArrayList<Callback>()
	private static let POSTRENDER = ArrayList<Callback>()

	/*
	-V----------------V-
	|0 -> 	preRender
	|1 -> 	whileRender
	|2 -> 	postRender
	--------------------
	*/
	public static func bindTo(SchedulerState!: Int32 = 1, OnState!: Callback): Unit {
		match (SchedulerState) {
			case 0 => PRERENDER.add(OnState)
			case 1 => WHILERENDER.add(OnState)
			case 2 => POSTRENDER.add(OnState)
			case _ => throw Exception("${SchedulerState} is not a valid state")
		}
	}

	public static var mainCamera3D: Camera3D = Camera3D()

	public unsafe static func draw(): Unit {
		let DT: Float32 = GetFrameTime()

		for (PRECB in PRERENDER) { PRECB(DT) }


		BeginMode3D(mainCamera3D)

		for (WHILECB in WHILERENDER) { WHILECB(DT) }

		EndMode3D()

		for (POSTCB in POSTRENDER) { POSTCB(DT) }
	}
}

public class RenderGlobal {
	public static var bgColor: Color = Color(0,0,0,255)
}

public class Scheduler {
	public mut static prop frameRate: Int32 {
		get() { return unsafe { GetFPS() } }

		set(newFrameRate) {
			unsafe { SetTargetFPS(newFrameRate) }
		}
	}

	public static func start(InitFrameRate!: Int32 = 60): Unit {
		frameRate = InitFrameRate

		unsafe { while (!WindowShouldClose()) {
				BeginDrawing()
				ClearBackground(RenderGlobal.bgColor)
				Render3D.draw()
				Render2D.draw()
				EndDrawing()
			}
		}
	}
}