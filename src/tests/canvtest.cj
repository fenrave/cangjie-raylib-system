package raylib.tests

import raylib.system.{ShaderGlobal, ShaderEdit, KeyInput, ShaderLocationIndex, IntVector2, Scheduler, Window, Camera2D, Render2D, Rectangle, Color, Keyboard, Vector2, TextureGlobal}
import raylib.system.collection.Canvas
import raylib.system.collection.CanvasGroup

public func canvas(Camera: Camera2D): Unit {
    let Tex = TextureGlobal.getTexture(unsafe { LibC.mallocCString("./src/textures/quail.bmp") })
    let Frag = ShaderGlobal.getFragShader(FragmentFilePath: "./src/textures/dis.fs")

    let NewCanvas = Canvas(
        Tex: Tex,
        Columns: 5,
        Rows: 1,
        Canvas: Rectangle(0.0, 0.0, 75.0, 75.0),
        Cels: 5,
        Skip: 3,
        Scale: Vector2(112.0, 112.0)
    )

    let NewGroup = CanvasGroup()
    NewGroup.add(NewCanvas)

    NewCanvas.setDrawCB({ _:Int64 => NewCanvas.next() })

    Render2D.bindTo(
        SchedulerState: 1,
        OnState: NewGroup.draw
    )

    let KeyW = KeyInput(
        Key: Keyboard.W,
        Down: { _: Float32 =>
            NewCanvas.CanvasPosition += Vector2(0.0,-1.0)
        }
    )

    let KeyA = KeyInput(
        Key: Keyboard.A,
        Down: { _: Float32 =>
            NewCanvas.CanvasPosition += Vector2(-1.0,0.0)
        }
    )

    let KeyD = KeyInput(
        Key: Keyboard.D,
        Down: { _: Float32 =>
            NewCanvas.CanvasPosition += Vector2(1.0,0.0)
        }
    )

    let KeyS = KeyInput(
        Key: Keyboard.S,
        Down: { _: Float32 =>
            NewCanvas.CanvasPosition += Vector2(0.0,1.0)
        }
    )

    Render2D.bindTo(
        SchedulerState: 0,
        OnState: KeyInput.check
    )

    Render2D.mainCamera = Camera
    Scheduler.start(InitFrameRate: 120)
}
