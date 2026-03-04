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

protected interface TexDraw {
	//DrawTexture
	static func draw(Target: Texture, X: Int32, Y: Int32, Tint: Color): Unit {
		unsafe { DrawTexture(Target, X, Y, Tint) }
	}
	//DrawTextureV
	static func draw(Target: Texture, Position: Vector2, Tint: Color): Unit {
		unsafe { DrawTextureV(Target, Position, Tint) }
	}
	//DrawTextureEx
	static func draw(Target: Texture, Position: Vector2, Rotation: Float32, Scale: Float32, Tint: Color): Unit {
		unsafe { DrawTextureEx(Target, Position, Rotation, Scale, Tint) }
	}
	//DrawTextureRec
	static func draw(Target: Texture, Source: Rectangle, Position: Vector2, Tint: Color): Unit {
		unsafe { DrawTextureRec(Target, Source, Position, Tint) }
	}
	//DrawTexturePro
	static func draw(Target: Texture, Source: Rectangle, Dest: Rectangle, Origin: Vector2, Rotation: Float32, Color: Color): Unit {
		unsafe { DrawTexturePro(Target, Source, Dest, Origin, Rotation, Color) }
	}
	//DrawTextureNPatch
	static func draw(Target: Texture, NPatch: NPatchInfo, Dest: Rectangle, Origin: Vector2, Rotation: Float32, Tint: Color): Unit {
		unsafe { DrawTextureNPatch(Target, NPatch, Dest, Origin, Rotation, Tint) }
	}
}

public interface ImageGlobal {
	static func unload(Image: Image): Unit {
		unsafe { UnloadImage(Image) }
	}

	static func getImage(FileName: CString): Image {
		return unsafe { LoadImage(FileName) }
	}

	static func getImage(FileName: CString, Width: Int32, Height: Int32, Format: Int32, HeaderSize: Int32): Image {
		return unsafe { LoadImageRaw(FileName, Width, Height, Format, HeaderSize) }
	}

	static func getImage(Texture: Texture): Image {
		return unsafe { LoadImageFromTexture(Texture) }
	}

	static func getAnim(FileName: CString, Frames: CPointer<Int32>): Image {
		return unsafe { LoadImageAnim(FileName, Frames) }
	}

	static func getAnim(FileType: CString, FileData: CString, DataSize: Int32, Frames: CPointer<Int32>): Image {
		return unsafe { LoadImageAnimFromMemory(FileType, FileData, DataSize, Frames) }
	}
}

public interface TextureGlobal <: TexDraw {
	static func unload(Texture: Texture): Unit {
		unsafe { UnloadTexture(Texture) }
	}

	static func updateTexture(Texture: Texture, Pixels: CPointer<Unit>): Unit {
		unsafe { UpdateTexture(Texture, Pixels) }
	}

	static func setFilter(Texture: Texture, Filter: Int32): Unit {
		unsafe {SetTextureFilter(Texture, Filter)}
	}

	static func setWrap(Texture: Texture, Wrap: Int32): Unit {
		unsafe {SetTextureWrap(Texture, Wrap)}
	}

	static func getTexture(FileName: CString): Texture {
		return unsafe { LoadTexture(FileName) }
	}

	static func getTexture(Image: Image): Texture {
		return unsafe { LoadTextureFromImage(Image) }
	}

	static func getRenderTexture(Width: Int32, Height: Int32): RenderTexture {
		return unsafe { LoadRenderTexture(Width, Height) }
	}

	static func getCubemap(Image: Image, Layout: Int32): TextureCubemap {
		return unsafe { LoadTextureCubemap(Image, Layout) }
	}

	static func genMipMaps(Texture: CPointer<Texture>): Unit {
		unsafe { GenTextureMipmaps(Texture) }
	}

	static func isValid(Target: Texture): Bool {
		return unsafe { IsTextureValid(Target) }
	}

	static func isValid(Target: RenderTexture): Bool {
		return unsafe { IsRenderTextureValid(Target) }
	}
}

public open class TexObject {
	protected var InternalTexture: Texture = Texture()
	public open mut prop BaseTexture: Texture {
		get() { return this.InternalTexture }

		set(NewTex) {
			this.InternalTexture = NewTex
		}
	}

	public init(Tex: Texture) {
		this.InternalTexture = Tex
	}
}