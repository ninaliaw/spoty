//
//  ArtistData.swift
//  spotifyext
//
//  Created by Nina Simone Liaw on 2/18/21.
//

import Foundation

struct ArtistQueryData: Codable {
    let items: [ArtistItemData]
    let total: Int
}

