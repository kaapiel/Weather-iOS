//
//  JSONCodingKey.swift
//  Weather
//
//  Created by Gabriel Aguido Fraga on 30/09/19.
//  Copyright © 2019 Aguido. All rights reserved.
//

import Foundation

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}
