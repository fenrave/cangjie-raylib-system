package raylib.system

foreign {
	func SetShapesTexture(texture: Texture, source: Rectangle): Unit
	func GetShapesTexture(): Texture
	func GetShapesTextureRectangle(): Rectangle

	func LoadImage(fileName: CString): Image
	func LoadImageRaw(fileName: CString, width: Int32, height: Int32, format: Int32, headerSize: Int32): Image
	func LoadImageAnim(fileName: CString, frames: CPointer<Int32>): Image
	func LoadImageAnimFromMemory(fileType: CString, fileData: CString, dataSize: Int32, frames: CPointer<Int32>): Image
	func LoadImageFromTexture(texture: Texture): Image
	func LoadImageFromScreen(): Image
	func IsImageValid(image: Image): Bool
	func UnloadImage(image: Image): Unit
	func ExportImage(image: Image, fileName: CString): Bool
	func ExportImageToMemory(image: Image, fileType: CString, fileSize: CPointer<Int32>): CString
	func ExportImageAsCode(image: Image, fileName: CString): Bool

	func LoadTexture(fileName: CString): Texture
	func LoadTextureFromImage(image: Image): Texture
	func LoadTextureCubemap(image: Image, layout: Int32): TextureCubemap
	func LoadRenderTexture(width: Int32, height: Int32): RenderTexture2D
	func IsTextureValid(texture: Texture): Bool
	func UnloadTexture(texture: Texture): Unit
	func IsRenderTextureValid(target: RenderTexture2D): Bool
	func UnloadRenderTexture(target: RenderTexture2D): Bool
	func UpdateTexture(texture: Texture, pixels: CPointer<Unit>): Unit
	func UpdateTextureRec(texture: Texture, rec: Rectangle, pixels: CPointer<Unit>): Unit

	func GenTextureMipmaps(texture: CPointer<Texture>): Unit
	func SetTextureFilter(texture: Texture, filter: Int32): Unit
	func SetTextureWrap(texture: Texture, wrap: Int32): Unit

	func DrawTexture(texture: Texture, posX: Int32, posY: Int32, tint: Color): Unit
	func DrawTextureV(texture: Texture, position: Vector2, tint: Color): Unit
	func DrawTextureEx(texture: Texture, position: Vector2, rotation: Float32, scale: Float32, tint: Color): Unit
	func DrawTextureRec(texture: Texture, source: Rectangle, position: Vector2, tint: Color): Unit
	func DrawTexturePro(texture: Texture, source: Rectangle, dest: Rectangle, origin: Vector2, rotation: Float32, color: Color): Unit
	func DrawTextureNPatch(texture: Texture, nPatchInfo: NPatchInfo, dest: Rectangle, origin: Vector2, rotation: Float32, tint: Color): Unit
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

	public static func getImage(Texture: Texture): Image {
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
	public static func unload(Texture: Texture): Unit {
		unsafe { UnloadTexture(Texture) }
	}

	public static func getTexture(FileName: CString): Texture {
		return unsafe { LoadTexture(FileName) }
	}

	public static func getTexture(Image: Image): Texture {
		return unsafe { LoadTextureFromImage(Image) }
	}

	public static func isValid(Texture: Texture): Bool {
		return unsafe { IsTextureValid(Texture) }
	}

	public static func getCubemap(Image: Image, Layout: Int32): TextureCubemap {
		return unsafe { LoadTextureCubemap(Image, Layout) }
	}

	public static func genMipMaps(Texture: CPointer<Texture>): Unit {
		unsafe { GenTextureMipmaps(Texture) }
	}
}

public open class TexObject {
	protected var InternalTexture: Texture = Texture()
	public open mut prop BaseTexture: Texture {
		get() { return InternalTexture }

		set(NewTex) {
			InternalTexture = NewTex
		}
	}

	public init(Tex: Texture) {
		this.InternalTexture = Tex
	}
}

public class Canvas <: TexObject {
	private let InternalCanvas: Rectangle
	private var CelArray = Array<Rectangle>()
	private var InternalSkip: Int64 = 0

	public var Origin: Vector2 = Vector2(0.0,0.0)
	public var Rotation: Float32 = 0.0
	public var CanvasColor: Color = Color(255, 255, 255, 255)
	public var TexPadding: Vector2 = Vector2(0.0, 0.0)
	public var FrameSkip: Int64 = 0
	
	public let TexColumns: Int64
	public let TexRows: Int64

	private var InternalScale: Vector2 = Vector2(0.0, 0.0)
	public mut prop TexScale: Vector2 {
		get() { return this.InternalScale }

		set(NewScale) {
			this.InternalScale = NewScale
			this.regenerateCels()
		}
	}

	private var InternalCount: Int64 = 0
	public mut prop CelCount: Int64 {
		get() { return InternalCount }

		set(NewAmn) {
			this.InternalCount = NewAmn
			this.regenerateCels()
		}
	}

	private var CurrentColumn: Float32 = 0.0
	private var CurrentRow: Float32 = 0.0
	private var CurrentCel: Int64 = 0
	public func regenerateCels(): Unit {
		this.CurrentCel = 0
		this.CelArray = Array<Rectangle>(this.InternalCount+1, { Index: Int64 =>
			if (Index > this.CelCount) {
				this.CurrentRow = 0.0
				this.CurrentColumn = 0.0
				return unsafe { zeroValue<Rectangle>() }
			} else {
				this.CurrentColumn += 1.0

				if (this.CurrentColumn > Float32(this.TexColumns)) {
					this.CurrentRow += 1.0
				}

				return Rectangle(
					(Float32(Index) * this.TexScale.x) + this.TexPadding.x,
					(this.CurrentRow * this.TexScale.y) + this.TexPadding.y,
					this.TexScale.x,
					this.TexScale.y
				)
			}
		})
	}

	public func next(): Unit {
		this.InternalSkip++
		if (this.FrameSkip > this.InternalSkip) {
			this.draw()
			return
		}

		this.InternalSkip = 0
		this.CurrentCel++
		if (this.CurrentCel > this.InternalCount) {
			this.CurrentCel = 0
		}
		this.draw()
	}

	public func back(): Unit {
		this.InternalSkip++
		if (this.FrameSkip > this.InternalSkip) {
			this.draw()
			return
		}

		this.InternalSkip = 0
		this.CurrentCel--
		if (this.CurrentCel < 0) {
			this.CurrentCel = this.InternalCount
		}
		this.draw()
	}


	public func draw(): Unit {
		// print(CurrentCel)
		unsafe { DrawTexturePro(
			this.InternalTexture,
			this.CelArray[this.CurrentCel],
			this.InternalCanvas,
			this.Origin,
			this.Rotation,
			this.CanvasColor
		) }
		
	}

	public init(
		Tex!: Texture,
		Columns!: Int64,
		Rows!: Int64,
		Cels!: Int64,
		Canvas!: Rectangle,
		Skip!: Int64,
		Scale!: Vector2
		) {
		super(Tex)
		this.InternalCanvas = Canvas
		this.TexColumns = Columns
		this.TexRows = Rows
		this.CelCount = Cels
		this.TexScale = Scale
		this.FrameSkip = Skip
	}
}