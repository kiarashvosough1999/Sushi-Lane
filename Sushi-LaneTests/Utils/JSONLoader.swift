//
//  JSONLoader.swift
//  Sushi-LaneTests
//
//  Created by Kiarash Vosough on 8/8/23.
//

import Foundation

enum JSONLoaderError: Error {
    case jsonNotFound
    case dataConversionFailed
}

protocol JSONLoader {}

fileprivate class BundleTest {}

extension JSONLoader {

    public func loadJSON<D>(
        name: String,
        as modelType: D.Type,
        inside bundleInstance: Bundle = Bundle(for: BundleTest.self)
    ) throws -> D where D: Decodable {
        guard
            let pathURL = bundleInstance.url(forResource: name, withExtension: "json")
        else {
            throw JSONLoaderError.jsonNotFound
        }

        guard let data = try? Data(contentsOf: pathURL) else {
            throw JSONLoaderError.dataConversionFailed
        }

        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return try decoder.decode(D.self, from: data)
    }
}

