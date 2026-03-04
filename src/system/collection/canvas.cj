package raylib.system.collection

import raylib.system.{TexObject, Rectangle, Vector2, Color, TexDraw, Texture}
import std.collection.ArrayList
/*
--------------------------
|-> Use for drawing Sprite Maps to a single tile.
*/
public class Canvas <: TexObject {
	private var InternalCanvas: Rectangle
	private var CelArray = Array<Rectangle>()
	private var InternalSkip: Int64 = 0

	public var Origin: Vector2 = Vector2(0.0,0.0)
	public var Rotation: Float32 = 0.0
	public var CanvasColor: Color = Color(255, 255, 255, 255)
	public var TexPadding: Vector2 = Vector2(0.0, 0.0)
	public var FrameSkip: Int64 = 0
	
	public let TexColumns: Int64
	public let TexRows: Int64

	public mut prop CanvasPosition: Vector2 {
		get() { return this.InternalCanvas.Position }

		set(NewPos) {
			this.InternalCanvas.Position = NewPos
		}
	}

	public mut prop CanvasSize: Vector2 {
		get() { return Vector2(
			this.InternalCanvas.width,
			this.InternalCanvas.height
			)
		}

		set(NewSize) {
			this.InternalCanvas.width = NewSize.x
			this.InternalCanvas.height = NewSize.y
		}
	}

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
		get() { return this.InternalCount }

		set(NewAmn) {
			this.InternalCount = NewAmn
			this.regenerateCels()
		}
	}

	private var DrawCB: (Cel: Int64) -> Unit = {_: Int64 =>}
	public func setDrawCB(CB: (Cel: Int64) -> Unit): Unit {
		this.DrawCB = CB
	}

	private var CurrentColumn: Float32 = 0.0
	private var CurrentRow: Float32 = 0.0
	private var CurrentCel: Int64 = 0
	/*
	--------------------------
	|-> Rebuilds the canvas cels to fit new parameters.
	|-> Automatically calls when CelCount & TexScale are altered.
	|-> Resets Canvas index to 0.
	*/
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
	/*
	--------------------------
	|-> Moves to the next tile.
	*/
	public func next(): Unit {
		this.InternalSkip++
		if (this.FrameSkip > this.InternalSkip) {
			return
		}

		this.InternalSkip = 0
		this.CurrentCel++
		if (this.CurrentCel > this.InternalCount) {
			this.CurrentCel = 0
		}
	}
	/*
	--------------------------
	|-> Moves to the last tile.
	*/
	public func back(): Unit {
		this.InternalSkip++
		if (this.FrameSkip > this.InternalSkip) {
			return
		}

		this.InternalSkip = 0
		this.CurrentCel--
		if (this.CurrentCel < 0) {
			this.CurrentCel = this.InternalCount
		}
	}

	/*
	--------------------------
	|-> Draws the current tile to the Canvas.
	*/
	public func draw(): Unit {
		this.DrawCB(this.CurrentCel)
		unsafe { TexDraw.draw(
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