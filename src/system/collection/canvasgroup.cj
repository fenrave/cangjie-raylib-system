package raylib.system.collection

import raylib.system.{TexObject, Rectangle, Vector2, Color, TexDraw, Texture, Window}
import std.collection.ArrayList

public class CanvasGroup {
    private var Canvases = ArrayList<Canvas>()
    private var InternalSpace = Rectangle(0.0, 0.0, 0.0, 0.0)

    private var DrawCB: (DT: Float32) -> Unit = { _: Float32 => }
    public func setDrawCB(CB: (DT: Float32) -> Unit): Unit {
        this.DrawCB = CB
    }

    public func draw(DT: Float32): Unit {
        this.DrawCB(DT)
        for (CanvasObj in this.Canvases) {
            CanvasObj.draw()
        }
    }

    public func add(Target: Canvas): Unit {
        this.Canvases.add(Target)
    }

    public init(
        Space!: Rectangle = Rectangle(0.0,0.0, Float32(Window.renderWidth), Float32(Window.renderHeight))
    ) {
        this.InternalSpace = Space
    }
}