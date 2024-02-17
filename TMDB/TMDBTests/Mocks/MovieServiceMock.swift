//
//  MovieServiceMock.swift
//  TMDBTests
//
//  Created by Karim Ihab on 16/02/2024.
//

import Foundation
@testable import TMDB

class MovieServiceMock: MovieServiceProtocol {
    var moviesToReturn: [Movie] = []
    var movieDetailsToReturn: MovieDetails?
    var errorToThrow: Error?
    
    func fetchTrendingMovies(page: Int) async throws -> [Movie] {
        if let error = errorToThrow {
            throw error
        }
        return moviesToReturn
    }
    
    func fetchMovieDetails(movieId: Int) async throws -> MovieDetails {
        if let error = errorToThrow {
            throw error
        }
        guard let movieDetailsToReturn = movieDetailsToReturn else {
            throw NSError(domain: "TestError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Movie details not set"])
        }
        return movieDetailsToReturn
    }
}
