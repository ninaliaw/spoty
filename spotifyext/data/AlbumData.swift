//
//  AlbumData.swift
//  spotifyext
//
//  Created by Nina Simone Liaw on 2/18/21.
//

import Foundation

struct AlbumData: Codable {
    let artists: [ArtistData]
    let images: [ImageData]
    let name: String
    
}

