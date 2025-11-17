//
//  _D_VectorTests.swift
//  3D-VectorTests
//
//  Created by Luke Deerinck on 11/11/25.
//

import Testing
import simd
import Foundation
import ModelIO
import SceneKit
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
        let segment9 = LineSegment(start: simd_float3(x: 1, y: 1, z: 1), end: simd_float3(x: 3, y: 3, z: 3))
        #expect(colinearCheck(segment1, segment9))
    }
    
    @Test func coplanarTest() async throws {
        //vertices \(A=(1,0,0)\), \(B=(0,1,0)\), \(C=(0,0,1)\) and Triangle 2 with vertices \(D=(0.5,0.5,0)\), \(E=(0.2,0.3,0.5)\), \(F=(0.1,0.1,0.8)\).
        let t1: Triangle = Triangle(v0: simd_float3(x: 1, y: 0, z: 0), v1: simd_float3(x: 0, y: 1, z: 0), v2: simd_float3(x: 0, y: 0, z: 1))
        let t2: Triangle = Triangle(v0: simd_float3(x: 0.5, y: 0.5, z: 0), v1: simd_float3(x: 0.2, y: 0.3, z: 0.5), v2: simd_float3(x: 0.1, y: 0.1, z: 0.8))
        #expect(coplanerCheck(t1, t2))
        let t3: Triangle = Triangle(v0: simd_float3(x: 0, y: 0, z: 0), v1: simd_float3(x: 1, y: 0, z: 0), v2: simd_float3(x: 0, y: 1, z: 0))
        let t4: Triangle = Triangle(v0: simd_float3(x: 0, y: 0, z: 1), v1: simd_float3(x: 1, y: 0, z: 1), v2: simd_float3(x: 0, y: 0.5, z: 1))
        #expect(!coplanerCheck(t3, t4))
        //Triangle 1 with vertices \(\mathbf{(0.1,0.2,0.5)}\), \(\mathbf{(2.3,0.4,0.5)}\), \(\mathbf{(1.5,3.1,0.5)}\), and Triangle 2 with vertices \(\mathbf{(1.5,3.1,0.5)}\), \(\mathbf{(0.8,1.1,0.5)}\), \(\mathbf{(3.2,2.5,0.5)}\)
        let t5: Triangle = Triangle(v0: simd_float3(x: 0.1, y: 0.2, z: 0.5), v1: simd_float3(x: 2.3, y: 0.4, z: 0.5), v2: simd_float3(x: 1.5, y: 3.1, z: 0.5))
        let t6: Triangle = Triangle(v0: simd_float3(x: 1.5, y: 3.1, z: 0.5), v1: simd_float3(x: 0.8, y: 1.1, z: 0.5), v2: simd_float3(x: 3.2, y: 2.5, z: 0.5))
        #expect(coplanerCheck(t5, t6))
        
    }
    
    @Test func colinearTimeTest() async throws {
        let segment1 = LineSegment(start: simd_float3(x: 0, y: 0, z: 0), end: simd_float3(x: 1, y: 1, z: 1))
        let segment2 = LineSegment(start: simd_float3(x: 2, y: 2, z: 2), end: simd_float3(x: 3, y: 3, z: 3))
        let startTime = Date()
        var count = 0;
        while(Date().timeIntervalSince(startTime) < 1.0)
        {
            colinearCheck(segment1, segment2)
            count+=1;
        }
        print(count)
        
    }
    
    @Test func coplanerCheckPerformanceTest() async throws {
        let t1: Triangle = Triangle(v0: simd_float3(x: 1, y: 0, z: 0), v1: simd_float3(x: 0, y: 1, z: 0), v2: simd_float3(x: 0, y: 0, z: 1))
        let t2: Triangle = Triangle(v0: simd_float3(x: 0.5, y: 0.5, z: 0), v1: simd_float3(x: 0.2, y: 0.3, z: 0.5), v2: simd_float3(x: 0.1, y: 0.1, z: 0.8))
        let startTime = Date()
        var count = 0;
        while(Date().timeIntervalSince(startTime) < 1.0)
        {
            coplanerCheck(t1, t2)
            count+=1;
        }
        print(count)
    }
    
    @Test func parseASCIISTLFromURLTest() async throws {
        // Replace this URL with the actual ASCII STL file URL you want to test
        guard let url = URL(string: "https://people.sc.fsu.edu/~jburkardt/data/stla/block100.stl") else {
            throw TestError.invalidURL
        }
        
        // Download the file to a temporary location
        let (data, _) = try await URLSession.shared.data(from: url)
        let tempDir = FileManager.default.temporaryDirectory
        let tempFile = tempDir.appendingPathComponent(UUID().uuidString).appendingPathExtension("stl")
        
        try data.write(to: tempFile)
        defer {
            // Clean up temporary file
            try? FileManager.default.removeItem(at: tempFile)
        }
        
        // Parse the ASCII STL file
        let triangles = try parseASCIISTL(from: tempFile)
        
        // Verify that triangles were parsed
        #expect(triangles.count > 0, "Expected to parse at least one triangle from the STL file")
        
        // Verify that each triangle has valid vertices
        for triangle in triangles {
            #expect(!triangle.v0.x.isNaN && !triangle.v0.y.isNaN && !triangle.v0.z.isNaN, "Triangle v0 should have valid coordinates")
            #expect(!triangle.v1.x.isNaN && !triangle.v1.y.isNaN && !triangle.v1.z.isNaN, "Triangle v1 should have valid coordinates")
            #expect(!triangle.v2.x.isNaN && !triangle.v2.y.isNaN && !triangle.v2.z.isNaN, "Triangle v2 should have valid coordinates")
        }
        
        print("Successfully parsed \(triangles.count) triangles from ASCII STL file")
    }
    
    enum TestError: Error {
        case invalidURL
    }

}
