//
//  ModelData.swift
//  Landmarks
//
//  Created by 석민솔 on 12/5/23.
//

import Foundation

@Observable
class ModelData {
    var landmarks: [Landmark] = load("landmarkData.json")
    var hikes: [Hike] = load("hikeData.json")
    // user profile that persists even after the user dismisses the profile view.
    var profile = Profile.default
    
    // add a new computed features array, which conatins only the landmarks that have isFeatured set to true
    var features: [Landmark] {
        landmarks.filter{ $0.isFeatured }
    }
    
    // add a computed categories dictionary, with category names as keys, and an array of associated landmarks for each key
    var categories: [String: [Landmark]] {
        Dictionary(
            grouping: landmarks,
            by: { $0.category.rawValue }
        )
    }
}


func load<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
