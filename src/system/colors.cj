package raylib.system

@FastNative foreign {
    func ColorIsEqual(col1: Color, col2: Color): Bool
    func Fade(color: Color, alpha: Float32): Color
    func ColorToInt(color: Color): Int32
    func ColorNormalize(color: Color): Vector4
    func ColorFromNormalized(normalized: Vector4): Color
    func ColorToHSV(color: Color): Vector3
    func ColorFromHSV(hue: Float32, saturation: Float32, value: Float32): Color
    func ColorTint(color: Color, tint: Color): Color
    func ColorBrightness(color: Color, factor: Float32): Color
    func ColorContrast(color: Color, contrast: Float32): Color
    func ColorAlpha(color: Color, alpha: Float32): Color
    func ColorAlphaBlend(dst: Color, src: Color, tint: Color): Color
    func ColorLerp(color1: Color, color2: Color, factor: Float32): Color
    func GetColor(hexValue: UInt32): Color
    func GetPixelColor(srcPtr: CPointer<Unit>, format: Int32): Color
    func SetPixelColor(dstPtr: CPointer<Unit>, color: Color, format: Int32): Unit
    func GetPixelDataSize(width: Int32, height: Int32, format: Int32): Int32
}

public interface PixelGlobal {
    static func getColor(Source: CPointer<Unit>, Format: Int32): Color {
        return unsafe { GetPixelColor(Source, Format) }
    }

    static func setColor(Destination: CPointer<Unit>, Target: Color, Format: Int32): Unit {
        unsafe { SetPixelColor(Destination, Target, Format) }
    }

    static func getDataSize(Width: Int32, Height: Int32, Format: Int32): Int32 {
        return unsafe { GetPixelDataSize(Width, Height, Format) }
    }
}

public interface ColorsGlobal {
    static func isEqual(Color1: Color, Color2: Color): Bool {
        return unsafe { ColorIsEqual(Color1, Color2) }
    }

    static func fade(Target: Color, Alpha: Float32): Color {
        return unsafe { Fade(Target, Alpha) }
    }

    static func tint(Target: Color, Tint: Color): Color {
        return unsafe { ColorTint(Target, Tint) }
    }

    static func brightness(Target: Color, Factor: Float32): Color {
        return unsafe { ColorBrightness(Target, Factor) }
    }

    static func contrast(Target: Color, Contrast: Float32): Color {
        return unsafe { ColorContrast(Target, Contrast) }
    }

    static func alpha(Target: Color, Alpha: Float32): Color {
        return unsafe { ColorAlpha(Target, Alpha) }
    }

    static func alphaBlend(Dest: Color, Src: Color, Tint: Color): Color {
        return unsafe { ColorAlphaBlend(Dest, Src, Tint) }
    }

    static func lerp(Target1: Color, Target2: Color, Factor: Float32): Color {
        return unsafe { ColorLerp(Target1, Target2, Factor) }
    }

    static func toInt(Target: Color): Int32 {
        return unsafe { ColorToInt(Target) }
    }

    static func toNormalize(Target: Color): Vector4 {
        return unsafe { ColorNormalize(Target) }
    }

    static func fromNormalized(Target: Vector4): Color {
        return unsafe { ColorFromNormalized(Target) }
    }

    static func toHSV(Target: Color): Vector3 {
        return unsafe { ColorToHSV(Target) }
    }

    static func fromHSV(Hue: Float32, Saturation: Float32, Value: Float32): Color {
        return unsafe { ColorFromHSV(Hue, Saturation, Value) }
    }

    static func get(HexValue: UInt32): Color {
        return unsafe { GetColor(HexValue) }
    }
}