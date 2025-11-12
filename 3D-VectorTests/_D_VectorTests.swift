//
//  _D_VectorTests.swift
//  3D-VectorTests
//
//  Created by Luke Deerinck on 11/11/25.
//

import Testing
import simd
@testable import _D_Vector

struct _D_VectorTests {

    @Test func example() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
    }
    
    @Test func colinearTest() async throws {
        let segment1 = LineSegment(start: simd_float3(x: 0, y: 0, z: 0), end: simd_float3(x: 1, y: 1, z: 1))
        let segment2 = LineSegment(start: simd_float3(x: 2, y: 2, z: 2), end: simd_float3(x: 3, y: 3, z: 3))
        #expect(colinearCheck(segment1, segment2))
        let segment3 = LineSegment(start: simd_float3(x: 0, y: 0, z: 0), end: simd_float3(x: 1, y: 0, z: 0))
        let segment4 = LineSegment(start: simd_float3(x: 0, y: 1, z: 0), end: simd_float3(x: 0, y: 1, z: 1))
        #expect(!colinearCheck(segment3, segment4))
        let segment5 = LineSegment(start: simd_float3(x: -3, y: -3, z: -3), end: simd_float3(x: -2, y: -2, z: -2))
        #expect(colinearCheck(segment1, segment5))
        let segment6 = LineSegment(start: simd_float3(x: 1.5, y: 2, z: 3.5), end: simd_float3(x: 2.5, y: 3, z: 4.5))
        let segment7 = LineSegment(start: simd_float3(x: 3.5, y: 4, z: 5.5), end: simd_float3(x: 4.5, y: 5, z: 6.5))
        #expect(colinearCheck(segment6, segment7))
    }
    
    @Test func coplanarTest() async throws {
        //vertices \(A=(1,0,0)\), \(B=(0,1,0)\), \(C=(0,0,1)\) and Triangle 2 with vertices \(D=(0.5,0.5,0)\), \(E=(0.2,0.3,0.5)\), \(F=(0.1,0.1,0.8)\).
        let t1: Triangle = Triangle(v0: simd_float3(x: 1, y: 0, z: 0), v1: simd_float3(x: 0, y: 1, z: 0), v2: simd_float3(x: 0, y: 0, z: 1))
        let t2: Triangle = Triangle(v0: simd_float3(x: 0.5, y: 0.5, z: 0), v1: simd_float3(x: 0.2, y: 0.3, z: 0.5), v2: simd_float3(x: 0.1, y: 0.1, z: 0.8))
        #expect(coplanerCheck(t1, t2))
        let t3: Triangle = Triangle(v0: simd_float3(x: 0, y: 0, z: 0), v1: simd_float3(x: 1, y: 0, z: 0), v2: simd_float3(x: 0, y: 1, z: 0))
        let t4: Triangle = Triangle(v0: simd_float3(x: 0, y: 0, z: 1), v1: simd_float3(x: 1, y: 0, z: 1), v2: simd_float3(x: 0, y: 0.5, z: 1))
        #expect(!coplanerCheck(t3, t4))
        
    }

}
