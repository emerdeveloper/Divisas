//
//  ByteCoinRate.swift
//  Divisas
//
//  Created by Emerson Javid Gonzalez Morales on 21/05/20.
//  Copyright © 2020 Emerson Javid Gonzalez Morales. All rights reserved.
//

import Foundation

struct ByteCoinRate: Codable {
    let time: String
    let asset_id_base: String
    let asset_id_quote: String
    let rate: Double
}
