//
//  ColinearCheck.swift
//  3D-Vector
//
//  Created by Luke Deerinck on 11/11/25.
//

import Foundation
import simd

func colinearCheck(_ linesegment1: LineSegment, _ linesegment2: LineSegment, tolerance: Float = 1e-4) -> Bool {
    
    //check that the Two direction Vectors for the line segments are parallel by checking the crossproduct
    let directionVector1 = linesegment1.end - linesegment1.start
    let directionVector2 = linesegment2.end - linesegment2.start
    
    let crossProduct1 = simd_cross(directionVector1, directionVector2)
    if simd_length(crossProduct1) < Float(tolerance) {
        //check that they are on the same line by checking the cross product of a direction vector for segment composed of points from both segments against any of the direction vectors for the original line segments
        let directionVector3 = linesegment2.start - linesegment1.start
        let crossProduct2 = simd_cross(directionVector3, directionVector1)
        if simd_length(crossProduct2) < Float(tolerance) {
            return true
        }
        return false
    }
    else {
        return false;
    }
}
