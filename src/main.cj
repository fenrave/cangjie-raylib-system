package raylib

import raylib.tests
import raylib.system.{IntVector2, Window, Camera2D}

main(): Int64 {
    let WINDOWSIZE = IntVector2(500, 500) ; let Camera = Camera2D()

    Window.open(WINDOWSIZE, "Hi")
    Window.monitor = 0


    tests.canvas(Camera)
    return 0
}