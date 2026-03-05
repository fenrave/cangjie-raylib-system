package raylib.system

import std.fs.{File, OpenMode}
import std.collection.HashMap

@FastNative foreign {
	func LoadShader(vsFileName: CString, fsFileName: CString): Shader
	func LoadShaderFromMemory(vsCode: CString, fsCode: CString): Shader

	func IsShaderValid(shader: Shader): Bool
	func GetShaderLocation(Shader: Shader, uniformName: CString): Int32
	func GetShaderLocationAttrib(shader: Shader, attribName: CString): Int32
	func SetShaderValue(shader: Shader, locIndex: Int32, value: CPointer<Unit>, uniformType: Int32): Unit
	func SetShaderValueV(shader: Shader, locIndex: Int32, value: CPointer<Unit>, uniformType: Int32, count: Int32): Unit
	func SetShaderValueMatrix(shader: Shader, locIndex: Int32, mat: Matrix): Unit
	func SetShaderValueTexture(shader: Shader, locIndex: Int32, texture: Texture): Unit
	func UnloadShader(shader: Shader): Unit

	func LoadFileData(fileName: CString, dataSize: CPointer<Int32>): CString
	func UnloadFileData(data: CString): Unit
	func SaveFileData(filename: CString, data: CPointer<Unit>, dataSize: Int32): Bool
	func ExportDataAsCode(data: CString, dataSize: Int32, fileName: CString): Bool
	func LoadFileText(fileName: CString): CString
	func UnloadFileText(text: CString): Unit
	func SaveFileText(fileName: CString, text: CString): Bool
}

/*
--------------------
| Probably not necessary but Raylib's LoadShader function takes optional null params, so this is the easiest way to get one.
*/
private let EMPTY = unsafe { {=>
	var newnull = LibC.mallocCString("")
	LibC.free(newnull)
	return newnull
}() }

private let READCACHE = HashMap<String, CString>()

public interface ShaderEdit {
	static func setValue(Shader: Shader, LOC: Int32, Value: CPointer<Unit>, Uniform: Int32): Unit {
		unsafe { SetShaderValue(Shader, LOC, Value, Uniform) }
	}

	static func setValue(Shader: Shader, LOC: Int32, Value: CPointer<Unit>, Uniform: Int32, Count: Int32): Unit {
		unsafe { SetShaderValueV(Shader, LOC, Value, Uniform, Count) }
	}

	static func setValue(Shader: Shader, LOC: Int32, Matrix: Matrix): Unit {
		unsafe { SetShaderValueMatrix(Shader, LOC, Matrix) }
	}

	static func setValue(Shader: Shader, LOC: Int32, Texture: Texture): Unit {
		unsafe { SetShaderValueTexture(Shader, LOC, Texture) }
	}

	static func getLocation(Shader: Shader, Uniform: CString): Int32 {
		return unsafe { GetShaderLocation(Shader, Uniform) }
	}

	static func getLocationAttribute(Shader: Shader, Attribute: CString): Int32 {
		return unsafe { GetShaderLocationAttrib(Shader, Attribute) }
	}

	static func getLocation(Shader: Shader, Uniform: String): Int32 {
		if (READCACHE.contains(Uniform)) {
			return unsafe { GetShaderLocation(Shader, READCACHE[Uniform]) }
		} else {
			READCACHE[Uniform] = unsafe {LibC.mallocCString(Uniform)}

			return unsafe { GetShaderLocation(Shader, READCACHE[Uniform]) }
		}
	}

	static func getLocationAttribute(Shader: Shader, Attribute: String): Int32 {
		if (READCACHE.contains(Attribute)) {
			return unsafe { GetShaderLocation(Shader, READCACHE[Attribute]) }
		} else {
			READCACHE[Attribute] = unsafe {LibC.mallocCString(Attribute)}

			return unsafe { GetShaderLocation(Shader, READCACHE[Attribute]) }
		}
	}

}

public interface ShaderGlobal {
	static func unload(Target: Shader): Unit {
		unsafe { UnloadShader(Target) }
	}

	static func isValid(Target: Shader): Bool {
		return unsafe { IsShaderValid(Target) }
	}

	static func getShader(VertexFilePath!: String, FragmentFilePath!: String): Shader {
		let VertText = unsafe { LoadFileText( LibC.mallocCString(VertexFilePath) ) }
		let FragText = unsafe { LoadFileText( LibC.mallocCString(FragmentFilePath) ) }

		return unsafe {
			LoadShaderFromMemory(
				VertText,
				FragText
			)
		}
	}

	static func getVertShader(VertexFilePath!: String): Shader {

		let VertText = unsafe { LoadFileText( LibC.mallocCString(VertexFilePath) ) }

		return unsafe {
			LoadShaderFromMemory(
				VertText,
				EMPTY
			)
		}
	}

	static func getFragShader(FragmentFilePath!: String): Shader {
		let FragText = unsafe { LoadFileText( LibC.mallocCString(FragmentFilePath) ) }

		return unsafe {
			LoadShaderFromMemory(
				EMPTY,
				FragText
			)
		}
	}

	static func getShader(VertexFilePath!: CString, FragmentFilePath!: CString): Shader {
		return unsafe { LoadShader(VertexFilePath, FragmentFilePath) }
	}

	static func getVertShader(VertexFilePath!: CString): Shader {
		return unsafe { LoadShaderFromMemory(LoadFileText(VertexFilePath), EMPTY) }
	}

	static func getFragShader(FragmentFilePath!: CString): Shader {
		return unsafe { LoadShaderFromMemory(EMPTY, LoadFileText(FragmentFilePath)) }
	}
}