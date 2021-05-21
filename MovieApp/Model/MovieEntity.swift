//
//  MovieEntity.swift
//  MovieApp
//
//  Created by Otebay Akan on 25.04.2021.
//

import Foundation

struct MovieEntity: Decodable {
    let results: [Movie]
    
    struct Movie: Decodable {
        let id: Int
        let poster: String?
        let title: String?
        let releaseDate: String?
        let rating: Double
    
    
        enum CodingKeys: String, CodingKey {
            case id
            case poster = "poster_path"
            case title = "original_title"
            case releaseDate = "release_date"
            case rating = "vote_average"
        }
    }
}
