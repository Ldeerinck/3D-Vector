//
//  CoplanerCheck.swift
//  3D-Vector
//
//  Created by Luke Deerinck on 11/12/25.
//

import Foundation
import Spatial

func coplanerCheck(_ triangle1:Triangle, _ triangle2:Triangle, tolerance: Double = 1e-9) -> Bool {
    //determine normals of triangles plane and confirm they are below the tolerance
    let t1v1: Vector3D = Vector3D(x: triangle1.v1.x - triangle1.v0.x, y: triangle1.v1.y - triangle1.v0.y, z: triangle1.v1.z - triangle1.v0.z)
    let t1v2: Vector3D = Vector3D(x: triangle1.v2.x - triangle1.v0.x, y: triangle1.v2.y - triangle1.v0.y, z: triangle1.v2.z - triangle1.v0.z)
    let n1 = t1v1.cross(t1v2)
    
    let t2v1: Vector3D = Vector3D(x: triangle2.v1.x - triangle2.v0.x, y: triangle2.v1.y - triangle2.v0.y, z: triangle2.v1.z - triangle2.v0.z)
    let t2v2: Vector3D = Vector3D(x: triangle2.v2.x - triangle2.v0.x, y: triangle2.v2.y - triangle2.v0.y, z: triangle2.v2.z - triangle2.v0.z)
    let n2 = t2v1.cross(t2v2)
    if ( n1.cross(n2).length < tolerance){
        // Normals are parallel, so the planes are parallel
        // Now check if at least one point from triangle2 lies on the plane of triangle1
        // Using the plane equation: n · (p - p0) = 0, where n is the normal, p is the point, p0 is a point on the plane
        
        // Check if any vertex from triangle2 lies on triangle1's plane
        let v2ToV0_1 = Vector3D(x: triangle2.v0.x - triangle1.v0.x, y: triangle2.v0.y - triangle1.v0.y, z: triangle2.v0.z - triangle1.v0.z)
        
        // Calculate dot product (distance from plane)
        let dist0 = abs(n1.dot(v2ToV0_1))
        
        // If any vertex is on the plane (within tolerance), the triangles are coplanar
        if dist0 < tolerance {
            return true
        }
    }
    return false
}
