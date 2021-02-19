//
//  TrackItemData.swift
//  spotifyext
//
//  Created by Nina Simone Liaw on 2/18/21.
//

import Foundation

struct TrackItemData: Codable {
    let album: AlbumData
    let artists: [ArtistData]
    let name: String
    let duration_ms: Int
}
