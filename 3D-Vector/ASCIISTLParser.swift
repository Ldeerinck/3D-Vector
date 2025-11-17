//
//  ASCIISTLParser.swift
//  3D-Vector
//
//  Created by Luke Deerinck on 11/12/25.
//

import Foundation
import simd

enum ASCIISTLError: Error {
    case fileNotFound
    case invalidFormat
    case readError
    case notASCIIFormat
}

/// Parses an ASCII STL file and returns an array of Triangle structs
/// - Parameter url: The file URL of the ASCII STL file
/// - Returns: An array of Triangle structs parsed from the STL file
/// - Throws: ASCIISTLError if the file cannot be read or parsed
func parseASCIISTL(from url: URL) throws -> [Triangle] {
    guard FileManager.default.fileExists(atPath: url.path) else {
        throw ASCIISTLError.fileNotFound
    }
    
    guard let data = try? Data(contentsOf: url) else {
        throw ASCIISTLError.readError
    }
    
    // Verify it's an ASCII STL file (starts with "solid")
    guard let firstBytes = String(data: data.prefix(80), encoding: .ascii),
          firstBytes.trimmingCharacters(in: .whitespaces).lowercased().hasPrefix("solid") else {
        throw ASCIISTLError.notASCIIFormat
    }
    
    return try parseASCIISTLContent(data: data)
}

/// Parses an ASCII STL file from a file path
/// - Parameter path: The file path of the ASCII STL file
/// - Returns: An array of Triangle structs parsed from the STL file
/// - Throws: ASCIISTLError if the file cannot be read or parsed
func parseASCIISTL(from path: String) throws -> [Triangle] {
    let url = URL(fileURLWithPath: path)
    return try parseASCIISTL(from: url)
}

/// Parses ASCII STL content from Data
/// - Parameter data: The data containing the ASCII STL content
/// - Returns: An array of Triangle structs parsed from the STL content
/// - Throws: ASCIISTLError if the content cannot be parsed
private func parseASCIISTLContent(data: Data) throws -> [Triangle] {
    guard let content = String(data: data, encoding: .ascii) else {
        throw ASCIISTLError.invalidFormat
    }
    
    var triangles: [Triangle] = []
    let lines = content.components(separatedBy: .newlines)
    var lineIndex = 0
    
    while lineIndex < lines.count {
        let line = lines[lineIndex].trimmingCharacters(in: .whitespaces)
        
        // Look for "facet normal" which indicates the start of a triangle
        if line.hasPrefix("facet normal") {
            // Move to the next line (should be "outer loop")
            lineIndex += 1
            
            // Skip "outer loop" line if present
            if lineIndex < lines.count {
                let loopLine = lines[lineIndex].trimmingCharacters(in: .whitespaces)
                if loopLine.hasPrefix("outer loop") {
                    lineIndex += 1
                }
            }
            
            var vertices: [simd_float3] = []
            
            // Read three vertices
            while lineIndex < lines.count && vertices.count < 3 {
                let vertexLine = lines[lineIndex].trimmingCharacters(in: .whitespaces)
                if vertexLine.hasPrefix("vertex") {
                    let components = vertexLine.components(separatedBy: .whitespaces)
                        .filter { !$0.isEmpty }
                    
                    if components.count >= 4 {
                        if let x = Float(components[1]),
                           let y = Float(components[2]),
                           let z = Float(components[3]) {
                            vertices.append(simd_float3(x: x, y: y, z: z))
                        }
                    }
                }
                lineIndex += 1
            }
            
            // Create triangle if we have exactly 3 vertices
            if vertices.count == 3 {
                triangles.append(Triangle(v0: vertices[0], v1: vertices[1], v2: vertices[2]))
            }
            
            // Skip to "endfacet"
            while lineIndex < lines.count {
                let line = lines[lineIndex].trimmingCharacters(in: .whitespaces)
                if line == "endfacet" || line.hasPrefix("endfacet") {
                    lineIndex += 1
                    break
                }
                lineIndex += 1
            }
        } else {
            lineIndex += 1
        }
    }
    
    return triangles
}

