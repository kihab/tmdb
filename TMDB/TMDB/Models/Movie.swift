//
//  Movie.swift
//  TMDB
//
//  Created by Karim Ihab on 10/02/2024.
//

import Foundation

struct Movie: Codable, Identifiable {
    let id = UUID()
    let movieId: Int
    let title: String
    let overview: String
    let posterPath: String

    enum CodingKeys: String, CodingKey {
        case title, overview
        case movieId = "id"
        case posterPath = "poster_path"
    }
}

extension Movie {
    static let mock = [
        Movie(movieId: 1, title: "Test title", overview: "Test Overview", posterPath: "Test PosterPath"),
        Movie(movieId: 2, title: "Test title", overview: "Test Overview", posterPath: "Test PosterPath"),
        Movie(movieId: 3, title: "Test title", overview: "Test Overview", posterPath: "Test PosterPath"),
        Movie(movieId: 4, title: "Test title", overview: "Test Overview", posterPath: "Test PosterPath"),
        Movie(movieId: 5, title: "Test title", overview: "Test Overview", posterPath: "Test PosterPath"),
        Movie(movieId: 6, title: "Test title", overview: "Test Overview", posterPath: "Test PosterPath")
    ]
}

