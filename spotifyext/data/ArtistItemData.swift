//
//  ItemData.swift
//  spotifyext
//
//  Created by Nina Simone Liaw on 2/18/21.
//

import Foundation

struct ArtistItemData: Codable {
    let id: String
    let images: [ImageData]
    let name: String
    let type: String
}
