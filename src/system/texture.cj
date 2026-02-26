package raylib.system

foreign {
	func SetShapesTexture(texture: Texture2D, source: Rectangle): Unit
	func GetShapesTexture(): Texture2D
	func GetShapesTextureRectangle(): Rectangle

	func LoadImage(fileName: CString): Image
	func LoadImageRaw(fileName: CString, width: Int32, height: Int32, format: Int32, headerSize: Int32): Image
	func LoadImageAnim(fileName: CString, frames: CPointer<Int32>): Image
	func LoadImageAnimFromMemory(fileType: CString, fileData: CString, dataSize: Int32, frames: CPointer<Int32>): Image
	func LoadImageFromTexture(texture: Texture2D): Image
	func LoadImageFromScreen(): Image
	func IsImageValid(image: Image): Bool
	func UnloadImage(image: Image): Unit
	func ExportImage(image: Image, fileName: CString): Bool
	func ExportImageToMemory(image: Image, fileType: CString, fileSize: CPointer<Int32>): CString
	func ExportImageAsCode(image: Image, fileName: CString): Bool

	func LoadTexture(fileName: CString): Texture2D
	func LoadTextureFromImage(image: Image): Texture2D
	func LoadTextureCubemap(image: Image, layout: Int32): TextureCubemap
	func LoadRenderTexture(width: Int32, height: Int32): RenderTexture2D
	func IsTextureValid(texture: Texture2D): Bool
	func UnloadTexture(texture: Texture2D): Unit
	func IsRenderTextureValid(target: RenderTexture2D): Bool
	func UnloadRenderTexture(target: RenderTexture2D): Bool
	func UpdateTexture(texture: Texture2D, pixels: CPointer<Unit>): Unit
	func UpdateTextureRec(texture: Texture2D, rec: Rectangle, pixels: CPointer<Unit>): Unit

	func GenTextureMipmaps(texture: CPointer<Texture2D>): Unit
	func SetTextureFilter(texture: Texture2D, filter: Int32): Unit
	func SetTextureWrap(texture: Texture2D, wrap: Int32): Unit

	func DrawTexture(texture: Texture2D, posX: Int32, posY: Int32, tint: Color): Unit
	func DrawTextureV(texture: Texture2D, position: Vector2, tint: Color): Unit
	func DrawTextureEx(texture: Texture2D, position: Vector2, rotation: Float32, scale: Float32, tint: Color): Unit
	func DrawTextureRec(texture: Texture2D, source: Rectangle, position: Vector2, tint: Color): Unit
	func DrawTexturePro(texture: Texture2D, source: Rectangle, dest: Rectangle, origin: Vector2, rotation: Float32, color: Color): Unit
	func DrawTextureNPatch(texture: Texture2D, nPatchInfo: NPatchInfo, dest: Rectangle, origin: Vector2, rotation: Float32, tint: Color): Unit
}

public class ImageGlobal {
	public static func unload(Image: Image): Unit {
		unsafe { UnloadImage(Image) }
	}

	public static func getImage(FileName: CString): Image {
		return unsafe { LoadImage(FileName) }
	}

	public static func getImage(FileName: CString, Width: Int32, Height: Int32, Format: Int32, HeaderSize: Int32): Image {
		return unsafe { LoadImageRaw(FileName, Width, Height, Format, HeaderSize) }
	}

	public static func getImage(Texture: Texture2D): Image {
		return unsafe { LoadImageFromTexture(Texture) }
	}

	public static func getAnim(FileName: CString, Frames: CPointer<Int32>): Image {
		return unsafe { LoadImageAnim(FileName, Frames) }
	}

	public static func getAnim(FileType: CString, FileData: CString, DataSize: Int32, Frames: CPointer<Int32>): Image {
		return unsafe { LoadImageAnimFromMemory(FileType, FileData, DataSize, Frames) }
	}
}

public class TextureGlobal {
	public static func unload(Texture: Texture2D): Unit {
		unsafe { UnloadTexture(Texture) }
	}

	public static func getTexture(FileName: CString): Texture2D {
		return unsafe { LoadTexture(FileName) }
	}

	public static func getTexture(Image: Image): Texture2D {
		return unsafe { LoadTextureFromImage(Image) }
	}

	public static func isValid(Texture: Texture): Bool {
		return unsafe { IsTextureValid(Texture) }
	}

	public static func getCubemap(Image: Image, Layout: Int32): TextureCubemap {
		return unsafe { LoadTextureCubemap(Image, Layout) }
	}

	public static func genMipMaps(Texture: CPointer<Texture2D>): Unit {
		unsafe { GenTextureMipmaps(Texture) }
	}
}

public open class TexObject {
	protected var InternalTexture: Texture2D = Texture2D()
	public open mut prop BaseTexture: Texture2D {
		get() { return InternalTexture }

		set(NewTex) {
			InternalTexture = NewTex
		}
	}

	public init(Tex: Texture2D) {
		this.InternalTexture = Tex
	}
}

public class Canvas <: TexObject {
	private var Pool: Array<Rectangle>
	private let Canvas: Rectangle

	public var Origin: Vector2 = Vector2(0.0,0.0)
	public var Rotation: Float32 = 0.0
	public var CanvasColor: Color = Color()

	public unsafe func drawCanvas(): Unit {
		for (Rect in this.Pool) {
			DrawTexturePro(this.InternalTexture, Rect, this.Canvas, this.Origin, this.Rotation, this.CanvasColor)
		}
	}

	public init(Tex!: Texture2D, RectArray!: Array<Rectangle>, NewCanvas!: Rectangle) {
		super(Tex)
		Pool = RectArray
		Canvas = NewCanvas
	}
}