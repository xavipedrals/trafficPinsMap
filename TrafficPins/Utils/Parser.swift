//
//  Parser.swift
//  TrafficPins
//
//  Created by Xavi Pedrals | The Mobile Company on 18/02/2020.
//  Copyright © 2020 xavi. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(Error)
}

class Parser<T: Decodable> {
    
    var dateFormat: JSONDecoder.DateDecodingStrategy?
    
    //Sigle fire parse
    static func parse(data: Data) -> Result<T> {
        let parser = Parser<T>()
        let decoder = parser.getDecoder()
        do {
            let parsedObj = try decoder.decode(T.self, from: data)
            return .success(parsedObj)
        } catch {
            return .failure(error)
        }
    }
    
    func parse(data: Data) -> Result<T> {
        let decoder = getDecoder()
        do {
            let parsedObj = try decoder.decode(T.self, from: data)
            return .success(parsedObj)
        } catch {
            return .failure(error)
        }
    }
    
    private func getDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        if let dateFormat = dateFormat {
            decoder.dateDecodingStrategy = dateFormat
        }
        return decoder
    }
}
