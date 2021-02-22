//
//  CurrentTrackData.swift
//  spotifyext
//
//  Created by Nina Simone Liaw on 2/20/21.
//

import Foundation

struct CurrentTrackData: Codable {
    let item: TrackItemData
    let progress_ms: Int
    
}
