package raylib

import raylib.system.{KeyInput, IntVector2, Scheduler, Window, Camera2D, Render2D, Rectangle, Color, Keyboard}
import std.random.Random
import std.unittest.prop_test.RandomSource

let NUM = Random()

foreign func DrawRectangleRec(rec: Rectangle, color: Color): Unit

let DEFAULTCOLOR = Color(50,50,50,255)

main(): Int64 {
    let WINDOWSIZE = IntVector2(500, 500)
    let Camera = Camera2D()
    var CHUNK = VArray<Rectangle, $50>(repeat: Rectangle(0.0, 0.0, 50.0, 50.0))

    Window.open(WINDOWSIZE, "Hi")
    Window.monitor = 0
    let chunkRef = CHUNK
    let drawFunc = unsafe { {
        DT: Float32 => for (i in 1..chunkRef.size) {
            var rec = chunkRef[1]
            rec.updatePosition(
                225.0 + NUM.suggestFloat32(-100.0, 100.0),
                225.0 + NUM.suggestFloat32(-100.0, 100.0)
            )
            DrawRectangleRec(rec, DEFAULTCOLOR)
            }
        }
    }

    Render2D.bindTo(
        SchedulerState: 1,
        OnState: drawFunc
    )

    let newKey = KeyInput(
        Key: Keyboard.A,
        Down: { DT: Float32 => print("FrameTime is -> ${DT}\n") },
        Up: { DT: Float32 => print("hello\n") }
    )

    Render2D.bindTo(
        SchedulerState: 0,
        OnState: KeyInput.check
    )

    Render2D.mainCamera = Camera
    Scheduler.start(InitFrameRate: 120)

    return 0
}