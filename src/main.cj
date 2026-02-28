package raylib

import raylib.system.{KeyInput, IntVector2, Scheduler, Window, Camera2D, Render2D, Rectangle, Color, Keyboard, Vector2, Canvas, TextureGlobal}

func start() {
    let WINDOWSIZE = IntVector2(500, 500)
    let Camera = Camera2D()

    Window.open(WINDOWSIZE, "Hi")
    Window.monitor = 0

    let Tex = TextureGlobal.getTexture(unsafe { LibC.mallocCString("./src/textures/quail.bmp") })

    let NewCanvas = Canvas(
        Tex: Tex,
        Columns: 5,
        Rows: 1,
        Canvas: Rectangle(0.0, 0.0, 500.0, 500.0),
        Cels: 5,
        Skip: 3,
        Scale: Vector2(112.0, 112.0)
    )

    Render2D.bindTo(
        SchedulerState: 1,
        OnState: { _: Float32 => NewCanvas.next() }
    )

    let newKey = KeyInput(
        Key: Keyboard.A,
        Down: { DT: Float32 => print("FrameTime is -> ${DT}\n") }
    )

    Render2D.bindTo(
        SchedulerState: 0,
        OnState: KeyInput.check
    )

    Render2D.mainCamera = Camera
    Scheduler.start(InitFrameRate: 60)
}

main(): Int64 {
    start()
    return 0
}