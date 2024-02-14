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
    let backdropPath: String?
    let belongsToCollection: Collection?
    let budget: Int
    let genres: [Genre]
    let homepage: String?
    let imdbId: String?
    let originalLanguage: String
    let originalTitle: String
    let overview: String
    let popularity: Double
    let posterPath: String
    let productionCompanies: [ProductionCompany]
    let productionCountries: [ProductionCountry]
    let releaseDate: String
    let revenue: Int
    let runtime: Int?
    let spokenLanguages: [SpokenLanguage]
    let status: String
    let tagline: String?
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case id, title, adult, backdropPath = "backdrop_path", belongsToCollection = "belongs_to_collection", budget, genres, homepage, imdbId = "imdb_id", originalLanguage = "original_language", originalTitle = "original_title", overview, popularity, posterPath = "poster_path", productionCompanies = "production_companies", productionCountries = "production_countries", releaseDate = "release_date", revenue, runtime, spokenLanguages = "spoken_languages", status, tagline, video, voteAverage = "vote_average", voteCount = "vote_count"
    }

    struct Genre: Codable {
        let id: Int
        let name: String
    }

    struct Collection: Codable {
        let id: Int
        let name: String
        let posterPath: String?
        let backdropPath: String?
    }

    struct ProductionCompany: Codable {
        let id: Int
        let logoPath: String?
        let name: String
        let originCountry: String

        enum CodingKeys: String, CodingKey {
            case id, logoPath = "logo_path", name, originCountry = "origin_country"
        }
    }

    struct ProductionCountry: Codable {
        let iso3166_1: String
        let name: String

        enum CodingKeys: String, CodingKey {
            case iso3166_1 = "iso_3166_1", name
        }
    }

    struct SpokenLanguage: Codable {
        let englishName: String
        let iso639_1: String
        let name: String

        enum CodingKeys: String, CodingKey {
            case englishName = "english_name", iso639_1 = "iso_639_1", name
        }
    }
}
