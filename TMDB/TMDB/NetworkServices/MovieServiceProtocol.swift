//
//  MovieServiceAPI.swift
//  TMDB
//
//  Created by Karim Ihab on 12/02/2024.
//

import Foundation

protocol MovieServiceProtocol {
    func fetchTrendingMovies() async throws -> [Movie]
    func fetchMovieDetails(movieId: Int) async throws -> MovieDetails
}
