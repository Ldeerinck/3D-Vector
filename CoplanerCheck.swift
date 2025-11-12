//
//  CoplanerCheck.swift
//  3D-Vector
//
//  Created by Luke Deerinck on 11/12/25.
//

import Foundation
import simd

func coplanerCheck(_ triangle1:Triangle, _ triangle2:Triangle, tolerance: Float = 1e-4) -> Bool {
    //determine normals of triangles plane and confirm they are below the tolerance
    let t1v1 = triangle1.v1 - triangle1.v0
    let t1v2 = triangle1.v2 - triangle1.v0
    let n1 = simd_cross(t1v1, t1v2)
    
    let t2v1 = triangle2.v1 - triangle2.v0
    let t2v2 = triangle2.v2 - triangle2.v0
    let n2 = simd_cross(t2v1, t2v2)
    if simd_length(simd_cross(n1, n2)) < Float(tolerance) {
        // Normals are parallel, so the planes are parallel
        // Now check if at least one point from triangle2 lies on the plane of triangle1
        // Using the plane equation: n · (p - p0) = 0, where n is the normal, p is the point, p0 is a point on the plane
        
        // Check if any vertex from triangle2 lies on triangle1's plane
        let v2ToV0_1 = triangle2.v0 - triangle1.v0
        
        // Calculate dot product (distance from plane)
        let dist0 = abs(simd_dot(n1, v2ToV0_1))
        
        // If any vertex is on the plane (within tolerance), the triangles are coplanar
        if dist0 < Float(tolerance) {
            return true
        }
    }
    return false
}
