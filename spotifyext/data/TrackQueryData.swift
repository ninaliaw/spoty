//
//  TrackQueryData.swift
//  spotifyext
//
//  Created by Nina Simone Liaw on 2/18/21.
//

import Foundation

struct TrackQueryData: Codable {
    let items: [TrackItemData]
    let total: Int
}
