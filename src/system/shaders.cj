package raylib.system

import std.fs.{File, OpenMode}
import std.collection.HashMap


foreign {
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
//Raylibs LoadShader function can take a null param when not loading one shader type, so this is passed internally
private let EMPTY = unsafe { {=>
	var newnull = LibC.mallocCString("")
	LibC.free(newnull)
	return newnull
}() }

private let READCACHE = HashMap<String, CString>()

public interface ShaderEdit {
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
		let vs = File(VertexFilePath, Read)
		let fs = File(FragmentFilePath, Read)

		let VertText = vs.read(Array<UInt8>(vs.length + 10, repeat: 0)).toString()
		let FragText = fs.read(Array<UInt8>(fs.length + 10, repeat: 0)).toString()

		return unsafe {
			LoadShaderFromMemory(
				LibC.mallocCString(VertText),
				LibC.mallocCString(FragText)
			)
		}
	}

	static func getVertShader(VertexFilePath!: String): Shader {
		let vs = File(VertexFilePath, Read)

		let VertText = vs.read(Array<UInt8>(vs.length + 10, repeat: 0)).toString()

		return unsafe {
			LoadShaderFromMemory(
				LibC.mallocCString(VertText),
				EMPTY
			)
		}
	}

	static func getFragShader(FragmentFilePath!: String): Shader {
		let fs = File(FragmentFilePath, Read)

		let FragText = fs.read(Array<UInt8>(fs.length + 10, repeat: 0)).toString()

		return unsafe {
			LoadShaderFromMemory(
				EMPTY,
				LibC.mallocCString(FragText)
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