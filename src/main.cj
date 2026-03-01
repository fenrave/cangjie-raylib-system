package raylib

import raylib.system.{KeyInput, IntVector2, Scheduler, Window, Camera2D, Render2D, Rectangle, Color, Keyboard, Vector2, Canvas, TextureGlobal}

func start() {
    let WINDOWSIZE = IntVector2(500, 500) ; let Camera = Camera2D()

    Window.open(WINDOWSIZE, "Hi")
    Window.monitor = 0

    let Tex = TextureGlobal.getTexture(unsafe { LibC.mallocCString("./src/textures/quail.bmp") })

    let NewCanvas = Canvas(
        Tex: Tex,
        Columns: 5,
        Rows: 1,
        Canvas: Rectangle(0.0, 0.0, 75.0, 75.0),
        Cels: 5,
        Skip: 3,
        Scale: Vector2(112.0, 112.0)
    )

    Render2D.bindTo(
        SchedulerState: 1,
        OnState: { _: Float32 => NewCanvas.traverse() }
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

main(): Int64 {
    start()
    return 0
}