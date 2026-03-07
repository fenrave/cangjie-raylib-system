package raylib.system

@FastNative foreign {
	func CheckCollisionRecs(rec1: Rectangle, rec2: Rectangle): Bool
	func CheckCollisionCircles(center: Vector2, radius1: Float32, center2: Vector2, radius2: Float32): Bool
	func CheckCollisionCircleRec(center: Vector2, radius: Float32, rec: Rectangle): Bool
	func CheckCollisionCircleLine(center: Vector2, radius: Float32, p1: Vector2, p2: Vector2): Bool
	func CheckCollisionPointRec(point: Vector2, rec: Rectangle): Bool
	func CheckCollisionPointCircle(point: Vector2, center: Vector2, radius: Float32): Bool
	func CheckCollisionPointTriangle(point: Vector2, p1: Vector2, p2: Vector2, p3: Vector2): Bool
	func CheckCollisionPointLine(point: Vector2, p1: Vector2, p2: Vector2, threshold: Int32): Bool
	func CheckCollisionPointPoly(point: Vector2, points: CPointer<Vector2>, pointCount: Int32): Bool
	func CheckCollisionLines(startPos1: Vector2, endPos1: Vector2, startPos2: Vector2, endPos2: Vector2, collisionPoint: CPointer<Vector2>): Bool
	func GetCollisionRec(rec1: Rectangle, rec2: Rectangle): Rectangle

	func CheckCollisionSpheres(center1: Vector3, radius1: Float32, center2: Vector3, radius: Float32): Bool
	func CheckCollisionBoxes(box1: BoundingBox, box2: BoundingBox): Bool
	func CheckCollisionBoxSphere(box: BoundingBox, center: Vector3, radius: Float32): Bool
	func GetRayCollisionSphere(ray: Ray, center: Vector3, radius: Float32): RayCollision
	func GetRayCollisionBox(ray: Ray, box: BoundingBox): RayCollision
	func GetRayCollisionMesh(ray: Ray, mesh: Mesh, transform: Matrix): RayCollision
	func GetRayCollisionTriangle(ray: Ray, p1: Vector3, p2: Vector3, p3: Vector3): RayCollision
	func GetRayCollisionQuad(ray: Ray, p1: Vector3, p2: Vector3, p3: Vector3, p4: Vector3): RayCollision
}

public interface Collision2D {
    static func rec(R1: Rectangle, R2: Rectangle): Bool {
        return unsafe { CheckCollisionRecs(R1, R2) }
    }

    static func circle(C1: Vector2, Rad1: Float32, C2: Vector2, Rad2: Float32): Bool {
        return unsafe { CheckCollisionCircles(C1, Rad1, C2, Rad2) }
    }

    static func circleRec(C1: Vector2, Radius: Float32, R1: Rectangle): Bool {
        return unsafe { CheckCollisionCircleRec(C1, Radius, R1) }
    }

    static func circleLine(C1: Vector2, Radius: Float32, P1: Vector2, P2: Vector2): Bool {
        return unsafe { CheckCollisionCircleLine(C1, Radius, P1, P2) }
    }

    static func pointRec(P1: Vector2, R1: Rectangle): Bool {
        return unsafe { CheckCollisionPointRec(P1, R1) }
    }

    static func pointCircle(P1: Vector2, C1: Vector2, Radius: Float32): Bool {
        return unsafe { CheckCollisionPointCircle(P1, C1, Radius) }
    }

    static func pointTriangle(P1: Vector2, T1: Vector2, T2: Vector2, T3: Vector2): Bool {
        return unsafe { CheckCollisionPointTriangle(P1, T1, T2, T3) }
    }

    static func pointPoly(P1: Vector2, Points:CPointer<Vector2>, PCount: Int32): Bool {
        return unsafe { CheckCollisionPointPoly(P1, Points, PCount) }
    }

    static func line(SP1: Vector2, EP1: Vector2, SP2: Vector2, EP2: Vector2, CollisionPoint: CPointer<Vector2>): Bool {
        return unsafe { CheckCollisionLines(SP1, EP1, SP2, EP2, CollisionPoint) }
    }

    static func get(R1: Rectangle, R2: Rectangle): Rectangle {
        return unsafe { GetCollisionRec(R1, R2) }
    }
}

public interface Collision3D {
    static func sphere(C1: Vector3, R1: Float32, C2: Vector3, Radius: Float32): Bool {
        return unsafe { CheckCollisionSpheres(C1, R1, C2, Radius) }
    }

    static func box(B1: BoundingBox, B2: BoundingBox): Bool {
        return unsafe { CheckCollisionBoxes(B1, B2) }
    }

    static func boxSphere(B1: BoundingBox, C1: Vector3, Radius: Float32): Bool {
        return unsafe { CheckCollisionBoxSphere(B1, C1, Radius) }
    }
}

public interface RayGlobal {
    static func sphere(Ray: Ray, C1: Vector3, Radius: Float32): RayCollision {
        return unsafe { GetRayCollisionSphere(Ray, C1, Radius) }
    }

    static func box(Ray: Ray, B1: BoundingBox): RayCollision {
        return unsafe { GetRayCollisionBox(Ray, B1) }
    }

    static func mesh(Ray: Ray, Mesh: Mesh, Transform: Matrix): RayCollision {
        return unsafe { GetRayCollisionMesh(Ray, Mesh, Transform) }
    }

    static func triangle(Ray: Ray, P1: Vector3, P2: Vector3, P3: Vector3): RayCollision {
        return unsafe { GetRayCollisionTriangle(Ray, P1, P2, P3) }
    }

    static func quad(Ray: Ray, P1: Vector3, P2: Vector3, P3: Vector3, P4: Vector3): RayCollision {
        return unsafe { GetRayCollisionQuad(Ray, P1, P2, P3, P4) }
    }
}

public interface CollisionGlobal {

}