//
//  AvatarUrls.swift
//  Weather
//
//  Created by Gabriel Aguido Fraga on 25/09/19.
//  Copyright © 2019 Cielo. All rights reserved.
//

import Foundation

struct AvatarUrls: Codable {
    
    var the48X48, the24X24, the16X16, the32X32: String?

    enum CodingKeys: String, CodingKey {
        case the48X48 = "48x48"
        case the24X24 = "24x24"
        case the16X16 = "16x16"
        case the32X32 = "32x32"
    }
    
}
