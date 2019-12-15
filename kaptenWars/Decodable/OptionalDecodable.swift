//
//  OptionalDecodable.swift
//  kaptenWars
//
//  Created by daniel velasco on 13/12/2019.
//  Copyright © 2019 daniel velasco. All rights reserved.
//

import Foundation

protocol OptionalDecodable: KeyedDecodingContainerProtocol {
    func kapten_decodeOptional<T>(_ type: T.Type, forKey key: Self.Key) -> T? where T: Decodable
}

extension KeyedDecodingContainer: OptionalDecodable {
    func kapten_decodeOptional<T>(_ type: T.Type, forKey key: K) -> T? where T : Decodable {
        do {
            return try decodeIfPresent(type, forKey: key)
        } catch {
            print("Trips decoding problem")
            return nil
        }
    }
}
