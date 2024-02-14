//
//  Movie.swift
//  TMDB
//
//  Created by Karim Ihab on 10/02/2024.
//

struct Movie: Codable, Identifiable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String
    let releaseDate: String
    let voteAverage: Double
    let backdropPath: String

    enum CodingKeys: String, CodingKey {
        case id, title, overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case backdropPath = "backdrop_path"
    }
}

extension Movie {
    static let mock = [
        Movie(id: 1, title: "Test title", overview: "Test Overview", posterPath: "", releaseDate: "", voteAverage: 10.0, backdropPath: ""),
        Movie(id: 1, title: "Test title", overview: "Test Overview", posterPath: "", releaseDate: "", voteAverage: 10.0, backdropPath: ""),
        Movie(id: 1, title: "Test title", overview: "Test Overview", posterPath: "", releaseDate: "", voteAverage: 10.0, backdropPath: "")
    ]
}

