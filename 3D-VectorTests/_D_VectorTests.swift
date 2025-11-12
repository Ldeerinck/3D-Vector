//
//  _D_VectorTests.swift
//  3D-VectorTests
//
//  Created by Luke Deerinck on 11/11/25.
//

import Testing
import Spatial
@testable import _D_Vector

struct _D_VectorTests {

    @Test func example() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
    }
    
    @Test func colinearTest() async throws {
        let segment1 = LineSegment(start: Point3D(x: 0, y: 0, z: 0), end: Point3D(x: 1, y: 1, z: 1))
        let segment2 = LineSegment(start: Point3D(x: 2, y: 2, z: 2), end: Point3D(x: 3, y: 3, z: 3))
        #expect(colinearCheck(segment1, segment2))
        let segment3 = LineSegment(start: Point3D(x: 0, y: 0, z: 0), end: Point3D(x: 1, y: 0, z: 0))
        let segment4 = LineSegment(start: Point3D(x: 0, y: 1, z: 0), end: Point3D(x: 0, y: 1, z: 1))
        #expect(!colinearCheck(segment3, segment4))
        let segment5 = LineSegment(start: Point3D(x: -3, y: -3, z: -3), end: Point3D(x: -2, y: -2, z: -2))
        #expect(colinearCheck(segment1, segment5))
        //P1=(1.5,2,3.5)cap P sub 1 equals open paren 1.5 comma 2 comma 3.5 close paren𝑃1=(1.5,2,3.5), \(P_{2}=(2.5,3,4.5)\), \(P_{3}=(3.5,4,5.5)\), and \(P_{4}=(4.5,5,6.5)\).
        let segment6 = LineSegment(start: Point3D(x: 1.5, y: 2, z: 3.5), end: Point3D(x: 2.5, y: 3, z: 4.5))
        let segment7 = LineSegment(start: Point3D(x: 3.5,y: 4,z: 5.5), end: Point3D(x: 4.5,y: 5,z: 6.5))
        #expect(colinearCheck(segment6, segment7))
    }

}
