package rayl

import rayl.system.*

let WindowSize = IntVector2(500, 500)

main(): Int64 {
    Window.Open(WindowSize, "Hello World")
    
    return 0
}