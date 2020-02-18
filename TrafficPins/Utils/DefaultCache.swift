//
//  DefaultCache.swift
//  Innerfire
//
//  Created by Xavi Pedrals | The Mobile Company on 25/07/2019.
//  Copyright © 2019 Deckeron. All rights reserved.
//

import Foundation

class DefaultCache<T: Codable> {
    
    func save(obj: T, fileName: String) {
        guard let encodedData = try? JSONEncoder().encode(obj),
            let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let url = dir.appendingPathComponent(fileName)
        do {
            try encodedData.write(to: url)
        } catch {
            print("Failed to write JSON data: \(error.localizedDescription)")
        }
    }
    
    func fetch(fileName: String) -> T? {
        guard let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        let url = dir.appendingPathComponent(fileName)
        do {
            let data = try Data(contentsOf: url, options: .mappedIfSafe)
            let parser = Parser<T>()
            let result = parser.parse(data: data)
            switch result {
            case .success(let config):
                return config
            case .failure(let error):
                throw error
            }
        } catch {
            print(error)
            return nil
        }
    }
}
