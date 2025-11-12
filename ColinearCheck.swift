//
//  ColinearCheck.swift
//  3D-Vector
//
//  Created by Luke Deerinck on 11/11/25.
//

import Foundation
import Spatial

func colinearCheck(_ linesegment1: LineSegment, _ linesegment2: LineSegment, tolerance: Double = 1e-9) -> Bool {
    
    //check that the Two direction Vectors for the line segments are parallel by checking the crossproduct
    let directionVector1: Vector3D = Vector3D(x: linesegment1.end.x - linesegment1.start.x, y: linesegment1.end.y - linesegment1.start.y, z: linesegment1.end.z - linesegment1.start.z)
    let directionVector2: Vector3D = Vector3D(x: linesegment2.end.x-linesegment2.start.x,y:linesegment2.end.y-linesegment2.start.y,z:linesegment2.end.z-linesegment2.start.z)
    
    let crossProduct1 = directionVector1.cross(directionVector2)
    if crossProduct1.length < tolerance {
        //check that they are on the same line by checking the cross product of a direction vector for segment composed of points from both segments against any of the direction vectors for the original line segments
        let directionVector3: Vector3D = Vector3D(x: linesegment2.start.x-linesegment1.start.x,y:linesegment2.start.y-linesegment1.start.y,z:linesegment2.start.z-linesegment1.start.z)
        let crossProduct2 = directionVector3.cross(directionVector1)
        if crossProduct2.length < tolerance {
            return true
        }
        return false
    }
    else {
        return false;
    }
}
