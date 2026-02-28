package raylib.system

/*

	All public structs were added recursively as I wrote out the functions, there might be some inconsistent formatting that needs to be rectified.
	There may also be missing(?) public structs, but all of the ones that the functions depend on are in here.

	public structs with proper public initializers are ones I've "personally" deemed to be ones meant to be conpublic structed by the end user, as I didn't want to write out them all out.
	Presently I am unaware of a better way to "quickly" public initialize a public struct, as far as I can tell, ->
	-> you're supposed to either turn them into a public function or just do the public initializer thing.

*/


@C public struct Color {
	public var r: UInt8 = 0
	public var g: UInt8 = 0
	public var b: UInt8 = 0
	public var a: UInt8 = 255

	public init(R: UInt8, G: UInt8, B: UInt8, A: UInt8) {
		r = R
		g = G
		b = B
		a = A
	}

	public init() {}
}

@C public struct Rectangle {
	public var x: Float32 = 0.0
	public var y: Float32 = 0.0
	public var width: Float32 = 0.0
	public var height: Float32 = 0.0

	public mut prop Position: Vector2 {
		get() { return Vector2(this.x, this.y) }

		set(NewPos) {
			this.x = NewPos.x
			this.y = NewPos.y
		}
	}

	public init(X: Float32, Y: Float32, Width: Float32, Height: Float32) {
		x = X
		y = Y
		width = Width
		height = Height
	}
}

@C public struct Vector2 {
	public var x: Float32 = 0.0
	public var y: Float32 = 0.0

	public init(X: Float32, Y: Float32) {
		x = X
		y = Y
	}
}

@C public struct Vector3 {
	public var x: Float32 = 0.0
	public var y: Float32 = 0.0
	public var z: Float32 = 0.0
	public init(X: Float32, Y: Float32, Z: Float32) {
		x = X
		y = Y
		z = Z
	}
}

@C public struct Vector4 {
	public var x: Float32 = 0.0
	public var y: Float32 = 0.0
	public var z: Float32 = 0.0
	public var w: Float32 = 0.0
	public init(X: Float32, Y: Float32, Z: Float32, W: Float32) {
		x = X
		y = Y
		z = Z
		w = W
	}
}

type Quaternion = Vector4

@C public struct Matrix {
	public var m0: Float32
	public var m1: Float32
	public var m2: Float32
	public var m3: Float32
	public var m4: Float32
	public var m5: Float32
	public var m6: Float32
	public var m7: Float32
	public var m8: Float32
	public var m9: Float32
	public var m10: Float32
	public var m11: Float32
	public var m12: Float32
	public var m13: Float32
	public var m14: Float32
	public var m15: Float32

	public init(
		M0: Float32, M1: Float32, M2: Float32,
		M3: Float32, M4: Float32, M5: Float32,
		M6: Float32, M7: Float32, M8: Float32,
		M9: Float32, M10: Float32, M11: Float32,
		M12: Float32, M13: Float32, M14: Float32,
		M15: Float32) {
		m0 = M0 ; m1 = M1 ; m2 = M2
		m3 = M3 ; m4 = M4 ; m5 = M5
		m6 = M6 ; m7 = M7 ; m8 = M8
		m9 = M9 ; m10 = M10 ; m11 = M11
		m12 = M12 ; m13 = M13 ; m14 = M14
		m15 = M15

	}
}


@C public struct Ray {
	public var position: Vector3 = Vector3(0.0,0.0,0.0)
	public var direction: Vector3 = Vector3(0.0,0.0,0.0)
	public init(p: Vector3, d: Vector3) {
		position = p
		direction = d
	}
}

@C public struct RayCollision {
	public var hit: Bool = false
	public var distance: Float32 = 0.0
	public var point: Vector3 = Vector3(0.0,0.0,0.0)
	public var normal: Vector3 = Vector3(0.0,0.0,0.0)
}

@C public struct Camera2D {
	public var offset: Vector2 = Vector2(0.0, 0.0)
	public var target: Vector2 = Vector2(0.0, 0.0)
	public var rotation: Float32 = 0.0
	public var zoom: Float32 = 1.0

	public init(Offset: Vector2, Target: Vector2, Rotation: Float32, Zoom: Float32) {
		offset = Offset
		target = Target
		rotation = Rotation
		zoom = Zoom
	}

	public init() {}
}

@C public struct Camera3D {
	public var position: Vector3 = Vector3(0.0,0.0,0.0)
	public var target: Vector3 = Vector3(0.0,0.0,0.0)
	public var up: Vector3 = Vector3(0.0,0.0,0.0)
	public var fovy: Float32 = 0.0
	public var projection: Int32 = 0

	public init(P: Vector3, T: Vector3, U: Vector3, F: Float32, PR: Int32) {
		position = P
		target = T
		up = U
		fovy = F
		projection = PR
	}

	public init() {}
}

type Camera = Camera3D

@C public struct Image {
	public var data: CPointer<Unit> = CPointer<Unit>()
	public var width: Int32 = 0
	public var height: Int32 = 0
	public var mipmaps: Int32 = 0
	public var format: Int32 = 0
}

@C public struct Texture {
	public var id: UInt32 = 0
	public var width: Int32 = 0
	public var height: Int32 = 0
	public var mipmaps: Int32 = 0
	public var format: Int32 = 0
}

type Texture2D = Texture
type TextureCubemap = Texture

@C public struct RenderTexture {
	public var id: UInt32 = 0
	public var texture: Texture = Texture()
	public var depth: Texture = Texture()
}

type RenderTexture2D = RenderTexture

@C public struct Shader {
	public var id: UInt32 = 0
	public var locs: CPointer<Int32> = CPointer<Int32>()
}

@C public struct Mesh {
	public var vertexCount: Int32 = 0
	public var triangleCount: Int32 = 0
	
	public var vertices: CPointer<Float32> = CPointer<Float32>()
	public var texcoords: CPointer<Float32> = CPointer<Float32>()
	public var texcoords2: CPointer<Float32> = CPointer<Float32>()
	public var normals: CPointer<Float32> = CPointer<Float32>()
	public var tangents: CPointer<Float32> = CPointer<Float32>()

	public var colors: CPointer<UInt8> = CPointer<UInt8>()
	public var indices: CPointer<UInt16> = CPointer<UInt16>()

	public var animVertices: CPointer<Float32> = CPointer<Float32>()
	public var animNormals: CPointer<Float32> = CPointer<Float32>()
	public var boneIds: CPointer<UInt8> = CPointer<UInt8>()
	public var boneWeights: CPointer<Float32> = CPointer<Float32>()
	public var boneMatrices: CPointer<Float32> = CPointer<Float32>()
	public var boneCount: Int32 = 0

	public var vaoId: UInt32 = 0
	public var vboId: CPointer<UInt32> = CPointer<UInt32>()
}

@C public struct MaterialMap {
	public var texture: Texture2D = Texture2D()
	public var color: Color = Color(0,0,0,255)
	public var value: Float32 = 0.0
}

@C public struct Material {
	public var shader: Shader = Shader()
	public var maps: CPointer<MaterialMap> = CPointer<MaterialMap>()
	public var params: VArray<Float32, $4> = VArray<Float32, $4>(repeat: 0.0)
}

@C public struct BoundingBox {
	public var min: Vector3 = Vector3(0.0,0.0,0.0)
	public var max: Vector3 = Vector3(0.0,0.0,0.0)
}

@C public struct Transform {
	public var translation: Vector3 = Vector3(0.0,0.0,0.0)
	public var rotation: Quaternion = Quaternion(0.0,0.0,0.0,0.0)
	public var scale: Vector3 = Vector3(0.0,0.0,0.0)
}

@C public struct BoneInfo {
	public var name: VArray<UInt8, $32> = VArray<UInt8, $32>(repeat: 0)
	public var parent: Int32 = 0
}

@C public struct Model {
	public var transform: Matrix = unsafe { zeroValue<Matrix>() }

	public var meshCount: Int32 = 0
	public var materialCount: Int32 = 0
	public var meshes: CPointer<Mesh> = CPointer<Mesh>()
	public var materials: CPointer<Material> = CPointer<Material>()
	public var meshMaterial: Int32 = 0

	public var boneCount: Int32 = 0
	public var bones: CPointer<BoneInfo> = CPointer<BoneInfo>()
	public var bindPose: CPointer<Transform> = CPointer<Transform>()

}

@C public struct ModelAnimation {
	public var name: VArray<UInt8, $32> = VArray<UInt8, $32>(repeat: 0)

	public var boneCount: Int32 = 0
	public var frameCount: Int32 = 0
	public var bones: CPointer<BoneInfo> = CPointer<BoneInfo>()
	public var framePoses: CPointer<CPointer<Transform>> = CPointer<CPointer<Transform>>()
}

@C public struct NPatchInfo {
	public var source: Rectangle = Rectangle(0.0,0.0,0.0,0.0)
	public var left: Int32 = 0
	public var top: Int32 = 0
	public var right: Int32 = 0
	public var bottom: Int32 = 0
	public var layout: Int32 = 0

	public init(Source: Rectangle, Left: Int32, Top: Int32, Right: Int32, Bottom: Int32, Layout: Int32) {
	source = Source
	left = Left
	top = Top
	right = Right
	bottom = Bottom
	layout = Layout
	}
}

@C public struct VrDeviceInfo {
	public var hResolution: Int32 = 0
	public var vResolution: Int32 = 0
	public var hScreenSize: Float32 = 0.0
	public var vScreenSize: Float32 = 0.0
	public var eyeToScreenDistance: Float32 = 0.0
	public var lensSeparationDistance: Float32 = 0.0
	public var interpupillaryDistance: Float32 = 0.0
	public var lensDistortionValues: VArray<Float32, $4> = VArray<Float32, $4>(repeat: 0.0)
	public var chromaAbcorrection: VArray<Float32, $4> = VArray<Float32, $4>(repeat: 0.0)
}

@C public struct VrStereoConfig {
	public var projection: VArray<Matrix, $2> = VArray<Matrix, $2>(repeat: unsafe { zeroValue<Matrix>() })
	public var viewOffset: VArray<Matrix, $2> = VArray<Matrix, $2>(repeat: unsafe { zeroValue<Matrix>() })
	public var leftLensCenter: VArray<Float32, $2> = VArray<Float32, $2>(repeat: 0.0)
	public var rightLensCenter: VArray<Float32, $2> = VArray<Float32, $2>(repeat: 0.0)
	public var leftScreenCenter: VArray<Float32, $2> = VArray<Float32, $2>(repeat: 0.0)
	public var rightScreenCenter: VArray<Float32, $2> = VArray<Float32, $2>(repeat: 0.0)
	public var scale: VArray<Float32, $2> = VArray<Float32, $2>(repeat: 0.0)
	public var scaleIn: VArray<Float32, $2> = VArray<Float32, $2>(repeat: 0.0)
}

@C public struct FilePathList {
	public var count: UInt32 = 0
	public var paths: CPointer<CString> = unsafe { zeroValue<CPointer<CString>>() }
}

@C public struct AutomationEvent {
	public var frame: UInt32 = 0
	//uppercased because 'type' is a reserved keyword
	public var Type: UInt32 = 0
	public var params: VArray<Int32, $4> = VArray<Int32, $4>(repeat: 0)
}

@C public struct AutomationEventList {
	public var capacity: UInt32 = 0
	public var count: UInt32 = 0
	public var events: CPointer<AutomationEventList> = CPointer<AutomationEventList>()
}

@C public struct GlyphInfo {
	public var value: Int32 = 0
	public var offsetX: Int32 = 0
	public var offsetY: Int32 = 0
	public var advanceX: Int32 = 0
	public var image: Image = Image()
}

@C public struct Font {
	public var baseSize: Int32 = 0
	public var glyphCount: Int32 = 0
	public var glyphPadding: Int32 = 0
	public var texture: Texture2D = Texture2D()
	public var recs: CPointer<Rectangle> = CPointer<Rectangle>()
	public var glyphs: CPointer<GlyphInfo> = CPointer<GlyphInfo>()
}

type AudioCallback = CFunc<(bufferData: CPointer<Unit>, frames: UInt32) -> Unit>

@C public struct Wave {
	public var frameCount: UInt32 = 0
	public var sampleRate: UInt32 = 0
	public var sampleSize: UInt32 = 0
	public var channels: UInt32 = 0
	public var data: CPointer<Unit> = CPointer<Unit>()
}

@C public struct AudioStream {
	public var buffer: CPointer<Unit> = CPointer<Unit>()
	public var processor: CPointer<Unit> = CPointer<Unit>()

	public var sampleRate: UInt32 = 0
	public var sampleSize: UInt32 = 0
	public var channels: UInt32 = 0
}

@C public struct Sound {
	public var stream: AudioStream = AudioStream()
	public var frameCount: UInt32 = 0
}

@C public struct Music {
	public var stream: AudioStream = AudioStream()
	public var frameCount: UInt32 = 0
	public var looping: Bool = false

	public var ctxType: Int32 = 0
	public var ctxData: CPointer<Unit> = CPointer<Unit>()
}

//-----------------------------------------------------//

public struct IntVector2 {
	public var x: Int32 = 0_i32
	public var y: Int32 = 0_i32

	public init(X: Int32, Y: Int32) {
		x = X
		y = Y
	}
}
