//
//  MovieDetails.swift
//  TMDB
//
//  Created by Karim Ihab on 12/02/2024.
//

struct MovieDetails: Codable, Identifiable {
    let id: Int
    let title: String
    let adult: Bool
    let budget: Int
    let genres: [Genre]
    let overview: String
    let posterPath: String
    let releaseDate: String
    let runtime: Int?

    enum CodingKeys: String, CodingKey {
        case id, title, adult,
             budget, genres, overview,
             posterPath = "poster_path",
             releaseDate = "release_date", runtime
    }

    struct Genre: Codable {
        let id: Int
        let name: String
    }
}

extension MovieDetails {
    static let mock = MovieDetails(id: 111, title: "Test Movie Details",
                                   adult: false, budget: 100,
                                   genres: [Genre(id: 1, name: "")], overview: "Test Movie Details Overview",
                                   posterPath: "Test Movie Details", releaseDate: "200", runtime: nil)
}
