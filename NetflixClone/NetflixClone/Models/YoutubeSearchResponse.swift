//
//  YoutubeSearchResponse.swift
//  NetflixClone
//
//  Created by AMAR on 10/01/24.
//

import Foundation


struct YoutubeSearchResponse: Codable{
    let items:[VideoElement]
}

struct VideoElement: Codable{
    let id: IDVideoElement
}

struct IDVideoElement: Codable{
    let kind: String
    let videoId: String
}
