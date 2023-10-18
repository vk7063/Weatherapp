//
//  SearchResultModel.swift
//  Weather
//
//  Created by vinod on 13/03/23.
//

import Foundation

struct SearchResultModel: Codable {
    let name: String?
    let lat: Double?
    let lon: Double?
    let country: String?
    let state: String?
}
